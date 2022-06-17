import 'package:get/get.dart';
import 'package:myevent_android/screen/main_screen.dart';
import 'package:myevent_android/screen/signin_screen.dart';
import 'package:myevent_android/screen/signup_screen.dart';
import 'route_name.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.signInScreen,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: RouteName.mainScreen,
      page: () => MainScreen(),
    ),
    GetPage(
      name: RouteName.signUpScreen,
      page: () => SignUpScreen(),
    )
  ];
}
