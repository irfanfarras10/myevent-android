import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/event_detail_controller.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';
import 'package:myevent_android/widget/navigation_drawer_widget.dart';

class TicketDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EventDetailController>();
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
          body = Center(
            child: Text('Tiket Detail'),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Tiket',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyEventColor.secondaryColor,
              ),
            ),
            actions: [
              Visibility(
                visible: !controller.isLoading.value,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  tooltip: 'Edit data tiket',
                ),
              )
            ],
          ),
          body: body,
          drawer: !controller.isLoading.value
              ? NavigationDrawerWidget(eventData: controller.eventData)
              : null,
        );
      },
    );
  }
}
