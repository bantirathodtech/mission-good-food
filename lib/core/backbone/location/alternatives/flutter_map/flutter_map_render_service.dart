import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapRenderService {
  Widget buildOSMMap({
    required LatLng initialPosition,
    double initialZoom = 13.0,
    List<Marker> markers = const [],
    List<Polyline> routes = const [],
  }) {
    return FlutterMap(
      options: MapOptions(
        onTap: (tapPosition, point) {
          // Handle tap event
        },
        crs: const Epsg3857(),
        initialCenter: initialPosition,
        initialZoom: initialZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: markers),
        PolylineLayer(polylines: routes),
      ],
    );
  }

  Marker createMarker({
    required LatLng position,
    required String title,
    double width = 30.0,
    double height = 30.0,
  }) {
    return Marker(
      point: position,
      width: width,
      height: height,
      child: const Icon(Icons.location_pin), // Fixed Icon widget
    );
  }

  Polyline createRoute({
    required List<LatLng> points,
    Color color = Colors.blue,
    double strokeWidth = 3.0,
  }) {
    return Polyline(
      points: points,
      color: color,
      strokeWidth: strokeWidth,
    );
  }
}
