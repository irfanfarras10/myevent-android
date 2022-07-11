import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_request/create_event_guest_api_request_model.dart';
import 'package:myevent_android/model/api_response/view_event_detail_api_response_model.dart';
import 'package:myevent_android/model/api_response/view_guest_list_api_response_mode.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:myevent_android/provider/api_guest.dart';

class GuestController extends ApiController {
  List<ListGuest> guestData = [];
  RxBool isLoading = RxBool(false);
  int _eventId = int.parse(Get.parameters['id']!);
  ViewEventDetailApiResponseModel? eventData;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  RxBool isNameValid = RxBool(false);
  RxBool isEmailValid = RxBool(false);
  RxBool isPhoneNumberValid = RxBool(false);

  RxnString nameErrorMessage = RxnString();
  RxnString emailErrorMessage = RxnString();
  RxnString phoneNumberErrorMessage = RxnString();

  final bool canEdit = Get.arguments['canEdit'];

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void resetState() {
    isLoading.value = true;
    guestData.clear();
  }

  bool get isAllDataValid {
    return isNameValid.value && isEmailValid.value && isPhoneNumberValid.value;
  }

  void validateName(String name) {
    if (name.isEmpty) {
      isNameValid.value = false;
      nameErrorMessage.value = 'Nama harus diisi';
    } else {
      isNameValid.value = true;
      nameErrorMessage.value = null;
    }
  }

  void validateEmail(String email) {
    if (email.isEmpty) {
      isEmailValid.value = false;
      emailErrorMessage.value = 'Email harus diisi';
    } else if (!email.isEmail) {
      isEmailValid.value = false;
      emailErrorMessage.value = 'Email tidak valid';
    } else {
      isEmailValid.value = true;
      emailErrorMessage.value = null;
    }
  }

  void validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      isPhoneNumberValid.value = false;
      phoneNumberErrorMessage.value = 'Nomor telepon harus diisi';
    } else if (!phoneNumber.isPhoneNumber) {
      isPhoneNumberValid.value = false;
      phoneNumberErrorMessage.value = 'Nomor HP tidak valid';
    } else {
      isPhoneNumberValid.value = true;
      phoneNumberErrorMessage.value = null;
    }
  }

  Future<void> loadData() async {
    resetState();
    await apiEvent.getEventDetail(id: _eventId).then((eventResponse) async {
      checkApiResponse(eventResponse);
      if (apiResponseState.value == ApiResponseState.http2xx) {
        eventData = ViewEventDetailApiResponseModel.fromJson(eventResponse);
        await apiGuest.getGuest(id: _eventId).then((guestResponse) async {
          checkApiResponse(guestResponse);
          if (apiResponseState.value == ApiResponseState.http2xx) {
            isLoading.value = false;
            final data = ViewGuestListApiResponseModel.fromJson(guestResponse);
            guestData = data.listGuest!;

            if (canEdit) {
              nameController.text =
                  eventData!.eventGuest![Get.arguments['guestIndex']].name!;
              emailController.text =
                  eventData!.eventGuest![Get.arguments['guestIndex']].email!;
              phoneNumberController.text = eventData!
                  .eventGuest![Get.arguments['guestIndex']].phoneNumber!
                  .toString();

              isNameValid.value = true;
              isEmailValid.value = true;
              isPhoneNumberValid.value = true;
            }
          }
        });
      }
    });
  }

  Future<void> inviteAllGuest() async {
    Get.defaultDialog(
      title: 'Kirim Email Undangan',
      content: Text(
          'Apakah Anda ingin mengirim email undangan ke daftar tamu yang ada?'),
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: MyEventColor.secondaryColor,
      barrierDismissible: false,
      onConfirm: () async {
        Get.back();
        Get.dialog(
          AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 15.0),
                Text('Mengirim undangan ...'),
              ],
            ),
          ),
          barrierDismissible: false,
        );
        apiGuest.inviteAllGuest(id: _eventId).then(
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
                      'Email Undangan Terkirim',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: MyEventColor.secondaryColor,
                      ),
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
                },
              );
            }
          },
        );
      },
    );
  }

  Future<void> createGuest() async {
    final apiRequest = CreateEventGuestApiRequestModel.fromJson({
      'name': nameController.text,
      'phoneNumber': phoneNumberController.text,
      'email': emailController.text,
    });

    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 15.0),
            Text('Menyimpan Data ...'),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    await apiGuest.createGuest(data: apiRequest, id: _eventId).then(
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
                  'Data Tersimpan',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: MyEventColor.secondaryColor,
                  ),
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
              Get.back(result: true);
            },
          );
        } else {
          Get.back();
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
            },
          );
        }
      },
    );
  }

  Future<void> updateGuest(int index) async {
    final apiRequest = CreateEventGuestApiRequestModel.fromJson({
      'name': nameController.text,
      'phoneNumber': phoneNumberController.text,
      'email': emailController.text,
    });

    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 25.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 15.0),
            Text('Menyimpan Data ...'),
          ],
        ),
      ),
      barrierDismissible: false,
    );

    await apiGuest
        .updateGuest(
      data: apiRequest,
      guestId: eventData!.eventGuest![index].id!,
      eventId: _eventId,
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
                  'Data Tersimpan',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: MyEventColor.secondaryColor,
                  ),
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
              Get.back(result: true);
            },
          );
        } else {
          Get.back();
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
            },
          );
        }
      },
    );
  }
}
