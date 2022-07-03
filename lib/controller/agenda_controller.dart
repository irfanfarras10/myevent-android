import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myevent_android/colors/myevent_color.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum CalendarViewType {
  monthView,
  weekView,
  dayView,
}

class AgendaController extends ApiController {
  final isLoading = true.obs;
  Rx<CalendarViewType> calendarViewType = CalendarViewType.monthView.obs;
  List<NeatCleanCalendarEvent> eventList = [];

  @override
  void onInit() {
    loadEventSchedule();
    super.onInit();
  }

  @override
  void resetState() {
    eventList.clear();
    isLoading.value = true;
  }

  Color _getEventColor(EventStatus status) {
    Color? agendaEventColor;
    switch (status.id) {
      case 1:
        agendaEventColor = Colors.amber;
        break;
      case 2:
        agendaEventColor = Colors.blue;
        break;
      case 3:
        agendaEventColor = Colors.green;
        break;
      case 4:
        agendaEventColor = Colors.purple;
        break;
      case 5:
        agendaEventColor = Colors.red;
        break;
    }
    return agendaEventColor!;
  }

  Future<String> _getEventLocation(
    EventStatus eventVenueCategory,
    String location,
  ) async {
    if (eventVenueCategory.id == 1) {
      final coordinate = location.split('|');
      final lat = double.parse(coordinate[0]);
      final lon = double.parse(coordinate[1]);
      final address = await placemarkFromCoordinates(lat, lon);
      return address[0].street!;
    } else {
      return 'Online Event';
    }
  }

  Future<void> loadEventSchedule() async {
    resetState();
    await apiEvent.getEvent().then(
      (response) {
        checkApiResponse(response);
        if (apiResponseState.value != ApiResponseState.http401) {
          isLoading.value = false;
        }
        if (apiResponseState.value == ApiResponseState.http2xx) {
          final eventListData = ViewEventApiResponseModel.fromJson(response);
          eventListData.eventDataList!.forEach((eventData) async {
            final String eventLocation = await _getEventLocation(
              eventData.eventVenueCategory!,
              eventData.venue!,
            );
            eventList.add(
              NeatCleanCalendarEvent(
                eventData.name!,
                description: eventData.description!,
                startTime: DateTime.fromMillisecondsSinceEpoch(
                  eventData.timeEventStart!,
                ),
                endTime: DateTime.fromMillisecondsSinceEpoch(
                  eventData.timeEventEnd!,
                ),
                color: _getEventColor(eventData.eventStatus!),
                location: eventLocation,
              ),
            );
          });
        }
      },
    );
  }

  void setCalendarView(CalendarViewType viewType) {
    calendarViewType.value = viewType;
  }

  String parseTime(DateTime startTime, DateTime endTime) {
    String dateTimeString;
    dateTimeString =
        '${DateFormat('HH:mm', 'id_ID').format(startTime)} - ${DateFormat('HH:mm', 'id_ID').format(endTime)}';
    return dateTimeString;
  }

  String parseDate(DateTime startTime, DateTime endTime) {
    String dateTimeString;
    if (startTime.year == endTime.year &&
        startTime.month == endTime.month &&
        startTime.weekday == endTime.weekday) {
      dateTimeString = DateFormat('dd MMMM yyyy', 'id_ID').format(
        startTime,
      );
    } else {
      dateTimeString =
          '${DateFormat('dd MMMM yyyy', 'id_ID').format(startTime)} - ${DateFormat('dd MMMM yyyy', 'id_ID').format(endTime)}';
    }
    return dateTimeString;
  }

  void createEventToGoogleCalendar(NeatCleanCalendarEvent event) async {
    String googleCalendarUrl =
        'https://calendar.google.com/calendar/render?action=TEMPLATE';
    String eventDateStart =
        '&dates=${DateFormat("yyyyMMddTHHmmss").format(event.startTime)}';
    String eventDateEnd =
        '%2F${DateFormat("yyyyMMddTHHmmss").format(event.endTime)}';
    String eventDetail = '&details=${event.description}';
    String eventLocation = '&location=${event.location}';
    String eventTitle = '&text=${event.summary}';
    googleCalendarUrl += eventDateStart;
    googleCalendarUrl += eventDateEnd;
    googleCalendarUrl += eventDetail;
    googleCalendarUrl += eventLocation;
    googleCalendarUrl += eventTitle;
    await launch(googleCalendarUrl);
  }

  Future<File> _localFile(String fileName) async {
    final path = '/storage/emulated/0/Download';
    return File('$path/$fileName${DateTime.now().millisecondsSinceEpoch}.ics');
  }

  void writeIcsFile(NeatCleanCalendarEvent event) async {
    try {
      final file = await _localFile(event.summary);
      String fileContent = 'BEGIN:VCALENDAR\n';
      fileContent += 'VERSION:2.0\n';
      fileContent += 'BEGIN:VEVENT\n';
      fileContent +=
          'DTSTART:${DateFormat('yyyyMMddTHHmmss').format(event.startTime)}\n';
      fileContent +=
          'DTEND:${DateFormat('yyyyMMddTHHmmss').format(event.endTime)}\n';
      fileContent += 'SUMMARY:${event.summary}\n';
      fileContent += 'DESCRIPTION:${event.description}\n';
      fileContent += 'LOCATION:${event.location}\n';
      fileContent += 'END:VEVENT\n';
      fileContent += 'END:VCALENDAR\n';
      await file.writeAsString(fileContent);
      Get.defaultDialog(
        titleStyle: TextStyle(
          fontSize: 0.0,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'File iCS berhasil tersimpan',
              style: TextStyle(
                fontSize: 15.0,
                color: MyEventColor.secondaryColor,
              ),
            ),
            Icon(
              Icons.check,
              size: 50.0,
              color: Colors.green,
            ),
          ],
        ),
        textConfirm: 'OK',
        confirmTextColor: MyEventColor.secondaryColor,
        barrierDismissible: false,
        onConfirm: () {
          Get.back();
        },
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        titleStyle: TextStyle(
          fontSize: 0.0,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Terjadi pada saat membuat file',
              style: TextStyle(
                fontSize: 15.0,
                color: MyEventColor.secondaryColor,
              ),
            ),
            Icon(
              Icons.close,
              size: 50.0,
              color: Colors.red,
            ),
          ],
        ),
        textConfirm: 'OK',
        confirmTextColor: MyEventColor.secondaryColor,
        barrierDismissible: false,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
