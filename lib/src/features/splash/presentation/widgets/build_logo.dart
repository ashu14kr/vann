import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildLogo extends StatelessWidget {
  const BuildLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // THE BORDER LAYER
        Text(
          'VANN',
          style: GoogleFonts.robotoCondensed(
            fontSize: 80.sp, // .sp for font scaling
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            letterSpacing: -5.w, // .w for horizontal spacing
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth =
                      10
                          .w // .w so the border thickens on larger screens
                  ..color = Colors.white,
          ),
        ),
        // THE FILL LAYER
        Text(
          'VANN',
          style: GoogleFonts.robotoCondensed(
            fontSize: 80.sp, // .sp to match the border layer
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: Colors.black,
            letterSpacing: -5.w, // .w to match the border layer
          ),
        ),
      ],
    );
  }
}
