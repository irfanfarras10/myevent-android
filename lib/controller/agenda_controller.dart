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

  // Color _getAgendaEventColor(EventStatus status) {
  //   Color? agendaEventColor;
  //   switch (status.id) {
  //     case 1:
  //       agendaEventColor = Colors.amber;
  //       break;
  //     case 2:
  //       agendaEventColor = Colors.blue;
  //       break;
  //     case 3:
  //       agendaEventColor = Colors.green;
  //       break;
  //     case 4:
  //       agendaEventColor = Colors.purple;
  //       break;
  //     case 5:
  //       agendaEventColor = Colors.red;
  //       break;
  //   }
  //   return agendaEventColor!;
  // }

  Future<void> loadEventSchedule() async {
    resetState();
    await apiEvent.getEvent().then(
      (response) {
        checkApiResponse(response);
        if (apiResponseState.value != ApiResponseState.http401) {
          isLoading.value = false;
        }
        if (apiResponseState.value == ApiResponseState.http2xx) {
          // final eventData = ViewEventApiResponseModel.fromJson(response);
          // eventAgenda = eventData.eventDataList!;
          // for (int i = 0; i < eventAgenda.length; i++) {
          //   final event = CalendarEventData(
          //     date: DateTime.fromMillisecondsSinceEpoch(
          //       eventAgenda[i].dateEventStart!,
          //     ),
          //     endDate: DateTime.fromMillisecondsSinceEpoch(
          //       eventAgenda[i].dateEventEnd!,
          //     ),
          //     startTime: DateTime.fromMillisecondsSinceEpoch(
          //       eventAgenda[i].timeEventStart!,
          //     ),
          //     endTime: DateTime.fromMillisecondsSinceEpoch(
          //       eventAgenda[i].timeEventEnd!,
          //     ),
          //     event: eventAgenda[i].name,
          //     title: eventAgenda[i].name!,
          //     color: _getAgendaEventColor(eventAgenda[i].eventStatus!),
          //   );
          //   CalendarControllerProvider.of(_context!).controller.remove(event);
          //   CalendarControllerProvider.of(_context!).controller.add(event);
          //   //remove unnecessary event added

          // }
        }
      },
    );
  }

  void setCalendarView(CalendarViewType viewType) {
    calendarViewType.value = viewType;
  }
}
