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

          if (publishRegistrationIndex.value == 0) {
            isLoadingParticipantData.value = true;
            getWaitingConfirmationParticipant();
          }
        }
      },
    );
  }

  Future<void> getWaitingConfirmationParticipant() async {
    await apiParticipant.getParticipantWait(_eventId).then(
      (participantResponse) {
        checkApiResponse(participantResponse);
        if (apiResponseState.value == ApiResponseState.http2xx) {
          participantData =
              ViewParticipantApiResponseModel.fromJson(participantResponse);
          isLoadingParticipantData.value = false;
        }
      },
    );
  }
}
