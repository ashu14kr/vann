import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildHeader(BuildContext context) {
  return Column(
    children: [
      SizedBox(height: 12.h),
      Container(
        width: 40.w,
        height: 4.h,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(30.w, 20.h, 30.w, 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "SETTINGS",
              style: GoogleFonts.robotoCondensed(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.white, size: 26),
            ),
          ],
        ),
      ),
      const Divider(color: Colors.white10, thickness: 1),
    ],
  );
}

Widget buildSectionLabel(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 12.h),
    child: Text(
      text,
      style: GoogleFonts.robotoCondensed(
        color: Colors.white30,
        fontSize: 11.sp,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
  );
}

Widget buildSettingsTile(String title, IconData icon, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20.sp),
          SizedBox(width: 15.w),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.white60, size: 12),
        ],
      ),
    ),
  );
}

Widget buildDangerSection(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(25.r),
    decoration: BoxDecoration(
      color: const Color(0xFF1A0A0A), // Very subtle red-black tint
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: Colors.red.withOpacity(0.1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DANGER ZONE",
          style: GoogleFonts.robotoCondensed(
            color: Colors.redAccent,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "Account deletion is permanent. All van data and community history will be wiped.",
          style: GoogleFonts.poppins(color: Colors.white38, fontSize: 12.sp),
        ),
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: () => confirmDelete(context),
          child: Text(
            "DELETE ACCOUNT",
            style: GoogleFonts.robotoCondensed(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    ),
  );
}

void confirmDelete(BuildContext context) {
  // Logic for Apple-required confirmation dialog
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF0F0F0F),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
    ),
    builder:
        (context) => Padding(
          padding: EdgeInsets.all(30.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "SURE YOU WANT TO LEAVE?",
                style: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              actionButton("DELETE PERMANENTLY", Colors.redAccent, () {}),
              SizedBox(height: 10.h),
              actionButton(
                "CANCEL",
                Colors.white10,
                () => Navigator.pop(context),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
  );
}

Widget actionButton(String text, Color bg, VoidCallback onTap) {
  return SizedBox(
    width: double.infinity,
    height: 55.h,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.robotoCondensed(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}
