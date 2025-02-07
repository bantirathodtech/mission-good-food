// lib/src/services/geocoding_service.dart
import 'package:geocoding/geocoding.dart';

import '../../../exceptions/app_exception.dart';

class GeocodingService {
  static final GeocodingService _instance = GeocodingService._internal();
  factory GeocodingService() => _instance;
  GeocodingService._internal();

  Future<List<Placemark>> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      return await placemarkFromCoordinates(latitude, longitude);
    } catch (e) {
      throw AppException('Failed to get address',
          code: 'GEOCODING_ERROR', details: e.toString());
    }
  }

  Future<List<Location>> getCoordinatesFromAddress(String address) async {
    try {
      return await locationFromAddress(address);
    } catch (e) {
      throw AppException('Failed to get coordinates',
          code: 'GEOCODING_ERROR', details: e.toString());
    }
  }

  String formatAddress(Placemark placemark) {
    return '${placemark.street}, ${placemark.locality}, ${placemark.country}'
        .replaceAll(RegExp(r', ,'), ',')
        .replaceAll(RegExp(r'null,?'), '')
        .trim()
        .replaceAll(RegExp(r',+'), ',')
        .replaceAll(RegExp(r'^,|,$'), '');
  }
}
