import 'package:myevent_android/util/api_util.dart';

final apiAuth = ApiAuth();

class ApiAuth {
  Future<Map<String, dynamic>> signIn(Map<String, dynamic> requestBody) async {
    return apiUtil.apiRequestPost('auth/signin', requestBody);
  }
}
