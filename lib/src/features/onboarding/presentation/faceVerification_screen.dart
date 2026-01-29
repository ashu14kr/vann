import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:van_life/src/features/onboarding/presentation/widgets/build_logo.dart';

class FaceVerificationScreen extends StatefulWidget {
  const FaceVerificationScreen({super.key});

  @override
  State<FaceVerificationScreen> createState() => _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends State<FaceVerificationScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool isAligned = false; // Toggle for demo; used for green border logic

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    final front = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      front,
      ResolutionPreset.max,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        children: [
          // 1. FULL SCREEN CAMERA FEED
          Positioned.fill(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    _controller != null) {
                  // Scaling logic to ensure full screen coverage without "sinking"
                  final size = MediaQuery.of(context).size;
                  var scale = size.aspectRatio * _controller!.value.aspectRatio;
                  if (scale < 1) scale = 1 / scale;

                  return Transform.scale(
                    scale: scale,
                    child: Center(child: CameraPreview(_controller!)),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              },
            ),
          ),

          // 2. THE CUTOUT OVERLAY (Black screen with oval hole)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: HolePainter(
                  borderColor:
                      isAligned ? Colors.green : Colors.white.withOpacity(0.4),
                  isDashed: true,
                ),
              ),
            ),
          ),

          // 3. TOP NAVIGATION BAR
          Positioned(
            top: 100.h,
            left: 10.w,
            right: 10.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [BuildLogo()],
            ),
          ),
          // 5. CAPTURE BUTTON (Visible always or only when aligned)
          Positioned(
            bottom: 120.h,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  // For demo purposes, first tap aligns, second tap "takes" picture
                  if (!isAligned) {
                    setState(() => isAligned = true);
                  } else {
                    final image = await _controller?.takePicture();
                    print("Image captured: ${image?.path}");
                    context.go('/onboarding-accountLoading');
                  }
                },
                child: Container(
                  height: 120.h,
                  width: 120.h,
                  decoration: BoxDecoration(
                    color: isAligned ? Colors.green : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: isAligned ? Colors.white : Colors.black,
                    size: 55.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// THE PAINTER: Creates the dark overlay and the dashed oval
class HolePainter extends CustomPainter {
  final Color borderColor;
  final bool isDashed;

  HolePainter({required this.borderColor, this.isDashed = false});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Semi-transparent overlay
    final paint = Paint()..color = const Color(0xFF121212).withOpacity(0.85);
    final fullRect =
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // 2. Oval path
    final holePath =
        Path()..addOval(
          Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2 - 40.h),
            width: 260.w,
            height: 380.h,
          ),
        );

    // 3. Subtract oval from full screen
    final path = Path.combine(PathOperation.difference, fullRect, holePath);
    canvas.drawPath(path, paint);

    // 4. Dash logic for the border
    final borderPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;

    if (isDashed) {
      double dashWidth = 5.0;
      double dashSpace = 5.0;
      double startAngle = 0.0;

      // We draw arc segments to simulate a dashed oval
      Rect rect = Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2 - 40.h),
        width: 260.w,
        height: 380.h,
      );

      while (startAngle < 2 * 3.14159) {
        canvas.drawArc(rect, startAngle, 0.05, false, borderPaint);
        startAngle += 0.1;
      }
    } else {
      canvas.drawPath(holePath, borderPaint);
    }
  }

  @override
  bool shouldRepaint(HolePainter oldDelegate) =>
      oldDelegate.borderColor != borderColor;
}
