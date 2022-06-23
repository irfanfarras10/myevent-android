import 'package:myevent_android/model/api_request/signin_api_request_model.dart';
import 'package:myevent_android/model/api_request/signup_api_request_model.dart';
import 'package:myevent_android/util/api_util.dart';

final apiAuth = ApiAuth();

class ApiAuth {
  Future<Map<String, dynamic>> signIn({
    required SignInApiRequestModel apiRequest,
  }) {
    return apiUtil.apiRequestPost(
        'https://myevent-android-api.herokuapp.com/api/auth/signin',
        apiRequest.toJson());
  }

  Future<Map<String, dynamic>> signUp({
    required SignUpApiRequestModel apiRequest,
  }) {
    return apiUtil.apiRequestPost(
        'https://myevent-android-api.herokuapp.com/api/auth/signup',
        apiRequest.toJson());
  }
}
