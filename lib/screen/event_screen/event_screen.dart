import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/route/route_name.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Event List Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteName.createEventPaymentScreen),
        child: Icon(Icons.add),
        tooltip: 'Buat Event',
      ),
    );
  }
}
