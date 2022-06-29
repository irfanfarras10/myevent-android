import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:myevent_android/colors/myevent_color.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agenda',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyEventColor.secondaryColor,
          ),
        ),
      ),
      body: MonthView(),
    );
  }
}
