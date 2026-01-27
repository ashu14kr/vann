import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import

class MapDisclosurePainter extends CustomPainter {
  final List<Offset> revealedHexCenters;
  final double zoomLevel;

  MapDisclosurePainter({
    required this.revealedHexCenters,
    required this.zoomLevel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (revealedHexCenters.isEmpty) return;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Dynamic scaling based on zoom - using .r for base radius scaling
    double baseRadius = 45.0.r;
    num scaleFactor = math.pow(2, (zoomLevel - 13.0));
    double finalRadius = baseRadius * scaleFactor;

    Path combinedPath = Path();
    for (var center in revealedHexCenters) {
      combinedPath = Path.combine(
        PathOperation.union,
        combinedPath,
        _getHexPath(center, finalRadius),
      );
    }

    // 1. Draw Vertical Gradient Fog
    canvas.saveLayer(rect, Paint());
    final Paint fogPaint =
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1E3A5F).withOpacity(0.98),
              const Color(0xFF2B558F).withOpacity(0.85),
            ],
          ).createShader(rect);

    canvas.drawRect(rect, fogPaint);

    // 2. Erase Hexagons
    canvas.drawPath(combinedPath, Paint()..blendMode = BlendMode.clear);
    canvas.restore();

    // 3. Draw Perimeter Border
    canvas.drawPath(
      combinedPath,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth =
            3.0
                .w // Applied .w for responsive border thickness
        ..strokeJoin = StrokeJoin.round,
    );
  }

  Path _getHexPath(Offset center, double radius) {
    var path = Path();
    var angle = (math.pi * 2) / 6;
    for (int i = 0; i < 6; i++) {
      double x = center.dx + radius * math.cos(angle * i - math.pi / 2);
      double y = center.dy + radius * math.sin(angle * i - math.pi / 2);
      if (i == 0)
        path.moveTo(x, y);
      else
        path.lineTo(x, y);
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(MapDisclosurePainter oldDelegate) => true;
}
