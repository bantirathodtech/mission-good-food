import 'google_location/geolocation_api_service.dart';
import 'google_map/google_maps_service.dart';

class GoogleLocationManager {
  final GeolocationService _geolocation = GeolocationService();
  final GoogleMapsHandler _mapsHandler = GoogleMapsHandler();

  Future<void> fetchAndShowLocation(String apiKey) async {
    final locationData = await _geolocation.fetchCurrentLocation(apiKey);
    print('Location: ${locationData['location']}');
  }

  GoogleMapsHandler get mapsHandler => _mapsHandler;
}
