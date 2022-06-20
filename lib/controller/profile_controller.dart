import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_profile_api_response.model.dart';
import 'package:myevent_android/provider/api_profile.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ApiController {
  final usernameController = TextEditingController();
  final organizerNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final usernameErrorMessage = RxnString();
  final organizerNameErrorMessage = RxnString();
  final emailErrorMessage = RxnString();
  final phoneNumberErrorMessage = RxnString();

  final usernameFocusNode = FocusNode();
  final organizerNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();

  bool isUsernameValid = false;
  bool isOrganizerNameValid = false;
  bool isEmailValid = false;
  bool isPhoneNumberValid = false;

  final editMode = false.obs;

  final hidePassword = true.obs;

  final isLoadProfileData = true.obs;
  final isLoadUpdateData = true.obs;

  ViewProfileApiResponse? profileData;

  bool get isFormValid =>
      isUsernameValid &&
      isOrganizerNameValid &&
      isEmailValid &&
      isPhoneNumberValid;

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void resetState() {
    errorMessage = null;

    usernameErrorMessage.value = null;
    organizerNameErrorMessage.value = null;
    emailErrorMessage.value = null;
    phoneNumberErrorMessage.value = null;

    usernameFocusNode.unfocus();
    organizerNameFocusNode.unfocus();
    emailFocusNode.unfocus();
    phoneNumberFocusNode.unfocus();
  }

  void validateUsername(String username) {
    errorMessage = null;
    isUsernameValid = false;
    if (username.isEmpty) {
      usernameErrorMessage.value = 'Username harus diisi';
    } else if (username.contains(' ')) {
      usernameErrorMessage.value = 'Username tidak boleh mengandung spasi';
    } else if (RegExp('[A-Z]').hasMatch(username)) {
      usernameErrorMessage.value = 'Username tidak boleh kapital';
    } else if (username.length < 8) {
      usernameErrorMessage.value = 'Username minimal 8 karakter';
    } else if (username.length > 20) {
      usernameErrorMessage.value = 'Username maksimal 20 karakter';
    } else if (!RegExp(r'^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$')
        .hasMatch(username)) {
      usernameErrorMessage.value = 'Format username tidak valid';
    } else {
      usernameErrorMessage.value = null;
      isUsernameValid = true;
    }
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

  void Function()? onPressedEditButton() {
    if (editMode.value && !isFormValid) {
      return null;
    }
    return () {
      if (!editMode.value) {
        editMode.value = true;
        Future.delayed(Duration(milliseconds: 100)).then(
          (_) => usernameFocusNode.requestFocus(),
        );
      }
    };
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
        prefs.remove('myevent.auth.token');
        Get.offAllNamed(RouteName.signInScreen);
      },
    );
  }

  Future<void> loadData() async {
    isLoadProfileData.value = true;
    await apiProfile.viewProfile().then(
      (response) {
        checkApResponse(response);

        isLoadProfileData.value = false;

        if (apiResponseState.value == ApiResponseState.http2xx) {
          profileData = ViewProfileApiResponse.fromJson(response);

          usernameController.text = profileData!.username!;
          organizerNameController.text = profileData!.organizerName!;
          emailController.text = profileData!.email!;
          phoneNumberController.text = profileData!.phoneNumber!;
        }
      },
    );
  }
}
