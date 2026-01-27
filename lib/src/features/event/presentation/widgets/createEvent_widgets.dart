import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../onboarding/presentation/widgets/interest_card.dart';

Widget buildGrabHandle() {
  return Center(
    child: Container(
      width: 50.w,
      height: 6.h,
      margin: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  );
}

Widget buildBadge() {
  return Center(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        'NEW EVENT',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget buildVibeWrap(
  List<String> vibes,
  Function(int index) onTap,
  List<int> selectedIndices,
) {
  return Wrap(
    spacing: 12.w,
    runSpacing: 15.h,
    children: List.generate(vibes.length, (index) {
      final double rotation = (Random(index).nextDouble() * 0.12) - 0.06;
      return Transform.rotate(
        angle: rotation,
        child: InterestCard(
          label: vibes[index],
          isRounded: index % 2 == 0,
          isSelected: selectedIndices.contains(index),
          onTap: () => onTap(index), // Fixed: Wrapped in a closure
        ),
      );
    }),
  );
}

Widget buildPublishButton() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 18.h),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFF2BC56), Color(0xFFF9E364)],
      ),
      borderRadius: BorderRadius.circular(35.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 20.r,
          offset: Offset(0, 10.h),
        ),
      ],
    ),
    child: Text(
      'PUBLISH',
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
      ),
    ),
  );
}

Widget buildFullDetailsBox(TextStyle style) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF1A1A1A),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Column(
      children: [
        buildDetailRow(
          'Location',
          'London',
          style,
          icon: Icons.location_on_outlined,
        ),
        buildDetailRow(
          'Starts',
          'Today',
          style,
          icon: Icons.calendar_today_outlined,
        ),
        buildDetailRow(
          'Ends',
          'Tomorrow',
          style,
          icon: Icons.calendar_month_outlined,
        ),
        buildDetailRow('Price', 'Free', style, icon: Icons.payments_outlined),
        buildDetailRow(
          'Group capacity',
          'Any',
          style,
          icon: Icons.group_outlined,
          isLast: true,
        ),
      ],
    ),
  );
}

Widget buildDetailRow(
  String label,
  String value,
  TextStyle style, {
  required IconData icon,
  bool isLast = false,
}) {
  return Container(
    padding: EdgeInsets.all(18.r),
    decoration: BoxDecoration(
      border:
          isLast
              ? null
              : Border(bottom: BorderSide(color: Colors.white10, width: 0.8.w)),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white54, size: 20.sp),
        SizedBox(width: 12.w),
        Text(
          label,
          style: style.copyWith(color: Colors.white, fontSize: 16.sp),
        ),
        const Spacer(),
        Text(
          value,
          style: style.copyWith(color: Colors.white38, fontSize: 16.sp),
        ),
        SizedBox(width: 5.w),
        Icon(Icons.chevron_right, color: Colors.white24, size: 20.sp),
      ],
    ),
  );
}

Widget buildTextField({
  required String hint,
  required TextStyle fontStyle,
  int maxLines = 1,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1A1A),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: TextField(
      maxLines: maxLines,
      style: fontStyle.copyWith(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: fontStyle.copyWith(color: Colors.white24, fontSize: 14.sp),
        border: InputBorder.none,
        isDense: true,
      ),
    ),
  );
}
