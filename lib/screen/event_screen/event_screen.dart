import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/event_list_controller.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/screen/draft_event_screen/draft_event_screen.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventListController>();
    return Scaffold(
      body: DefaultTabController(
        length: 5,
        child: RefreshIndicator(
          notificationPredicate: (notification) {
            return notification.depth == 2;
          },
          onRefresh: controller.getData,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: false,
                  forceElevated: true,
                  title: Text(
                    'Event Anda',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyEventColor.secondaryColor,
                    ),
                  ),
                  bottom: TabBar(
                    indicatorColor: MyEventColor.secondaryColor,
                    isScrollable: true,
                    labelStyle: TextStyle(
                      fontSize: 16.5,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16.5,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.normal,
                    ),
                    labelColor: MyEventColor.secondaryColor,
                    tabs: [
                      Tab(text: 'Draft'),
                      Tab(text: 'Akan Datang'),
                      Tab(text: 'Sedang Berjalan'),
                      Tab(text: 'Selesai'),
                      Tab(text: 'Dibatalkan')
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                DraftEventScreen(),
                Container(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(RouteName.createEventScreen),
        child: Icon(Icons.add),
        tooltip: 'Buat Event',
      ),
    );
  }
}
