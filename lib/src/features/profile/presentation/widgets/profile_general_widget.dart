import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildTopActions() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        icon: Icon(
          Icons.edit_square,
          color: const Color.fromARGB(197, 255, 255, 255),
          size: 36.sp,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.settings,
          color: const Color.fromARGB(194, 255, 255, 255),
          size: 36.sp,
        ),
        onPressed: () {},
      ),
    ],
  );
}

Widget buildAvatarWithName() {
  return Column(
    children: [
      Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 255, 255, 255),
                width: 5.w,
              ),
            ),
            child: CircleAvatar(
              radius: 75.r,
              backgroundImage: const AssetImage('assets/images/profile.png'),
            ),
          ),
          Positioned(
            bottom: -35.h,
            child: Column(
              children: [nameSticker("SAM"), nameSticker("ALTMAN")],
            ),
          ),
        ],
      ),
      SizedBox(height: 55.h),
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
            letterSpacing: -1.w,
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
            letterSpacing: -1.w,
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
    mainAxisAlignment: MainAxisAlignment.center,
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
          Icon(Icons.verified, color: Colors.blueAccent, size: 35.sp),
        ],
      ),
      SizedBox(height: 2.h),
      Text(
        "🎂 27yo 📍USA",
        style: GoogleFonts.poppins(
          color: const Color.fromARGB(219, 255, 255, 255),
          fontSize: 16.sp,
        ),
      ),
    ],
  );
}

Widget buildSectionHeader(String title, {bool hasViewAll = false}) {
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
      if (hasViewAll)
        Text(
          "View All",
          style: TextStyle(color: Colors.white54, fontSize: 14.sp),
        ),
    ],
  );
}

Widget buildCategoryTabs() {
  final List<String> tabs = ["Upcoming", "Hosting", "Saved", "Happened"];
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children:
          tabs
              .map(
                (tab) => Container(
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Text(
                    tab,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              )
              .toList(),
    ),
  );
}

Widget buildEventCard(VoidCallback ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
      height: 280.h,
      width: 200.w,
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
            colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35.h,
              child: Stack(
                children: List.generate(
                  3,
                  (i) => Positioned(
                    left: i * 24.0.w,
                    child: CircleAvatar(
                      radius: 19.r,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 16.r,
                        backgroundImage: const AssetImage(
                          'assets/images/profile.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Sunset Camp",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Sun, 2 Feb 2026  12:00 - 18:00 PM",
              style: GoogleFonts.poppins(
                color: Colors.white60,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildVehicleCard() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(25.r),
    child: Image.asset(
      'assets/images/van.jpg',
      width: double.infinity,
      height: 220.h,
      fit: BoxFit.cover,
    ),
  );
}
