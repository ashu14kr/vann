import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget genderOption(BuildContext context, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0.h),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 32.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Widget buildDashedDivider() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 80.0.w),
    child: Row(
      children: List.generate(
        30,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0 ? Colors.transparent : Colors.white24,
            height: 1.h,
          ),
        ),
      ),
    ),
  );
}
