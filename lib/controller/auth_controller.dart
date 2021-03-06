import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_request/signin_api_request_model.dart';
import 'package:myevent_android/model/api_request/signup_api_request_model.dart';
import 'package:myevent_android/model/api_response/api_response_model.dart';
import 'package:myevent_android/model/api_response/signin_api_response_model.dart';
import 'package:myevent_android/provider/api_auth.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/util/jwt_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ApiController {
  final usernameController = TextEditingController();
  final organizerNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final usernameErrorMessage = RxnString();
  final organizerNameErrorMessage = RxnString();
  final emailErrorMessage = RxnString();
  final passwordErrorMessage = RxnString();
  final phoneNumberErrorMessage = RxnString();

  final usernameFocusNode = FocusNode();
  final organizerNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();

  bool isUsernameValid = false;
  bool isOrganizerNameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isPhoneNumberValid = false;

  RxBool hidePassword = RxBool(true);
  RxBool isLoading = false.obs;

  bool get isSignInFormValid => isUsernameValid && isPasswordValid;

  bool get isSignUpFormValid =>
      isUsernameValid &&
      isOrganizerNameValid &&
      isEmailValid &&
      isPasswordValid &&
      isPhoneNumberValid;

  @override
  void resetState() {
    errorMessage = null;

    usernameErrorMessage.value = null;
    organizerNameErrorMessage.value = null;
    emailErrorMessage.value = null;
    passwordErrorMessage.value = null;
    phoneNumberErrorMessage.value = null;

    usernameFocusNode.unfocus();
    organizerNameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
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

  Future<void> signIn() async {
    resetState();

    isLoading.value = true;

    final signInApiRequest = SignInApiRequestModel.fromJson({
      'username': usernameController.text,
      'password': passwordController.text,
    });

    apiAuth.signIn(apiRequest: signInApiRequest).then(
      (response) async {
        final signInApiResponse = SignInApiResponseModel.fromJson(response);

        checkApiResponse(response);

        if (apiResponseState.value != ApiResponseState.http2xx) {
          errorMessage = response['message'];
        } else {
          final pref = await SharedPreferences.getInstance();
          pref.setString('myevent.auth.token', signInApiResponse.token!);

          String eventOrganizerId = JwtUtil().parseJwt(
            pref.getString('myevent.auth.token')!,
          )['sub'];
          pref.setString('myevent.auth.token.subject', eventOrganizerId);

          //subscribe topic for notification
          FirebaseMessaging.instance.subscribeToTopic(eventOrganizerId);

          FirebaseMessaging.onMessage.listen((RemoteMessage message) {
            const AndroidNotificationChannel channel =
                AndroidNotificationChannel(
              'event_reminder',
              'Pengingat event',
              'Channel notifikasi untuk mengingatkan event H-3 dan H-1',
              importance: Importance.high,
              playSound: true,
            );
            RemoteNotification notification = message.notification!;
            AndroidNotification? android = message.notification?.android;
            final FlutterLocalNotificationsPlugin
                flutterLocalNotificationsPlugin =
                FlutterLocalNotificationsPlugin();

            Future onClickNotification(String? payload) async {
              Get.offAllNamed(
                RouteName.eventDetailScreen.replaceAll(':id', payload!),
              );
            }

            var androidSettings =
                AndroidInitializationSettings('@mipmap/ic_launcher');
            var initSetttings = InitializationSettings(
              android: androidSettings,
            );

            flutterLocalNotificationsPlugin.initialize(
              initSetttings,
              onSelectNotification: onClickNotification,
            );

            // ignore: unnecessary_null_comparison
            if (notification != null && android != null) {
              flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    channel.description,
                    playSound: true,
                    icon: '@mipmap/ic_launcher',
                    styleInformation:
                        BigTextStyleInformation(notification.body!),
                  ),
                ),
                payload: message.data['eventId'],
              );
            }
          });

          Get.back();
          Get.offAllNamed(RouteName.mainScreen);
        }

        isLoading.value = false;
      },
    );
  }

  Future<void> signUp() async {
    resetState();

    isLoading.value = true;

    final signUpApiRequest = SignUpApiRequestModel.fromJson(
      {
        'username': usernameController.text,
        'organizerName': organizerNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'phoneNumber': phoneNumberController.text
      },
    );

    apiAuth.signUp(apiRequest: signUpApiRequest).then(
      (response) async {
        final signUpApiResponse = ApiResponseModel.fromJson(response);

        checkApiResponse(response);
        if (apiResponseState.value != ApiResponseState.http2xx) {
          if (signUpApiResponse.message == 'Username sudah digunakan') {
            usernameErrorMessage.value = signUpApiResponse.message;
          } else if (signUpApiResponse.message == 'E-mail sudah digunakan') {
            emailErrorMessage.value = signUpApiResponse.message;
          }
        } else {
          Get.defaultDialog(
            titleStyle: TextStyle(fontSize: 0.0),
            content: Column(
              children: [
                Text(
                  signUpApiResponse.message!,
                  style: TextStyle(
                    fontSize: 20.0,
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
            onConfirm: () => Get.offAllNamed(RouteName.signInScreen),
          );
        }
        isLoading.value = false;
      },
    );
  }

  void gotoSignUpScreen() {
    Get.offAllNamed(RouteName.signUpScreen);
  }

  void gotoSignInScreen() {
    Get.offAllNamed(RouteName.signInScreen);
  }
}
