import 'package:get/get.dart';
import 'package:myevent_android/route/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthState {
  init,
  authorized,
  unauthorized,
}

class MainController extends GetxController {
  String? initRoute;

  @override
  void onInit() async {
    final authState = await getAuthState;
    if (authState == AuthState.init) {
      initRoute = RouteName.onboardingScreen;
    } else if (authState == AuthState.unauthorized) {
      initRoute = RouteName.signInScreen;
    } else {
      initRoute = RouteName.mainScreen;
    }
    Get.offAllNamed(initRoute!);
    super.onInit();
  }

  Future<AuthState> get getAuthState async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getBool('myevent.init') == null) {
      return AuthState.init;
    }
    if (pref.getString('myevent.auth.token') == null) {
      return AuthState.unauthorized;
    }
    return AuthState.authorized;
  }

  void setOnboardingStatus() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool('myevent.init', false);
    Get.offAllNamed(RouteName.signInScreen);
  }
}
