import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/model/api_response/view_participant_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:myevent_android/provider/api_participant.dart';

class ParticipantController extends ApiController {
  RxInt menuCategoryIndex = RxInt(0);
  RxnInt menuSubCategoryIndex = RxnInt();

  RxnInt publishRegistrationIndex = RxnInt();

  RxBool isLoading = RxBool(true);
  RxBool isLoadingParticipantData = RxBool(false);

  final _eventId = int.parse(Get.parameters['id']!);

  ViewEventDetailApiResponseModel? eventData;

  ViewParticipantApiResponseModel? participantData;

  RxList<ListParticipant> dataList = RxList<ListParticipant>();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void resetState() {
    isLoading.value = true;
  }

  Future<void> loadData() async {
    resetState();
    await apiEvent.getEventDetail(id: _eventId).then(
      (response) async {
        checkApiResponse(response);
        if (apiResponseState.value == ApiResponseState.http2xx) {
          eventData = ViewEventDetailApiResponseModel.fromJson(response);
          isLoading.value = false;

          if (eventData!.eventStatus!.id! == 2) {
            publishRegistrationIndex.value = 0;
          }

          loadParticipantData();
        }
      },
    );
  }

  Future<void> loadParticipantData() async {
    isLoadingParticipantData.value = true;
    if (publishRegistrationIndex.value == 0) {
      getConfirmedParticipant();
    } else if (publishRegistrationIndex.value == 1) {
      getWaitingParticipant();
    }
  }

  Future<void> getWaitingParticipant() async {
    await apiParticipant.getParticipantWait(_eventId).then(
      (participantResponse) {
        checkApiResponse(participantResponse);
        if (apiResponseState.value == ApiResponseState.http2xx) {
          participantData =
              ViewParticipantApiResponseModel.fromJson(participantResponse);

          dataList.value = participantData!.listParticipant!;

          isLoadingParticipantData.value = false;
        }
      },
    );
  }

  Future<void> getConfirmedParticipant() async {
    await apiParticipant.getParticipantConfirmed(_eventId).then(
      (participantResponse) {
        checkApiResponse(participantResponse);
        if (apiResponseState.value == ApiResponseState.http2xx) {
          participantData =
              ViewParticipantApiResponseModel.fromJson(participantResponse);

          dataList.value = participantData!.listParticipant!;

          isLoadingParticipantData.value = false;
        }
      },
    );
  }

  void searchEvent(String keyword) {
    if (keyword.isEmpty) {
      dataList.value = participantData!.listParticipant!;
    } else {
      final searchList = dataList
          .where(
            (participant) => participant.name!
                .toLowerCase()
                .isCaseInsensitiveContainsAny(keyword),
          )
          .toList();
      dataList.value = searchList;
    }
  }
}
