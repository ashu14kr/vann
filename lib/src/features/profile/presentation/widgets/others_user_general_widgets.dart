import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../event/presentation/provider/provider.dart';
import 'dash_painter.dart';
import 'profile_general_widget.dart';

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

Widget buildAvatarWithDynamicName(String fullName, List<String> image) {
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
              backgroundImage:
                  image.isEmpty
                      ? AssetImage('assets/images/male_avatar.png')
                      : NetworkImage(image.first),
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

Widget buildIdentityBadges(String travelType, String age, String location) {
  return Column(
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
          Icon(Icons.verified, color: Colors.blueAccent, size: 28.sp),
        ],
      ),
      SizedBox(height: 4.h),
      Text(
        "🎂 $age  📍 $location",
        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16.sp),
      ),
    ],
  );
}

Widget buildPlacesBanner(int totalPlaces) {
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
                buildPlacesStrokedText(totalPlaces.toString()),
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

Widget buildSectionHeader(String title, bool isViewAll) {
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
      if (title == "My Baby" && isViewAll)
        Text(
          "View All",
          style: TextStyle(color: Colors.white54, fontSize: 14.sp),
        ),
    ],
  );
}

Widget buildEventCard(
  Function(String eventId) ontap,
  List<String> eventHosted,
  List<String> eventJoined,
  List<String> eventSaved,
  BuildContext context,
) {
  final List<String> allEvents =
      {...eventHosted, ...eventJoined, ...eventSaved}.toList();

  return SizedBox(
    height: 280.h,
    width: double.infinity,
    child: Consumer(
      builder: (context, ref, child) {
        if (allEvents.isEmpty) return buildEmptyEventCard();

        final eventsData = ref.watch(eventController).events;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(right: 20.w),
          physics: const BouncingScrollPhysics(),
          itemCount: allEvents.length,
          itemBuilder: (context, index) {
            final String eventId = allEvents[index];
            final evnt = eventsData.firstWhere(
              (element) => element.eventId == eventId,
              orElse: () => eventsData.first,
            );

            return Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: InkWell(
                onTap: () => ontap(eventId),
                borderRadius: BorderRadius.circular(30.r),
                child: Container(
                  height: 280.h,
                  width: 200.w,
                  // This ensures the content stays at the bottom
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    image: DecorationImage(
                      image: NetworkImage(evnt.coverImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    // FIX: Constrain the height of the black info section
                    width: 200.w,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      // Keep the bottom corners rounded to match the parent
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30.r),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.6], // Makes the transition sharper
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.85),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Shrinks to fit the text
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          evnt.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          DateFormat(
                            'EEE, MMM d • h:mm a',
                          ).format(evnt.startDate),
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

Widget buildInterestsWrap(List<String> interests) {
  // Predefined lists for a variety of "sticker" looks
  final List<Color> stickerColors = [
    Colors.yellow,
    const Color(0xFFA066FF), // Purple
    const Color(0xFF00FF75), // Green
    Colors.white,
    const Color(0xFF00D1FF), // Blue
    const Color(0xFFFF5C00), // Orange
  ];

  final List<double> rotations = [-0.05, 0.04, -0.03, 0.05, -0.02, 0.03];

  return Wrap(
    spacing: 12.w,
    runSpacing: 18.h,
    children:
        interests.asMap().entries.map((entry) {
          int index = entry.key;
          String text = entry.value;

          // Use modulo (%) to cycle through colors and rotations regardless of list length
          Color color = stickerColors[index % stickerColors.length];
          double angle = rotations[index % rotations.length];

          return Transform.rotate(
            angle: angle,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: color,
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
                text.toUpperCase(), // Keeping the "Sticker" aesthetic
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w900,
                  fontSize: 16.sp,
                  letterSpacing: -0.5.w,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
  );
}

Widget buildVehicleCard({required List<String> vehileImage}) {
  return vehileImage.isEmpty
      ? buildEmptyVehicleCard()
      : ClipRRect(
        borderRadius: BorderRadius.circular(25.r),
        child: Image.network(
          vehileImage.first,
          width: double.infinity,
          height: 220.h,
          fit: BoxFit.cover,
        ),
      );
}

Widget buildEmptyVehicleCard() {
  return Container(
    width: double.infinity,
    height: 220.h,
    decoration: BoxDecoration(
      color: const Color(0xFF161616), // Slightly darker to look "passive"
      borderRadius: BorderRadius.circular(25.r),
      border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.5),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Using a bus/van icon to signal what is missing
        Icon(
          Icons.directions_bus_filled_outlined,
          color: Colors.white10,
          size: 45.sp,
        ),
        SizedBox(height: 16.h),
        Text(
          "NO VEHICLE ADDED",
          style: GoogleFonts.robotoCondensed(
            color: Colors.white24, // Faded because it's an empty state
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "This user hasn't shared their van yet",
          style: GoogleFonts.poppins(color: Colors.white12, fontSize: 12.sp),
        ),
      ],
    ),
  );
}

Widget buildConnectButton(VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
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
    ),
  );
}
