import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dash_painter.dart';

Widget buildGrabHandle() {
  return Center(
    child: Container(
      width: 55.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  );
}

Widget buildTopActions() {
  return Align(
    alignment: Alignment.centerRight,
    child: Icon(Icons.settings, color: Colors.white54, size: 32.sp),
  );
}

Widget buildAvatarWithDynamicName(String fullName) {
  final names = fullName.split(" ");
  return Column(
    children: [
      Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4.w),
            ),
            child: CircleAvatar(
              radius: 75.r,
              backgroundImage: const AssetImage('assets/images/profile.png'),
            ),
          ),
          Positioned(
            bottom: -35.h,
            child: Column(
              children:
                  names.map((name) => nameSticker(name.toUpperCase())).toList(),
            ),
          ),
        ],
      ),
      SizedBox(height: 50.h),
    ],
  );
}

Widget nameSticker(String text) {
  return Padding(
    padding: EdgeInsets.only(top: 1.h),
    child: Stack(
      children: [
        Text(
          text,
          style: GoogleFonts.robotoCondensed(
            fontSize: 38.sp,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            height: 1,
            foreground:
                Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 8.w
                  ..color = Colors.white,
          ),
        ),
        Text(
          text,
          style: GoogleFonts.robotoCondensed(
            fontSize: 38.sp,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            height: 1,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Widget buildIdentityBadges() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "🚐 Weekend Traveller",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 10.w),
          Icon(Icons.verified, color: Colors.blueAccent, size: 28.sp),
        ],
      ),
      SizedBox(height: 4.h),
      Text(
        "🎂 27yo  📍 USA",
        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16.sp),
      ),
    ],
  );
}

Widget buildPlacesBanner() {
  return Container(
    height: 120.h,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.r),
      image: const DecorationImage(
        image: AssetImage('assets/images/map_view.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            const Color(0xFF0047FF).withOpacity(0.9),
            const Color(0xFF0047FF).withOpacity(0.4),
          ],
        ),
      ),
      child: Stack(
        children: [
          buildDashedBorder(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildPlacesStrokedText("10"),
                buildPlacesStrokedText("Places"),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.asset('assets/images/cool_sticker.png', height: 100.h),
          ),
        ],
      ),
    ),
  );
}

Widget buildPlacesStrokedText(String text) {
  final double fs = text == "10" ? 42.sp : 28.sp;
  return Stack(
    children: [
      Text(
        text,
        style: GoogleFonts.robotoCondensed(
          fontSize: fs,
          fontWeight: FontWeight.w900,
          height: 1.1,
          foreground:
              Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6.w
                ..color = Colors.black,
        ),
      ),
      Text(
        text,
        style: GoogleFonts.robotoCondensed(
          fontSize: fs,
          fontWeight: FontWeight.w900,
          height: 1.1,
          color: Colors.white,
        ),
      ),
    ],
  );
}

Widget buildDashedBorder() {
  return Container(
    margin: EdgeInsets.all(6.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: Colors.transparent),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: CustomPaint(painter: DashPainter(), child: Container()),
    ),
  );
}

Widget buildSectionHeader(String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: GoogleFonts.robotoCondensed(
          color: Colors.white,
          fontSize: 28.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
      if (title == "My Baby")
        Text(
          "View All",
          style: TextStyle(color: Colors.white54, fontSize: 14.sp),
        ),
    ],
  );
}

Widget buildEventCard() {
  return Container(
    height: 280.h,
    width: double.infinity,
    alignment: Alignment.bottomLeft,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.r),
      image: const DecorationImage(
        image: AssetImage('assets/images/event.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sunset Camp",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Sun, 2 Feb 2026",
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          ),
        ],
      ),
    ),
  );
}

Widget buildInterestsWrap() {
  final List<Map<String, dynamic>> tags = [
    {'text': 'TROLLING', 'color': Colors.yellow, 'rot': -0.05},
    {'text': 'CRICKET', 'color': const Color(0xFFA066FF), 'rot': 0.04},
    {'text': 'CAMPING', 'color': const Color(0xFF00FF75), 'rot': -0.03},
    {'text': 'OFF-ROADING', 'color': Colors.white, 'rot': 0.05},
    {'text': 'HIKING', 'color': const Color(0xFF00D1FF), 'rot': -0.02},
  ];

  return Wrap(
    spacing: 12.w,
    runSpacing: 18.h,
    children:
        tags
            .map(
              (tag) => Transform.rotate(
                angle: tag['rot'],
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: tag['color'],
                    border: Border.all(color: Colors.white, width: 2.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(4.w, 4.h),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    tag['text'],
                    style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
                      letterSpacing: -0.5.w,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
  );
}

Widget buildVehicleCard() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(25.r),
    child: Image.asset(
      'assets/images/van.jpg',
      height: 220.h,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  );
}

Widget buildConnectButton() {
  return Container(
    width: double.infinity,
    height: 65.h,
    decoration: BoxDecoration(
      color: const Color(0xFFFFE600),
      borderRadius: BorderRadius.circular(35.r),
    ),
    child: Center(
      child: Text(
        "Connect",
        style: GoogleFonts.robotoCondensed(
          color: Colors.black,
          fontSize: 26.sp,
          fontWeight: FontWeight.w900,
        ),
      ),
    ),
  );
}
