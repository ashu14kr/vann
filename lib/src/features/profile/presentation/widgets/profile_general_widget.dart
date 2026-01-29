import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildTopActions({
  required VoidCallback edit,
  required VoidCallback settings,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
        icon: Icon(
          Icons.edit_square,
          color: const Color.fromARGB(197, 255, 255, 255),
          size: 36.sp,
        ),
        onPressed: edit,
      ),
      IconButton(
        icon: Icon(
          Icons.settings,
          color: const Color.fromARGB(194, 255, 255, 255),
          size: 36.sp,
        ),
        onPressed: settings,
      ),
    ],
  );
}

Widget buildAvatarWithName({
  required List<String> image,
  required String name,
}) {
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
              backgroundImage:
                  image.isEmpty
                      ? AssetImage('assets/images/male_avatar.png')
                      : NetworkImage(image[0]),
            ),
          ),
          Positioned(
            bottom: -35.h,
            child: Column(
              children: [
                nameSticker(name),
                // nameSticker("ALTMAN")
              ],
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

Widget buildIdentityBadges({
  required String travelType,
  required String age,
  required String country,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "🚐 $travelType",
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
        "🎂 ${age}yo 📍$country",
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

Widget buildEventCard(
  VoidCallback ontap,
  List<String> eventHosted,
  List<String> eventJoined,
  List<String> eventSaved,
) {
  List<String> allEvents =
      {...eventHosted, ...eventJoined, ...eventSaved}.toList();
  return InkWell(
    onTap: allEvents.isEmpty ? null : ontap,
    child:
        allEvents.isEmpty
            ? buildEmptyEventCard()
            : Container(
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

Widget buildEmptyEventCard() {
  return InkWell(
    onTap: () {},
    borderRadius: BorderRadius.circular(30.r),
    child: Container(
      height: 280.h,
      width: 200.w,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Deep aesthetic black/grey
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.white10, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Plus Icon Circle
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.black, size: 28.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            "CREATE NEW\nEVENT",
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoCondensed(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildVehicleCard({required List<String> vehileImage}) {
  return vehileImage.isEmpty
      ? buildEmptyVehicleCard()
      : ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: Image.asset(
          'assets/images/van.jpg',
          width: double.infinity,
          height: 220.h,
          fit: BoxFit.cover,
        ),
      );
}

Widget buildEmptyVehicleCard() {
  return InkWell(
    onTap: () {},
    borderRadius: BorderRadius.circular(25.r),
    child: Container(
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Match your dark theme
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Colors.white10, width: 2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.black, size: 28.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            "FLAUNT YOUR VAN",
            style: GoogleFonts.robotoCondensed(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          Text(
            "Add your vehicle photos",
            style: GoogleFonts.poppins(color: Colors.white38, fontSize: 12.sp),
          ),
        ],
      ),
    ),
  );
}
