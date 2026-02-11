// import 'package:flutter/material.dart';
// import 'package:apple_maps_flutter/apple_maps_flutter.dart';
// import 'package:flutter_h3/flutter_h3.dart';

// class H3MaskedMap extends StatefulWidget {
//   const H3MaskedMap({super.key});
//   @override
//   State<H3MaskedMap> createState() => _H3MaskedMapState();
// }

// class _H3MaskedMapState extends State<H3MaskedMap> {
//   // 1. Your revealed IDs
//   final List<String> _revealedIds = ["86194ad47ffffff", "86194ad4fffffff"];
//   Set<Polygon> _mapPolygons = {};
//   int _res = 6;

//   // 2. This function builds the VISIBLE grid on top of the map
//   void _updateGrid(LatLng center) {
//     final Set<Polygon> tempPolygons = {};

//     // --- A. THE FOG (Optional but recommended for 'reveal' effect) ---
//     tempPolygons.add(
//       Polygon(
//         polygonId: PolygonId("global_dim"),
//         points: const [
//           LatLng(85, -179),
//           LatLng(85, 179),
//           LatLng(-85, 179),
//           LatLng(-85, -179),
//         ],
//         fillColor: Colors.black.withOpacity(0.6), // Dim the whole map
//         strokeWidth: 0,
//         zIndex: 1, // Base layer
//       ),
//     );

//     // --- B. THE HONEYCOMB PATTERN ---
//     // We generate a "disk" of hexagons around the user to create the grid texture
//     int centerIndex = FlutterH3.latLngToCell(
//       center.latitude,
//       center.longitude,
//       _res,
//     );
//     List<int> nearbyHexes = FlutterH3.gridDisk(
//       centerIndex,
//       4,
//     ); // Radius of 4 hexes

//     for (int h3Int in nearbyHexes) {
//       String h3Str = FlutterH3.h3ToString(h3Int);
//       List<Map<String, double>> boundary = FlutterH3.cellToBoundary(h3Int);
//       List<LatLng> points =
//           boundary.map((c) => LatLng(c['lat']!, c['lng']!)).toList();

//       bool isRevealed = _revealedIds.contains(h3Str);

//       tempPolygons.add(
//         Polygon(
//           polygonId: PolygonId(h3Str),
//           points: points,
//           zIndex: 2,
//           // If revealed: Clear window + Bright Border
//           // If hidden: Faint border to create the honeycomb texture
//           fillColor:
//               isRevealed ? Colors.transparent : Colors.white.withOpacity(0.05),
//           strokeColor: isRevealed ? Colors.cyanAccent : Colors.white10,
//           strokeWidth: isRevealed ? 4 : 1,
//         ),
//       );
//     }

//     setState(() => _mapPolygons = tempPolygons);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AppleMap(
//         initialCameraPosition: const CameraPosition(
//           target: LatLng(37.77, -122.41),
//           zoom: 10,
//         ),
//         polygons: _mapPolygons,
//         onCameraMove: (pos) => _updateGrid(pos.target),
//         onMapCreated: (ctrl) => _updateGrid(const LatLng(37.77, -122.41)),
//       ),
//     );
//   }
// }
