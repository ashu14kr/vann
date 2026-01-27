import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildStrokedText(String text) {
  return Stack(
    children: [
      Text(
        text,
        style: GoogleFonts.robotoCondensed(
          fontSize: 34.sp,
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
        text,
        style: GoogleFonts.robotoCondensed(
          fontSize: 34.sp,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget buildHeader(BuildContext context) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildStrokedText("UNITED STATES"),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.black54,
              child: Icon(Icons.close, color: Colors.white, size: 28.sp),
            ),
          ),
        ],
      ),
    ),
  );
}
