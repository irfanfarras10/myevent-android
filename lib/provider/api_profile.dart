import 'package:myevent_android/util/api_util.dart';

final apiProfile = ApiProfile();

class ApiProfile {
  Future<Map<String, dynamic>> viewProfile() {
    return apiUtil.apiRequestGet('organizer/profile');
  }
}
