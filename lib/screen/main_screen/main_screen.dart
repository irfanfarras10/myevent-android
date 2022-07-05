import 'package:flutter/material.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/screen/agenda_screen/agenda_screen.dart';
import 'package:myevent_android/screen/event_screen/event_screen.dart';
import 'package:myevent_android/screen/profile_screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({Key? key, this.index}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<Widget> menuScreens = [
    EventScreen(),
    AgendaScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    if (widget.index != null) {
      currentIndex = widget.index!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: menuScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: MyEventColor.primaryColor,
        unselectedItemColor: MyEventColor.secondaryColor,
        elevation: 20.0,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
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
    );
  }
}
