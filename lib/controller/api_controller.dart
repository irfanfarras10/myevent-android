import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ApiResponseState {
  offline,
  timeout,
  http2xx,
  http401,
  http403,
  http409,
  http500,
}

abstract class ApiController extends GetxController {
  Rxn<ApiResponseState> apiResponseState = Rxn<ApiResponseState>();
  String? errorMessage;
  void checkApiResponse(Map<String, dynamic> response) {
    if (response['code'] != null) {
      if (response['code'] == 401) {
        apiResponseState.value = ApiResponseState.http401;
        Get.defaultDialog(
          title: 'Sesi Masuk Habis',
          content: Text('Harap masuk kembali'),
          textConfirm: 'Ya',
          confirmTextColor: MyEventColor.secondaryColor,
          barrierDismissible: false,
          onConfirm: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.remove('myevent.auth.token');
            Get.offAllNamed(RouteName.signInScreen);
          },
        );
        return;
      }
      if (response['code'] == 403) {
        apiResponseState.value = ApiResponseState.http403;
      }
      if (response['code'] == 500) {
        apiResponseState.value = ApiResponseState.http500;
      }
      if (response['code'] == 2000 || response['code'] == 3000) {
        apiResponseState.value = ApiResponseState.timeout;
      }
      if (response['code'] == 5000) {
        apiResponseState.value = ApiResponseState.offline;
      }
      if (response['code'] == 409) {
        apiResponseState.value = ApiResponseState.http409;
      }
      errorMessage = response['message'];
    } else {
      apiResponseState.value = ApiResponseState.http2xx;
    }
  }

  @protected
  void resetState();
}
