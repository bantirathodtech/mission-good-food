// location/location_service.dart
import 'package:geolocator/geolocator.dart';

import '../utils/constants.dart';

class LocationService {
  static String currentLatitude = "0.0";
  static String currentLongitude = "0.0";

  // Check location permissions and get the current location
  static Future<void> checkLocationPermission() async {
    try {
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();
      printMessage("Permission Granted");
      await getCurrentLocation();
    } catch (e) {
      printMessage("Error checking location permission: $e");
    }
  }

  // Fetch the current location and update latitude/longitude
  static Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      if (checkStatus(position.latitude.toString())) {
        currentLatitude = checkString(position.latitude.toString());
        currentLongitude = checkString(position.longitude.toString());
      }
      printMessage("currentLatitude: $currentLatitude");
      printMessage("currentLongitude: $currentLongitude");
    } catch (e) {
      printMessage("Error getting location: $e");
    }
  }

  // Get the current position, if available
  static Future<Position?> getPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      printMessage("Error getting position: $e");
      return null;
    }
  }
}
