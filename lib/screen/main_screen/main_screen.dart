import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/navigation_controller.dart';

class MainScreen extends StatelessWidget {
  final controller = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: controller.menuScreens[controller.currentMenuIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: MyEventColor.primaryColor,
          unselectedItemColor: MyEventColor.secondaryColor,
          elevation: 20.0,
          onTap: (index) {
            controller.onPressedMenuItem(index);
          },
          currentIndex: controller.currentMenuIndex.value,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'Event',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Agenda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
