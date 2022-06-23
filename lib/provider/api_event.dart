import 'package:myevent_android/util/api_util.dart';

final apiEvent = ApiEvent();

class ApiEvent {
  Future<Map<String, dynamic>> getEventCategory() {
    return apiUtil.apiRequestGet(
        'https://myevent-android-api.herokuapp.com/api/events/categories');
  }
}
