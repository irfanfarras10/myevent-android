import 'package:get/get.dart';
import 'package:myevent_android/screen/main_screen/main_screen.dart';
import 'package:myevent_android/screen/onboarding_screen/onboarding_screen.dart';
import 'package:myevent_android/screen/signin_screen/signin_screen.dart';
import 'package:myevent_android/screen/signup_screen/signup_screen.dart';
import 'package:myevent_android/screen/splash_screen/splash_screen.dart';
import 'route_name.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouteName.onboardingScreen,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: RouteName.signInScreen,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: RouteName.signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: RouteName.mainScreen,
      page: () => MainScreen(),
    ),
  ];
}
