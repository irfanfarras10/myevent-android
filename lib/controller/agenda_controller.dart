import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';
import 'package:myevent_android/model/api_response/view_event_api_response_model.dart';
import 'package:myevent_android/provider/api_event.dart';

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
            eventList.add(
              NeatCleanCalendarEvent(
                eventData.name!.length > 20
                    ? eventData.name!
                        .replaceRange(20, eventData.name!.length, '...')
                    : eventData.name!,
                startTime: DateTime.fromMillisecondsSinceEpoch(
                  eventData.timeEventStart!,
                ),
                endTime: DateTime.fromMillisecondsSinceEpoch(
                  eventData.timeEventEnd!,
                ),
                color: _getEventColor(eventData.eventStatus!),
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
}
