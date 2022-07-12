import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/participant_detail_api_response_model.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/model/api_response/view_participant_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:myevent_android/provider/api_participant.dart';

class ParticipantController extends ApiController {
  RxInt menuIndex = RxInt(0);

  RxBool isLoading = RxBool(true);
  RxBool isLoadingParticipantData = RxBool(false);
  RxBool isLoadingGetParticipantDetailData = RxBool(false);

  ParticipantDetailApiResponseModel? participantDetailData;

  final _eventId = int.parse(Get.parameters['id']!);

  ViewEventDetailApiResponseModel? eventData;

  ViewParticipantApiResponseModel? participantData;

  RxList<ListParticipant> dataList = RxList<ListParticipant>();

  TextEditingController rejectionReasonController = TextEditingController();
  RxBool isRejectionReasonValid = RxBool(false);
  RxnString rejectionReasonErrorMessage = RxnString();

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

          loadParticipantData();
        }
      },
    );
  }

  Future<void> loadParticipantData() async {
    isLoadingParticipantData.value = true;
    if (menuIndex.value == 0) {
      getConfirmedParticipant();
    } else if (menuIndex.value == 1) {
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

  Future<void> getWaitingConfirmationParticipantDetail(int index) async {
    isLoadingGetParticipantDetailData.value = true;
    await apiParticipant
        .getDetailParticipantWait(
      eventId: _eventId,
      participantId: dataList[index].id,
    )
        .then((response) {
      checkApiResponse(response);
      if (apiResponseState.value != ApiResponseState.http401) {
        participantDetailData =
            ParticipantDetailApiResponseModel.fromJson(response);
        isLoadingGetParticipantDetailData.value = false;
      }
    });
  }

  void rejectPayment(int index) async {
    Get.back();
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 15.0),
            Text('Tunggu Sebentar ...'),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    await apiParticipant
        .rejectPayment(
      eventId: _eventId,
      participantId: dataList[index].id!,
      message: rejectionReasonController.text,
    )
        .then(
      (response) {
        checkApiResponse(response);
        if (apiResponseState.value == ApiResponseState.http2xx) {
          Get.back();
          Get.defaultDialog(
            titleStyle: TextStyle(
              fontSize: 0.0,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Penolakan atas nama ${dataList[index].name} berhasil dikirimkan melalui email',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: MyEventColor.secondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.check,
                  size: 50.0,
                  color: Colors.green,
                ),
              ],
            ),
            textConfirm: 'OK',
            confirmTextColor: MyEventColor.secondaryColor,
            barrierDismissible: false,
            onConfirm: () {
              Get.back();
              Get.back();
              loadParticipantData();
            },
          );
        } else {
          Get.defaultDialog(
            titleStyle: TextStyle(
              fontSize: 0.0,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Terjadi Kesalahan',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: MyEventColor.secondaryColor,
                  ),
                ),
                Icon(
                  Icons.close,
                  size: 50.0,
                  color: Colors.red,
                ),
              ],
            ),
            textConfirm: 'OK',
            confirmTextColor: MyEventColor.secondaryColor,
            barrierDismissible: false,
            onConfirm: () {
              Get.back();
              Get.back();
              loadParticipantData();
            },
          );
        }
      },
    );
  }

  void confirmPayment(int index) async {
    Get.back();
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 15.0),
            Text('Tunggu Sebentar ...'),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    await apiParticipant
        .confirmPayment(eventId: _eventId, participantId: dataList[index].id!)
        .then(
      (response) {
        checkApiResponse(response);
        if (apiResponseState.value == ApiResponseState.http2xx) {
          Get.back();
          Get.defaultDialog(
            titleStyle: TextStyle(
              fontSize: 0.0,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pembayaran atas nama ${dataList[index].name} berhasil di setujui',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: MyEventColor.secondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Icon(
                  Icons.check,
                  size: 50.0,
                  color: Colors.green,
                ),
              ],
            ),
            textConfirm: 'OK',
            confirmTextColor: MyEventColor.secondaryColor,
            barrierDismissible: false,
            onConfirm: () {
              Get.back();
              Get.back();
              loadParticipantData();
            },
          );
        } else {
          Get.defaultDialog(
            titleStyle: TextStyle(
              fontSize: 0.0,
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Terjadi Kesalahan',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: MyEventColor.secondaryColor,
                  ),
                ),
                Icon(
                  Icons.close,
                  size: 50.0,
                  color: Colors.red,
                ),
              ],
            ),
            textConfirm: 'OK',
            confirmTextColor: MyEventColor.secondaryColor,
            barrierDismissible: false,
            onConfirm: () {
              Get.back();
              Get.back();
              loadParticipantData();
            },
          );
        }
      },
    );
  }

  void validateRejectionMessage(String message) {
    if (message.isEmpty) {
      isRejectionReasonValid.value = false;
      rejectionReasonErrorMessage.value = 'Alasan harus diisi';
    } else {
      isRejectionReasonValid.value = true;
      rejectionReasonErrorMessage.value = null;
    }
  }
}
