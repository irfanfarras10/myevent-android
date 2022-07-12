import 'package:myevent_android/util/api_util.dart';

final apiParticipant = ApiParticipant();

class ApiParticipant {
  Future<Map<String, dynamic>> getParticipantWait(int eventId) {
    return apiUtil.apiRequestGet(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/participants/wait',
    );
  }
}
