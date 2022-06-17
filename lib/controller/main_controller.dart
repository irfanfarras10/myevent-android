import 'package:shared_preferences/shared_preferences.dart';

enum AuthState {
  authorized,
  unauthorized,
}

class MainController {
  Future<AuthState> get getAuthState async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getString('myevent.auth.token') == null) {
      return AuthState.unauthorized;
    }
    return AuthState.authorized;
  }
}
