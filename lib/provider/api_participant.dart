import 'package:myevent_android/util/api_util.dart';

final apiParticipant = ApiParticipant();

class ApiParticipant {
  Future<Map<String, dynamic>> getParticipantWait(int eventId) {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/participants/wait',
    );
  }

  Future<Map<String, dynamic>> getParticipantConfirmed(int eventId) {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/participants/confirmed',
    );
  }

  Future<Map<String, dynamic>> getDetailParticipantWait({
    required int eventId,
    required participantId,
  }) {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/participant/$participantId',
    );
  }

  Future<Map<String, dynamic>> confirmPayment({
    required int eventId,
    required int participantId,
  }) {
    return apiUtil.apiRequestPost(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/participant/$participantId/confirm',
      {},
    );
  }

  Future<Map<String, dynamic>> rejectPayment({
    required int eventId,
    required int participantId,
    required String message,
  }) {
    return apiUtil.apiRequestPost(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/participant/$participantId/reject',
      {
        'message': '$message',
      },
    );
  }
}
