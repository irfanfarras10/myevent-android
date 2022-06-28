import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/controller/event_list_controller.dart';
import 'package:myevent_android/screen/draft_event_screen/widget/draft_event_screen_card_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';

class DraftEventScreen extends StatelessWidget {
  const DraftEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventListController>();
    return Obx(
      () {
        Widget body;
        if (controller.isLoading.value) {
          body = LoadingWidget();
        } else {
          body = SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: List.generate(
                controller.eventList.length,
                (index) {
                  return DraftEventScreenCardWidget();
                },
              ),
            ),
          );
        }
        return body;
      },
    );
  }
}
