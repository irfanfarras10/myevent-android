import 'package:myevent_android/util/api_util.dart';

final apiAgenda = ApiAgenda();

class ApiAgenda {
  Future<Map<String, dynamic>> getAgenda() {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/agenda',
    );
  }
}
