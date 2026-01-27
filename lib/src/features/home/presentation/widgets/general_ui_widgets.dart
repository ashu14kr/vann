import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildExploreLogo() {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 20.r,
          spreadRadius: 5.r,
        ),
      ],
    ),
    child: Stack(
      children: [
        Text(
          'EXPLORE',
          style: GoogleFonts.robotoCondensed(
            fontSize: 42.sp,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            letterSpacing: -2.w,
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 8.w
                  ..color = Colors.white,
          ),
        ),
        Text(
          'EXPLORE',
          style: GoogleFonts.robotoCondensed(
            fontSize: 42.sp,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: Colors.black,
            letterSpacing: -2.w,
          ),
        ),
      ],
    ),
  );
}

Widget buildCircularNavIcon(
  IconData icon, {
  bool isLarge = false,
  bool isSmall = false,
  required VoidCallback ontap,
}) {
  double size = isLarge ? 80.r : 70.r;
  return InkWell(
    onTap: ontap,
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: isLarge ? 40.sp : 30.sp),
    ),
  );
}
