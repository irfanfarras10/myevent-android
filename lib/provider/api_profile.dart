import 'package:myevent_android/model/api_request/update_profile_api_request_model.dart';
import 'package:myevent_android/util/api_util.dart';

final apiProfile = ApiProfile();

class ApiProfile {
  Future<Map<String, dynamic>> viewProfile() {
    return apiUtil.apiRequestGet(
        'https://myevent-android-api.herokuapp.com/api/organizer');
  }

  Future<Map<String, dynamic>> updateProfile({
    required UpdateProfileApiRequestModel requestBody,
  }) {
    return apiUtil.apiRequestPut(
      'https://myevent-android-api.herokuapp.com/api/organizer',
      requestBody.toJson(),
    );
  }
}
