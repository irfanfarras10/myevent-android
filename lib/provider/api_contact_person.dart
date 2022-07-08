import 'package:myevent_android/model/api_request/create_contact_person_api_request_model.dart';
import 'package:myevent_android/util/api_util.dart';

final apiContactPerson = ApiContactPerson();

class ApiContactPerson {
  Future<Map<String, dynamic>> getContactPersonSocialMedia() {
    return apiUtil.apiRequestGet(
        'https://myevent-android-api.herokuapp.com/api/events/social-medias');
  }

  Future<Map<String, dynamic>> createContactPerson(
      {required String eventId,
      required CreateContactPersonApiRequestModel requestBody}) {
    return apiUtil.apiRequestPost(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/contact-person/create',
      requestBody.toJson(),
    );
  }

  Future<Map<String, dynamic>> updateContactPerson(
      {required String eventId,
      required String contactPersonId,
      required CreateContactPersonApiRequestModel requestBody}) {
    return apiUtil.apiRequestPut(
      'https://myevent-android-api.herokuapp.com/api/events/$eventId/contact-person/$contactPersonId',
      requestBody.toJson(),
    );
  }
}
