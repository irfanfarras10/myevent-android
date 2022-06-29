import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/controller/event_list_controller.dart';
import 'package:myevent_android/controller/profile_controller.dart';
import 'package:myevent_android/screen/agenda_screen/agenda_screen.dart';
import 'package:myevent_android/screen/event_screen/event_screen.dart';
import 'package:myevent_android/screen/profile_screen/profile_screen.dart';

class NavigationController extends GetxController {
  RxInt currentMenuIndex = 0.obs;
  List<Widget> menuScreens = [
    EventScreen(),
    AgendaScreen(),
    ProfileScreen(),
  ];
  void onPressedMenuItem(int index) {
    currentMenuIndex.value = index;
    Get.delete<ProfileController>();
    Get.delete<EventListController>();
  }
}
