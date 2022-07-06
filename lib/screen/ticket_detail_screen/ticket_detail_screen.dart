import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/controller/event_detail_controller.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/widget/http_error_widget.dart';
import 'package:myevent_android/widget/loading_widget.dart';
import 'package:myevent_android/widget/navigation_drawer_widget.dart';

class TicketDetailScreen extends StatelessWidget {
  final eventId = Get.parameters['id'];
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
          body = SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: controller.eventData!.ticket!.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height,
                    child: Center(
                      child: Text(
                        'Tidak Ada Data Tiket',
                        style: TextStyle(
                          fontSize: 16.5,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.0),
                        color: Colors.grey.shade200,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 20.0,
                                  color: MyEventColor.secondaryColor,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    _parseEventDate(
                                      controller.eventData!
                                          .dateTimeRegistrationStart!,
                                      controller
                                          .eventData!.dateTimeRegistrationEnd!,
                                    ),
                                    style: TextStyle(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.bold,
                                      color: MyEventColor.secondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  height: 10.0,
                                  child: Checkbox(
                                    value: true,
                                    onChanged: (checked) {},
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Tiket Berbayar',
                                  style: TextStyle(
                                    fontSize: 16.5,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20.0,
                                  height: 10.0,
                                  child: Checkbox(
                                    value: false,
                                    onChanged: (checked) {},
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Tiket Harian',
                                  style: TextStyle(
                                    fontSize: 16.5,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Tiket (${_getTotalEventDay(controller.eventData!.dateEventStart!, controller.eventData!.dateEventEnd!)} Hari)',
                                  style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                ),
                                Text(
                                  controller.calculateTicketTotal(),
                                  style: TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: List.generate(
                                controller.eventData!.ticket!.length,
                                (index) {
                                  controller.eventData!.ticket!.sort(
                                    (a, b) => a.id!.compareTo(b.id!),
                                  );
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller.eventData!.ticket![index]
                                                .name!,
                                            style: TextStyle(
                                              fontSize: 16.5,
                                              color:
                                                  MyEventColor.secondaryColor,
                                            ),
                                          ),
                                          Text(
                                            '${controller.eventData!.ticket![index].quotaTotal!}',
                                            style: TextStyle(
                                              fontSize: 16.5,
                                              color:
                                                  MyEventColor.secondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Divider(),
                            Column(
                              children: List.generate(
                                controller.eventData!.ticket!.length,
                                (index) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Card(
                                        shadowColor: Colors.black12,
                                        color: Colors.grey.shade100,
                                        child: ListTile(
                                          title: Text(
                                            controller.eventData!.ticket![index]
                                                .name!,
                                            style: TextStyle(
                                              fontSize: 16.5,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  MyEventColor.secondaryColor,
                                            ),
                                          ),
                                          subtitle: Visibility(
                                            visible: controller.eventData!
                                                    .ticket![0].price! >
                                                0,
                                            child: Text(
                                              _rupiah(controller.eventData!
                                                  .ticket![index].price!),
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    MyEventColor.secondaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
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
                  onPressed: () {
                    Get.toNamed(
                      RouteName.createEventTicketScreen.replaceAll(
                        ':id',
                        eventId!,
                      ),
                      arguments: {
                        'dateEventStart': DateTime.fromMillisecondsSinceEpoch(
                          controller.eventData!.dateEventStart!,
                        ),
                        'dateEventEnd': DateTime.fromMillisecondsSinceEpoch(
                          controller.eventData!.dateEventEnd!,
                        ),
                        'canEdit': true,
                      },
                    )!
                        .then((refresh) {
                      if (refresh) {
                        controller.loadData();
                      }
                    });
                  },
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

  String _parseEventDate(int dateEventStart, int dateEventEnd) {
    String? dateTimeEvent;
    String dateEventStartString = DateFormat('d MMMM yyyy', 'id_ID').format(
      DateTime.fromMillisecondsSinceEpoch(dateEventStart),
    );
    String dateEventEndString = DateFormat('d MMMM yyyy', 'id_ID').format(
      DateTime.fromMillisecondsSinceEpoch(dateEventEnd),
    );
    dateTimeEvent = '$dateEventStartString - $dateEventEndString';
    return dateTimeEvent;
  }

  String _getTotalEventDay(int dateTimeEventStart, int dateTimeEventEnd) {
    int totalEventDay;
    totalEventDay = DateTime.fromMillisecondsSinceEpoch(dateTimeEventEnd)
            .difference(DateTime.fromMillisecondsSinceEpoch(dateTimeEventStart))
            .inDays +
        1;
    return totalEventDay.toString();
  }

  String _rupiah(value) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
        .format(value);
  }
}
