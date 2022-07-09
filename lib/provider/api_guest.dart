import 'package:myevent_android/model/api_request/create_event_guest_api_request_model.dart';
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

  Future<Map<String, dynamic>> inviteAllGuest({
    required int id,
  }) {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/$id/guest/invite',
    );
  }

  Future<Map<String, dynamic>> createGuest({
    required CreateEventGuestApiRequestModel data,
    required int id,
  }) async {
    return apiUtil.apiRequestPost(
      'https://myevent-android-api.herokuapp.com/api/events/$id/guest/create',
      data.toJson(),
    );
  }
}
