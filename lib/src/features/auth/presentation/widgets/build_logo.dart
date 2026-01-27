import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:google_fonts/google_fonts.dart';

class BuildLogo extends StatelessWidget {
  const BuildLogo({super.key});

  @override
  Widget build(BuildContext context) {
    // Shared text style values for consistency
    final double fontSize = 50.sp; // Scalable pixels for font
    final double letterSpacing = -2.w; // Scalable width for spacing

    return Stack(
      children: [
        // 1. STROKE / BORDER LAYER
        Text(
          'VANN',
          style: GoogleFonts.robotoCondensed(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            letterSpacing: letterSpacing,
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth =
                      8
                          .w // Scalable width for the border thickness
                  ..color = Colors.white,
          ),
        ),
        // 2. FILL LAYER
        Text(
          'VANN',
          style: GoogleFonts.robotoCondensed(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: Colors.black,
            letterSpacing: letterSpacing,
          ),
        ),
      ],
    );
  }
}
