// File 1: geolocation/geolocation_api_service.dart

import 'dart:convert';

import 'package:http/http.dart' as http;

class GeolocationService {
  Future<Map<String, dynamic>> fetchCurrentLocation(String apiKey) async {
    final response = await http.post(
      Uri.parse(
          'https://www.googleapis.com/geolocation/v1/geolocate?key=$apiKey'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch location: ${response.statusCode}');
    }
  }
}
