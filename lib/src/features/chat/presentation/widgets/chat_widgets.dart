import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget stickerChip(
  String label,
  Color color, {
  double rot = 0,
  bool isSelected = false,
}) {
  return Transform.rotate(
    angle: rot,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isSelected ? color : Colors.transparent,
        border: Border.all(
          color: isSelected ? Colors.white : Colors.white24,
          width: 2.5.w,
        ),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: Offset(4.w, 4.h),
                  ),
                ]
                : null,
      ),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.robotoCondensed(
          fontWeight: FontWeight.w900,
          fontSize: 16.sp,
          color: isSelected ? Colors.black : Colors.white24,
        ),
      ),
    ),
  );
}

Widget buildLargeChatTile({
  required String name,
  required String message,
  required String asset,
  required bool isEvent,
  required String time,
  required VoidCallback ontap,
}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      margin: EdgeInsets.only(bottom: 25.h),
      padding: EdgeInsets.all(22.r),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(35.r),
      ),
      child: Row(
        children: [
          // Avatar with the thick colored border
          Container(
            padding: EdgeInsets.all(3.5.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors:
                    isEvent
                        ? [const Color(0xFF0047FF), const Color(0xFF00D1FF)]
                        : [const Color(0xFFF2BC56), const Color(0xFFF9E364)],
              ),
            ),
            child: CircleAvatar(
              radius: 35.r,
              backgroundImage: AssetImage(asset),
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 20.sp,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.poppins(
                        color: Colors.white24,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    color: Colors.white60,
                    fontSize: 15.sp,
                    height: 1.3,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Icon(Icons.arrow_forward_ios, color: Colors.white10, size: 18.sp),
        ],
      ),
    ),
  );
}
