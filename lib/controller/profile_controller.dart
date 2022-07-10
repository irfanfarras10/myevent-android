import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_request/update_profile_api_request_model.dart';
import 'package:myevent_android/model/api_response/api_response_model.dart';
import 'package:myevent_android/model/api_response/view_profile_api_response.model.dart';
import 'package:myevent_android/provider/api_profile.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ApiController {
  final organizerNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final organizerNameErrorMessage = RxnString();
  final emailErrorMessage = RxnString();
  final phoneNumberErrorMessage = RxnString();

  final organizerNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();

  bool isUsernameValid = true;
  bool isOrganizerNameValid = true;
  bool isEmailValid = true;
  bool isPhoneNumberValid = true;

  final editMode = false.obs;

  final hidePassword = true.obs;

  final isLoadProfileData = true.obs;
  final isLoadUpdateData = false.obs;

  ViewProfileApiResponse? profileData;

  bool get isFormValid =>
      isUsernameValid &&
      isOrganizerNameValid &&
      isEmailValid &&
      isPhoneNumberValid;

  bool get isUpdateBtnEnable {
    if ((editMode.value && !isFormValid) || isLoadUpdateData.value) {
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void resetState() {
    errorMessage = null;

    organizerNameErrorMessage.value = null;
    emailErrorMessage.value = null;
    phoneNumberErrorMessage.value = null;

    organizerNameFocusNode.unfocus();
    emailFocusNode.unfocus();
    phoneNumberFocusNode.unfocus();

    isLoadUpdateData.value = false;
    editMode.value = false;
  }

  void validateOrganizerName(String organizerName) {
    errorMessage = null;
    isOrganizerNameValid = false;
    if (organizerName.isEmpty) {
      organizerNameErrorMessage.value = 'Nama event organizer harus diisi';
    } else if (organizerName.length > 50) {
      organizerNameErrorMessage.value =
          'Nama event organizer maksimal 50 karakter';
    } else {
      organizerNameErrorMessage.value = null;
      isOrganizerNameValid = true;
    }
  }

  void validateEmail(String email) {
    errorMessage = null;
    isEmailValid = false;
    if (email.isEmpty) {
      emailErrorMessage.value = 'Email harus diisi';
    } else if (!email.isEmail) {
      emailErrorMessage.value = 'Format e-mail tidak valid';
    } else {
      emailErrorMessage.value = null;
      isEmailValid = true;
    }
  }

  void validatePhoneNumber(String phoneNumber) {
    errorMessage = null;
    isPhoneNumberValid = false;
    if (phoneNumber.isEmpty) {
      phoneNumberErrorMessage.value = 'Nomor HP harus diisi';
    } else if (!RegExp(
            r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
        .hasMatch(phoneNumber)) {
      phoneNumberErrorMessage.value = 'Nomor HP tidak valid';
    } else {
      phoneNumberErrorMessage.value = null;
      isPhoneNumberValid = true;
    }
  }

  Future<void> updateProfile() async {
    if (!editMode.value) {
      editMode.value = true;
      Future.delayed(Duration(milliseconds: 100)).then(
        (_) => organizerNameFocusNode.requestFocus(),
      );
    } else if (editMode.value) {
      isLoadUpdateData.value = true;

      final updateProfileApiRequest = UpdateProfileApiRequestModel.fromJson({
        'organizerName': organizerNameController.text,
        'email': emailController.text,
        'phoneNumber': phoneNumberController.text
      });

      apiProfile.updateProfile(requestBody: updateProfileApiRequest).then(
        (response) {
          checkApiResponse(response);

          if (apiResponseState.value == ApiResponseState.http2xx) {
            final updateProfileApiResponse = ApiResponseModel.fromJson(
              response,
            );

            Get.defaultDialog(
              title: updateProfileApiResponse.message!,
              content: Icon(
                Icons.check,
                size: 50.0,
                color: Colors.green,
              ),
              textConfirm: 'OK',
              confirmTextColor: MyEventColor.secondaryColor,
              barrierDismissible: false,
              onConfirm: () async {
                Get.back();
                resetState();
                await loadData();
              },
            );
          }
        },
      );
    }
  }

  Future<void> logout() async {
    Get.defaultDialog(
      title: 'Keluar Akun',
      content: Text('Apakah Anda Ingin keluar akun?'),
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: MyEventColor.secondaryColor,
      barrierDismissible: false,
      onConfirm: () async {
        final prefs = await SharedPreferences.getInstance();
        FirebaseMessaging.instance.unsubscribeFromTopic(
          prefs.getString('myevent.auth.token.subject')!,
        );
        prefs.remove('myevent.auth.token');
        Get.offAllNamed(RouteName.signInScreen);
      },
    );
  }

  Future<void> loadData() async {
    isLoadProfileData.value = true;
    await apiProfile.viewProfile().then(
      (response) {
        checkApiResponse(response);

        if (apiResponseState.value != ApiResponseState.http401) {
          isLoadProfileData.value = false;
          profileData = ViewProfileApiResponse.fromJson(response);

          organizerNameController.text = profileData!.organizerName!;
          emailController.text = profileData!.email!;
          phoneNumberController.text = profileData!.phoneNumber!;
        }
      },
    );
  }
}
