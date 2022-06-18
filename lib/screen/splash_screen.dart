import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/main_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<MainController>();
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'My',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: MyEventColor.primaryColor,
              ),
            ),
            Text(
              'Event',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: MyEventColor.secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
