import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/controller/view_controller.dart';
import 'package:myevent_android/model/signin_api_response_model.dart';
import 'package:myevent_android/provider/api_auth.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ViewController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameErrorMessage = RxnString();
  final passwordErrorMessage = RxnString();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  RxBool showPassword = RxBool(true);
  bool isUsernameValid = false;
  bool isPasswordValid = false;
  RxBool isLoading = false.obs;

  bool get isFormValid => isUsernameValid && isPasswordValid;

  @override
  void resetState() {
    errorMessage = null;
    usernameErrorMessage.value = null;
    passwordErrorMessage.value = null;
    usernameFocusNode.unfocus();
    passwordFocusNode.unfocus();
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

  void validatePassword(String password) {
    errorMessage = null;
    isPasswordValid = false;
    if (password.isEmpty) {
      passwordErrorMessage.value = 'Kata sandi harus diisi';
    } else if (password.length < 8) {
      passwordErrorMessage.value = 'Kata sandi minimal 8 karakter';
    } else if (!RegExp('(?=.*?[A-Z][a-z])').hasMatch(password)) {
      passwordErrorMessage.value =
          'Kata sandi harus terdapat huruf besar dan huruf kecil';
    } else {
      passwordErrorMessage.value = null;
      isPasswordValid = true;
    }
  }

  Future<void> signIn() async {
    resetState();
    isLoading.value = true;
    apiAuth.signIn({
      'username': usernameController.text,
      'password': passwordController.text,
    }).then(
      (response) async {
        SignInApiResponseModel signInApiResponse =
            SignInApiResponseModel.fromJson(response);
        checkApResponse(response);
        if (apiResponseState.value != ApiResponseState.http2xx) {
          errorMessage = response['message'];
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('myevent.auth.token', signInApiResponse.token!);
          Get.offAllNamed(RouteName.mainScreen);
        }
        isLoading.value = false;
      },
    );
  }

  void gotoSignUpScreen() {
    Get.offAllNamed(RouteName.signUpScreen);
  }
}
