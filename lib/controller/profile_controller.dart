import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
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
}
