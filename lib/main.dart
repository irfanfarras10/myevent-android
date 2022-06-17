import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myevent_android/controller/main_controller.dart';
import 'package:myevent_android/route/app_pages.dart';
import 'package:myevent_android/screen/main_screen.dart';
import 'package:myevent_android/screen/onboarding_screen.dart';
import 'package:myevent_android/screen/signin_screen.dart';
import 'package:myevent_android/screen/splash_screen.dart';
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
      home: MyEventApp(),
      debugShowCheckedModeBanner: false,
      navigatorKey: alice.getNavigatorKey(),
      getPages: AppPages.pages,
    );
  }
}

class MyEventApp extends StatelessWidget {
  const MyEventApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = MainController();
    return FutureBuilder(
      future: controller.getAuthState,
      builder: (BuildContext context, AsyncSnapshot<AuthState> snapshot) {
        if (snapshot.hasData == false) {
          return SplashScreen();
        }
        if (snapshot.data == AuthState.init) {
          return OnboardingScreen();
        } else if (snapshot.data == AuthState.unauthorized) {
          return SignInScreen();
        } else {
          return MainScreen();
        }
      },
    );
  }
}
