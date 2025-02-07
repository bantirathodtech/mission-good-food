// open_route_service.dart
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:latlong2/latlong.dart';

import '../../../exceptions/app_exception.dart';

class OpenRouteService {
  final String apiKey;
  final Dio _dio = Dio();
  static const String baseUrl = 'https://api.openrouteservice.org/v2';

  OpenRouteService({required this.apiKey});

  Future<Map<String, dynamic>> getDirections({
    required LatLng start,
    required LatLng end,
    String profile = 'driving-car',
  }) async {
    try {
      final response = await _dio.post(
        '$baseUrl/directions/$profile',
        options: Options(
          headers: {'Authorization': apiKey},
        ),
        data: {
          'coordinates': [
            [start.longitude, start.latitude],
            [end.longitude, end.latitude],
          ],
        },
      );
      return response.data;
    } catch (e) {
      throw AppException('Failed to get directions: $e');
    }
  }

  Future<Map<String, dynamic>> getIsochrones({
    required LatLng center,
    required List<int> ranges,
    String profile = 'driving-car',
  }) async {
    try {
      final response = await _dio.post(
        '$baseUrl/isochrones/$profile',
        options: Options(
          headers: {'Authorization': apiKey},
        ),
        data: {
          'locations': [
            [center.longitude, center.latitude]
          ],
          'range': ranges,
        },
      );
      return response.data;
    } catch (e) {
      throw AppException('Failed to get isochrones: $e');
    }
  }
}
