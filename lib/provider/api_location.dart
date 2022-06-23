import 'package:myevent_android/util/api_util.dart';

final apiLocation = ApiLocation();

class ApiLocation {
  Future<Map<String, dynamic>> getLocation(String keyword) {
    return apiUtil.apiRequestGet(
        'https://api.geoapify.com/v1/geocode/autocomplete?text=$keyword&apiKey=26018a31a0aa41699818b7b50ea82935');
  }
}
