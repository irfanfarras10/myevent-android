import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/event_list_controller.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/screen/draft_event_screen/draft_event_screen.dart';

class EventScreen extends StatelessWidget {
  final controller = Get.find<EventListController>();
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
                Obx(
                  () => SliverAppBar(
                    floating: true,
                    pinned: true,
                    snap: false,
                    forceElevated: true,
                    title: controller.isSearchMode.value
                        ? Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            child: Card(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 0),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Cari berdasarkan nama event',
                                    hintStyle: TextStyle(
                                      color: MyEventColor.secondaryColor,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (keyword) {
                                    controller.searchEvent(keyword);
                                  },
                                ),
                              ),
                            ),
                          )
                        : Text(
                            'Event Anda',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: MyEventColor.secondaryColor,
                            ),
                          ),
                    actions: [
                      Visibility(
                        visible: !controller.isSearchMode.value &&
                            !controller.isLoading.value,
                        child: IconButton(
                          onPressed: () => controller.setSearchMode(true),
                          icon: Icon(Icons.search),
                        ),
                      ),
                      Visibility(
                        visible: controller.isSearchMode.value,
                        child: IconButton(
                          onPressed: () {
                            controller.setSearchMode(false);
                            controller.resetData();
                          },
                          icon: Icon(Icons.close),
                        ),
                      ),
                    ],
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
