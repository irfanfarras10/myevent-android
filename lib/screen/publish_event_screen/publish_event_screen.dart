import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/event_list_controller.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';

import 'widget/publish_event_screen_card_widget.dart';

class PublishEventScreen extends StatefulWidget {
  const PublishEventScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PublishEventScreen> createState() => _PublishEventScreenState();
}

class _PublishEventScreenState extends State<PublishEventScreen> {
  final controller = Get.put(EventListController(), tag: 'publish');

  @override
  void initState() {
    controller.eventStatus = 2;
    controller.loadData();
    super.initState();
  }

  @override
  void dispose() {
    controller.setSearchMode(false);
    Get.delete<EventListController>(tag: 'publish');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        Widget body;
        if (controller.isLoading.value) {
          body = LoadingWidget();
        } else {
          if (controller.apiResponseState.value != ApiResponseState.http2xx &&
              controller.apiResponseState.value != ApiResponseState.http401) {
            return HttpErrorWidget(
              errorMessage: controller.errorMessage,
              refreshAction: controller.loadData,
            );
          }

          body = GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari berdasarkan nama event',
                      hintStyle: TextStyle(
                        color: MyEventColor.secondaryColor,
                      ),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                    ),
                    onChanged: (keyword) {
                      controller.searchEvent(keyword);
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: controller.loadData,
                    notificationPredicate: (notification) {
                      return notification.depth == 0;
                    },
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      // ignore: invalid_use_of_protected_member
                      child: controller.searchEventList.value.isEmpty
                          ? SizedBox(
                              height: 200.0,
                              child: Center(
                                child: Text(
                                  'Tidak Ada Data',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children: List.generate(
                                // ignore: invalid_use_of_protected_member
                                controller.searchEventList.value.length,
                                (index) {
                                  return PublishEventScreenCardWidget(
                                    data: controller.searchEventList[index],
                                  );
                                },
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return body;
      },
    );
  }
}
