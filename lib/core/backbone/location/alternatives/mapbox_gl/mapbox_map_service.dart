// // lib/src/services/mapbox_service.dart
// import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
//
// import '../../../exceptions/app_exception.dart';
//
// class MapboxService {
//   late MapboxMapController _mapController;
//   final String accessToken;
//
//   MapboxService({required this.accessToken});
//
//   void _onMapCreated(MapboxMapController controller) {
//     _mapController = controller;
//   }
//
//   Widget buildMap({
//     required LatLng initialPosition,
//     double zoom = 13.0,
//     bool showUserLocation = true,
//     OnMapClickCallback? onMapClick,
//   }) {
//     return MapboxMap(
//       accessToken: accessToken,
//       initialCameraPosition: CameraPosition(
//         target: initialPosition,
//         zoom: zoom,
//       ),
//       onMapCreated: _onMapCreated,
//       onMapClick: onMapClick,
//       myLocationEnabled: showUserLocation,
//       myLocationTrackingMode: MyLocationTrackingMode.Tracking,
//     );
//   }
//
//   Future<void> addMarker(LatLng position, String title) async {
//     try {
//       await _mapController.addSymbol(
//         SymbolOptions(
//           geometry: position,
//           textField: title,
//           textOffset: const Offset(0, 2),
//           iconSize: 1.5,
//         ),
//       );
//     } catch (e) {
//       throw AppException('Failed to add marker',
//           code: 'MARKER_ERROR', details: e.toString());
//     }
//   }
//
//   Future<void> drawRoute(List<LatLng> routeCoordinates) async {
//     try {
//       await _mapController.addLine(
//         LineOptions(
//           geometry: routeCoordinates,
//           lineColor: "#FF0000",
//           lineWidth: 3.0,
//           lineOpacity: 0.8,
//         ),
//       );
//     } catch (e) {
//       throw AppException('Failed to draw route',
//           code: 'ROUTE_ERROR', details: e.toString());
//     }
//   }
//
//   void dispose() {
//     _mapController.dispose();
//   }
// }
