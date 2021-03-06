import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/event_list_controller.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/screen/cancel_event_screen/cancel_event_screen.dart';
import 'package:myevent_android/screen/draft_event_screen/draft_event_screen.dart';
import 'package:myevent_android/screen/live_event_screen/live_event_screen.dart';
import 'package:myevent_android/screen/pass_event_screen/pass_event_screen.dart';
import 'package:myevent_android/screen/publish_event_screen/publish_event_screen.dart';

class EventScreen extends StatelessWidget {
  final controller = Get.put(EventListController(), tag: 'draft');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: DefaultTabController(
          length: 5,
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
                PublishEventScreen(),
                LiveEventScreen(),
                PassEventScreen(),
                CancelEventScreen(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.toNamed(RouteName.createEventScreen)!.then(
            (refresh) {
              if (refresh) {
                controller.loadData();
              }
            },
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Buat Event',
      ),
    );
  }
}
