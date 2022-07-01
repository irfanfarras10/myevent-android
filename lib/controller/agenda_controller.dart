import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
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
  List<EventDataList> eventAgenda = [];

  @override
  void onInit() {
    loadEventSchedule();
    super.onInit();
  }

  @override
  void resetState() {
    eventAgenda.clear();
    isLoading.value = true;
  }

  Color _getAgendaEventColor(EventStatus status) {
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
          final context = Get.key.currentContext;
          final eventData = ViewEventApiResponseModel.fromJson(response);
          eventAgenda = eventData.eventDataList!;
          eventAgenda.forEach(
            (agendaData) {
              final event = CalendarEventData(
                date: DateTime.fromMillisecondsSinceEpoch(
                  agendaData.dateEventStart!,
                ),
                endDate: DateTime.fromMillisecondsSinceEpoch(
                  agendaData.dateEventEnd!,
                ),
                startTime: DateTime.fromMillisecondsSinceEpoch(
                  agendaData.timeEventStart!,
                ),
                endTime: DateTime.fromMillisecondsSinceEpoch(
                  agendaData.timeEventEnd!,
                ),
                event: agendaData.name,
                title: agendaData.name!,
                color: _getAgendaEventColor(agendaData.eventStatus!),
              );
              CalendarControllerProvider.of(context!).controller.add(event);
            },
          );
        }
      },
    );
  }

  void setCalendarView(CalendarViewType viewType) {
    calendarViewType.value = viewType;
  }
}
