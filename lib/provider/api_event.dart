import 'package:myevent_android/util/api_util.dart';

final apiEvent = ApiEvent();

class ApiEvent {
  Future<Map<String, dynamic>> getEventCategory() {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/categories',
    );
  }

  Future<Map<String, dynamic>> createEvent(
      {required Map<String, dynamic> data}) async {
    return apiUtil.apiRequestMultipartPost(
      url: 'https://myevent-android-api.herokuapp.com/api/events/create',
      data: data,
    );
  }

  Future<Map<String, dynamic>> getEvent() {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events',
    );
  }

  Future<Map<String, dynamic>> getEventDraft() {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/draft',
    );
  }

  Future<Map<String, dynamic>> getEventPublish() {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/published',
    );
  }

  Future<Map<String, dynamic>> getEventLive() {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/live',
    );
  }

  Future<Map<String, dynamic>> getEventPass() {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/passed',
    );
  }

  Future<Map<String, dynamic>> getEventCancel() {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/cancel',
    );
  }

  Future<Map<String, dynamic>> getEventDetail({required int id}) {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/$id',
    );
  }

  Future<Map<String, dynamic>> deleteEvent({required int id}) {
    return apiUtil.apiRequestDelete(
      'https://myevent-android-api.herokuapp.com/api/events/$id',
    );
  }

  Future<Map<String, dynamic>> updateEvent({
    required int id,
    required Map<String, dynamic> data,
  }) {
    return apiUtil.apiRequestMultipartPut(
      url: 'https://myevent-android-api.herokuapp.com/api/events/update/$id',
      data: data,
    );
  }

  Future<Map<String, dynamic>> publishEvent({
    required int id,
  }) {
    return apiUtil.apiRequestPost(
      'https://myevent-android-api.herokuapp.com/api/events/$id/publish',
      {},
    );
  }

  Future<Map<String, dynamic>> cancelEvent(
      {required int id, required Map<String, dynamic> data}) {
    return apiUtil.apiRequestPost(
      'https://myevent-android-api.herokuapp.com/api/events/$id/cancel',
      data,
    );
  }

  Future<Map<String, dynamic>> shareFile({
    required int id,
    required Map<String, dynamic> data,
  }) {
    return apiUtil.apiRequestMultipartPost(
      url: 'https://myevent-android-api.herokuapp.com/api/events/$id/share',
      data: data,
    );
  }
}
