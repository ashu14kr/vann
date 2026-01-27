import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/general_widget.dart';
import 'widgets/map_disclosure_painter.dart';

class TravelProgressScreen extends StatefulWidget {
  const TravelProgressScreen({super.key});

  @override
  State<TravelProgressScreen> createState() => _TravelProgressScreenState();
}

class _TravelProgressScreenState extends State<TravelProgressScreen> {
  AppleMapController? _mapController;

  // 1. FIXED GPS LOCATIONS
  final List<LatLng> _discoveredLatLngs = [
    const LatLng(39.0490, -77.1197), // Center (Rockville)
    const LatLng(39.0580, -77.1197), // North
    const LatLng(39.0445, -77.1060), // South-East
    const LatLng(39.0445, -77.1330), // South-West
  ];

  // 2. STATE FOR PAINTER
  List<Offset> _revealedHexCenters = [];
  double _currentZoom = 13.0;

  // CRASH-PROOF COORDINATE CONVERSION
  Future<void> _updateHexPositions() async {
    if (_mapController == null) return;

    List<Offset> newOffsets = [];
    for (LatLng latLng in _discoveredLatLngs) {
      try {
        final dynamic result = await _mapController!.getScreenCoordinate(
          latLng,
        );

        if (result != null) {
          double x = 0;
          double y = 0;

          if (result is Offset) {
            x = result.dx;
            y = result.dy;
          } else {
            try {
              x = (result.x ?? result['x']).toDouble();
              y = (result.y ?? result['y']).toDouble();
            } catch (_) {
              x = result.dx;
              y = result.dy;
            }
          }
          newOffsets.add(Offset(x, y));
        }
      } catch (e) {
        debugPrint("Conversion error: $e");
      }
    }

    if (mounted) {
      setState(() {
        _revealedHexCenters = newOffsets;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // LAYER 1: THE MAP
          AppleMap(
            initialCameraPosition: CameraPosition(
              target: _discoveredLatLngs[0],
              zoom: _currentZoom,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
              _updateHexPositions();
            },
            onCameraMove: (position) {
              _currentZoom = position.zoom;
              _updateHexPositions();
            },
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            pitchGesturesEnabled: true,
            rotateGesturesEnabled: true,
          ),

          // LAYER 2: THE GRADIENT FOG
          IgnorePointer(
            ignoring: true,
            child: SizedBox(
              width: 1.sw, // ScreenUtil Width
              height: 1.sh, // ScreenUtil Height
              child: CustomPaint(
                painter: MapDisclosurePainter(
                  revealedHexCenters: _revealedHexCenters,
                  zoomLevel: _currentZoom,
                ),
              ),
            ),
          ),

          // LAYER 3: UI HEADER
          buildHeader(context),
        ],
      ),
    );
  }
}
