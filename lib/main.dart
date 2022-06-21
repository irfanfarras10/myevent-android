import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/controller/main_binding.dart';
import 'package:myevent_android/route/app_pages.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:myevent_android/util/api_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
    );
  }
}
