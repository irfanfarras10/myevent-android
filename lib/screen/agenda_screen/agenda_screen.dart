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
                return Expanded(
                    child: Column(
                  children: [
                    Divider(),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daftar Event',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.5,
                            color: MyEventColor.secondaryColor,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Keterangan Warna'),
                                  titleTextStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.bold,
                                    color: MyEventColor.secondaryColor,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 12.0,
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'Draft',
                                            style: TextStyle(
                                              color:
                                                  MyEventColor.secondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12.0,
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'Akan Datang',
                                            style: TextStyle(
                                              color:
                                                  MyEventColor.secondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12.0,
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'Sedang Berjalan',
                                            style: TextStyle(
                                              color:
                                                  MyEventColor.secondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12.0,
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'Selesai',
                                            style: TextStyle(
                                              color:
                                                  MyEventColor.secondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 12.0,
                                            height: 12.0,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'Dibatalkan',
                                            style: TextStyle(
                                              color:
                                                  MyEventColor.secondaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          color: MyEventColor.secondaryColor,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    events.isEmpty
                        ? Center(
                            child: Text('Tidak ada event pada tanggal ini'),
                          )
                        : Expanded(
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Material(
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return Container(
                                            padding: EdgeInsets.all(20.0),
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
                                                    fontSize: 18.0,
                                                    color: MyEventColor
                                                        .secondaryColor,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 30.0,
                                                ),
                                                Text(
                                                  events[index].description,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: MyEventColor
                                                        .secondaryColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30.0,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 16.5,
                                                      color: Colors.black38,
                                                    ),
                                                    SizedBox(width: 5.0),
                                                    Expanded(
                                                      child: Text(
                                                        events[index].location,
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: MyEventColor
                                                              .secondaryColor,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.date_range,
                                                      size: 16.5,
                                                      color: Colors.black38,
                                                    ),
                                                    SizedBox(width: 5.0),
                                                    Text(
                                                      controller.parseDate(
                                                        events[index].startTime,
                                                        events[index].endTime,
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: MyEventColor
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.access_time,
                                                      size: 16.5,
                                                      color: Colors.black38,
                                                    ),
                                                    SizedBox(width: 5.0),
                                                    Text(
                                                      controller.parseTime(
                                                        events[index].startTime,
                                                        events[index].endTime,
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: MyEventColor
                                                            .secondaryColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30.0,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 60.0,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      controller.writeIcsFile(
                                                        events[index],
                                                      );
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (states) {
                                                          if (states.contains(
                                                              MaterialState
                                                                  .disabled)) {
                                                            return Colors
                                                                .amber.shade300;
                                                          }
                                                          return Colors.amber;
                                                        },
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Unduh File Kalender (iCS)',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: MyEventColor
                                                            .secondaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.0,
                                                ),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 60.0,
                                                  child: ElevatedButton(
                                                    onPressed: () => controller
                                                        .createEventToGoogleCalendar(
                                                      events[index],
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (states) {
                                                          return Colors.white;
                                                        },
                                                      ),
                                                      elevation:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  double>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          return 0; // Defer to the widget's default.
                                                        },
                                                      ),
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                4.5),
                                                          ),
                                                          side: BorderSide(
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Tambahkan Event Ke Google Calendar ',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: MyEventColor
                                                            .secondaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15.0,
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
                                          Expanded(
                                            child: Text(
                                              events[index].location,
                                              overflow: TextOverflow.ellipsis,
                                            ),
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
                          ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ));
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
