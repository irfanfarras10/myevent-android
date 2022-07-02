import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              todayColor: Colors.blue,
              eventColor: null,
              locale: 'id_ID',
              todayButtonText: 'Bulan',
              isExpanded: true,
              expandableDateFormat: 'EEEE, dd MMMM yyyy',
              eventListBuilder: (context, events) {
                return Material(
                  child: Column(
                    children: [
                      Divider(),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Daftar Event',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.5,
                          color: MyEventColor.secondaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      ListView.separated(
                        itemBuilder: (context, index) {
                          return Material(
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  builder: (context) {
                                    return Container(
                                      padding: EdgeInsets.all(20.0),
                                      height: 200.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            events[index].summary,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  MyEventColor.secondaryColor,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: ListTile(
                                title: Text(events[index].summary),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 16.5,
                                      color: Colors.black38,
                                    ),
                                    Text(
                                      events[index].location,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                minLeadingWidth: 5,
                                leading: Container(
                                  height: double.infinity,
                                  width: 5.0,
                                  color: events[index].color,
                                ),
                                trailing: Column(children: [
                                  Text(
                                    '${DateFormat('HH:mm', 'id_ID').format(events[index].startTime)}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${DateFormat('HH:mm', 'id_ID').format(events[index].endTime)}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: events.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(5),
                        scrollDirection: Axis.vertical,
                      ),
                    ],
                  ),
                );
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
