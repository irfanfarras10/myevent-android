import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/screen/agenda_screen.dart';
import 'package:myevent_android/screen/event_screen.dart';
import 'package:myevent_android/screen/profile_screen.dart';

class NavigationController extends GetxController {
  RxInt currentMenuIndex = 0.obs;
  List<Widget> menuScreens = [
    EventScreen(),
    AgendaScreen(),
    ProfileScreen(),
  ];
}
