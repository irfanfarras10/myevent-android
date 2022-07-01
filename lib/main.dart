import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/controller/main_binding.dart';
import 'package:myevent_android/route/app_pages.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/util/api_util.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyEventApp());
}

class MyEventApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: GetMaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.amber,
          fontFamily: 'Inter',
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: alice.getNavigatorKey(),
        getPages: AppPages.pages,
        initialBinding: MainBinding(),
        defaultTransition: Transition.rightToLeftWithFade,
        initialRoute: RouteName.splashScreen,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('id', 'ID'),
        ],
      ),
    );
  }
}
