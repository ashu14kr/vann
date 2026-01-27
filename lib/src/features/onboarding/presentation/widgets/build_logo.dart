import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildLogo extends StatelessWidget {
  const BuildLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          'VANN',
          style: GoogleFonts.robotoCondensed(
            fontSize: 42.sp,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6.w
                  ..color = Colors.white,
          ),
        ),
        Text(
          'VANN',
          style: GoogleFonts.robotoCondensed(
            fontSize: 42.sp,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: Colors.black, // Filled black as per your second screenshot
          ),
        ),
      ],
    );
  }
}
