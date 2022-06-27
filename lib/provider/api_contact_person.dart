import 'package:myevent_android/util/api_util.dart';

final apiContactPerson = ApiContactPerson();

class ApiContactPerson {
  Future<Map<String, dynamic>> getContactPersonSocialMedia() {
    return apiUtil.apiRequestGet(
        'https://myevent-android-api.herokuapp.com/api/events/social-medias');
  }
}
