import 'package:myevent_android/util/api_util.dart';

final apiGuest = ApiGuest();

class ApiGuest {
  Future<Map<String, dynamic>> getGuest({
    required int id,
  }) {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/$id/guest',
    );
  }
}
