import 'package:get/get.dart';
import 'package:myevent_android/controller/api_controller.dart';

enum CalendarViewType {
  monthView,
  weekView,
  dayView,
}

class AgendaController extends ApiController {
  Rx<CalendarViewType> calendarViewType = CalendarViewType.monthView.obs;

  @override
  void resetState() {
    // TODO: implement resetState
  }

  void setCalendarView(CalendarViewType viewType) {
    calendarViewType.value = viewType;
  }
}
