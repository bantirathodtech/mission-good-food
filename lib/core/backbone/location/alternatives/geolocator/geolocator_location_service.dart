// lib/src/services/geolocator_service.dart
import 'package:geolocator/geolocator.dart';

import '../../../exceptions/app_exception.dart';

class GeolocatorService {
  static final GeolocatorService _instance = GeolocatorService._internal();
  factory GeolocatorService() => _instance;
  GeolocatorService._internal();

  Future<Position> getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw AppException('Location services are disabled',
            code: 'LOCATION_DISABLED');
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw AppException('Location permissions are denied',
              code: 'PERMISSION_DENIED');
        }
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      throw AppException('Failed to get location',
          code: 'LOCATION_ERROR', details: e.toString());
    }
  }

  Stream<Position> getLocationUpdates({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 10,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }
}
