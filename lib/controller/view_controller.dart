import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ApiResponseState {
  offline,
  timeout,
  http2xx,
  http403,
}

abstract class ViewController extends GetxController {
  Rxn<ApiResponseState> apiResponseState = Rxn<ApiResponseState>();
  String? errorMessage;
  void checkApResponse(Map<String, dynamic> response) {
    if (response['code'] != null) {
      if (response['code'] == 401) {
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
      }
      if (response['code'] == 403) {
        apiResponseState.value = ApiResponseState.http403;
      }
    } else {
      apiResponseState.value = ApiResponseState.http2xx;
    }
  }

  @protected
  void resetState();
}
