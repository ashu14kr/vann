import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestCard extends StatelessWidget {
  final String label;
  final bool isRounded;
  final bool isSelected;
  final VoidCallback onTap;

  const InterestCard({
    super.key,
    required this.label,
    required this.isRounded,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF9181F4) : Colors.transparent,
          borderRadius:
              isRounded ? BorderRadius.circular(40.r) : BorderRadius.zero,
          border: Border.all(
            color: isSelected ? const Color(0xFF9181F4) : Colors.white,
            width: 3.0.w,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.robotoCondensed(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
