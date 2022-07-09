import 'package:flutter/material.dart';
import 'package:myevent_android/colors/myevent_color.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyEventColor.secondaryColor,
          ),
        ),
      ),
    );
  }
}
