import 'package:geolocator/geolocator.dart';

class GeolacatorService {
  Future<Position> getLocation() async {
    var geolocator = Geolocator();
    return geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        locationPermissionLevel: GeolocationPermission.location);
  }
}
