import 'package:geocoding/geocoding.dart';

final locationUtil = LocationUtil();

class LocationUtil {
  Future<String> parseLocation(
    eventVenueCategory,
    String location,
  ) async {
    if (eventVenueCategory.id == 1) {
      final coordinate = location.split('|');
      final lat = double.parse(coordinate[0]);
      final lon = double.parse(coordinate[1]);
      final address = await placemarkFromCoordinates(lat, lon);
      return address[0].street!;
    } else {
      return 'Online Event';
    }
  }
}
