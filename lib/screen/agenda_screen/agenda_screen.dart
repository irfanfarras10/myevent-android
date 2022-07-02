// import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:myevent_android/colors/myevent_color.dart';
// import 'package:myevent_android/controller/agenda_controller.dart';
// import 'package:myevent_android/controller/api_controller.dart';
// import 'package:myevent_android/widget/http_error_widget.dart';
// import 'package:myevent_android/widget/loading_widget.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:myevent_android/colors/myevent_color.dart';

class AgendaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Obx(
    //   () {
    //     final controller = Get.find<AgendaController>();
    //     Widget calendarViewWidget;
    //     switch (controller.calendarViewType.value) {
    //       case CalendarViewType.monthView:
    //         calendarViewWidget = MonthView(
    //           startDay: WeekDays.sunday,
    //         );
    //         break;
    //       case CalendarViewType.weekView:
    //         calendarViewWidget = WeekView(
    //           eventArranger: MergeEventArranger(),
    //           startDay: WeekDays.sunday,
    //         );
    //         break;
    //       case CalendarViewType.dayView:
    //         calendarViewWidget = DayView();
    //     }
    //     Widget agendaBody;
    //     if (controller.isLoading.value) {
    //       agendaBody = LoadingWidget();
    //     } else {
    //       if (controller.apiResponseState.value != ApiResponseState.http2xx &&
    //           controller.apiResponseState.value != ApiResponseState.http401) {
    //         return HttpErrorWidget(
    //           errorMessage: 'Terjadi Kesalahan',
    //           refreshAction: controller.loadEventSchedule,
    //         );
    //       }

    //       agendaBody = Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: EdgeInsets.fromLTRB(15.0, 7.5, 15.0, 7.5),
    //             child: Row(
    //               children: [
    //                 ActionChip(
    //                   onPressed: () => controller.setCalendarView(
    //                     CalendarViewType.monthView,
    //                   ),
    //                   label: Text(
    //                     'Bulan',
    //                     style: TextStyle(
    //                       color: MyEventColor.secondaryColor,
    //                       fontSize: 16.5,
    //                     ),
    //                   ),
    //                   backgroundColor: controller.calendarViewType.value ==
    //                           CalendarViewType.monthView
    //                       ? MyEventColor.primaryColor
    //                       : Colors.grey.shade300,
    //                 ),
    //                 SizedBox(
    //                   width: 15.0,
    //                 ),
    //                 ActionChip(
    //                   onPressed: () => controller.setCalendarView(
    //                     CalendarViewType.weekView,
    //                   ),
    //                   label: Text(
    //                     'Minggu',
    //                     style: TextStyle(
    //                       color: MyEventColor.secondaryColor,
    //                       fontSize: 16.5,
    //                     ),
    //                   ),
    //                   backgroundColor: controller.calendarViewType.value ==
    //                           CalendarViewType.weekView
    //                       ? MyEventColor.primaryColor
    //                       : Colors.grey.shade300,
    //                 ),
    //                 SizedBox(
    //                   width: 15.0,
    //                 ),
    //                 ActionChip(
    //                   onPressed: () => controller.setCalendarView(
    //                     CalendarViewType.dayView,
    //                   ),
    //                   label: Text(
    //                     'Hari',
    //                     style: TextStyle(
    //                       color: MyEventColor.secondaryColor,
    //                       fontSize: 16.5,
    //                     ),
    //                   ),
    //                   backgroundColor: controller.calendarViewType.value ==
    //                           CalendarViewType.dayView
    //                       ? MyEventColor.primaryColor
    //                       : Colors.grey.shade300,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Expanded(
    //             child: calendarViewWidget,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.all(15.0),
    //             child: Column(
    //               children: [
    //                 Text(
    //                   'Keterangan Warna',
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 15.0,
    //                 ),
    //                 Row(
    //                   children: [
    //                     Container(
    //                       height: 15.0,
    //                       width: 15.0,
    //                       decoration: BoxDecoration(
    //                         color: Colors.amber,
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(3.0),
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 15.0,
    //                     ),
    //                     Text('Draft')
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     Container(
    //                       height: 15.0,
    //                       width: 15.0,
    //                       decoration: BoxDecoration(
    //                         color: Colors.blue,
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(3.0),
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 15.0,
    //                     ),
    //                     Text('Akan Datang')
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     Container(
    //                       height: 15.0,
    //                       width: 15.0,
    //                       decoration: BoxDecoration(
    //                         color: Colors.green,
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(3.0),
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 15.0,
    //                     ),
    //                     Text('Sedang Dilaksanakan')
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     Container(
    //                       height: 15.0,
    //                       width: 15.0,
    //                       decoration: BoxDecoration(
    //                         color: Colors.purple,
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(3.0),
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 15.0,
    //                     ),
    //                     Text('Selesai')
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     Container(
    //                       height: 15.0,
    //                       width: 15.0,
    //                       decoration: BoxDecoration(
    //                         color: Colors.red,
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(3.0),
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       width: 15.0,
    //                     ),
    //                     Text('Dibatalkan')
    //                   ],
    //                 )
    //               ],
    //             ),
    //           )
    //         ],
    //       );
    //     }
    //     return Scaffold(
    //       appBar: AppBar(
    //         title: Text(
    //           'Agenda',
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //             color: MyEventColor.secondaryColor,
    //           ),
    //         ),
    //       ),
    //       body: agendaBody,
    //     );
    //   },
    // );
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
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Calendar(
          startOnMonday: true,
          weekDays: ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'],
          eventsList: _eventList,
          isExpandable: true,
          // eventDoneColor: Colors.green,
          // selectedColor: Colors.pink,
          // selectedTodayColor: Colors.red,
          todayColor: Colors.blue,
          eventColor: null,
          locale: 'id_ID',
          todayButtonText: 'Bulan',
          isExpanded: true,
          expandableDateFormat: 'EEEE, dd. MMMM yyyy',
        ),
      ),
    );
  }

  final List<NeatCleanCalendarEvent> _eventList = [
    NeatCleanCalendarEvent('MultiDay Event A',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange,
        isMultiDay: true),
    NeatCleanCalendarEvent('Allday Event B',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day - 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.pink,
        isAllDay: true),
    NeatCleanCalendarEvent('Normal Event D',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 0),
        color: Colors.indigo),
  ];
}
