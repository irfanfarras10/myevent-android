import 'package:flutter/material.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/agenda_controller.dart';

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgendaController>();
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
              refreshAction: controller.loadEventSchedule,
            );
          }

          body = Padding(
            padding: EdgeInsets.all(15.0),
            child: Calendar(
              startOnMonday: true,
              weekDays: ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'],
              eventsList: controller.eventList,
              isExpandable: true,
              todayColor: Colors.blue,
              eventColor: null,
              locale: 'id_ID',
              todayButtonText: 'Bulan',
              isExpanded: true,
              expandableDateFormat: 'EEEE, dd MMMM yyyy',
              onEventSelected: (event) {
                print(event.location);
              },
            ),
          );
        }
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
          body: body,
        );
      },
    );
  }
}
