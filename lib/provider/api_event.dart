import 'package:myevent_android/util/api_util.dart';

final apiEvent = ApiEvent();

class ApiEvent {
  Future<Map<String, dynamic>> getEventCategory() {
    return apiUtil.apiRequestGet(
        'https://myevent-android-api.herokuapp.com/api/events/categories');
  }

  Future<Map<String, dynamic>> createEvent(
      {required Map<String, dynamic> data}) async {
    return apiUtil.apiRequestMultipartPost(
      url: 'https://myevent-android-api.herokuapp.com/api/events/create',
      data: data,
    );
  }

  Future<Map<String, dynamic>> getEvent(){
    return apiUtil.apiRequestGet(
        'https://myevent-android-api.herokuapp.com/api/events');
  }

  Future<Map<String, dynamic>> getEventDraft() {
    return apiUtil.apiRequestGet(
        'https://myevent-android-api.herokuapp.com/api/events/draft');
  }
}
