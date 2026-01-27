import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:google_fonts/google_fonts.dart';

import 'widgets/eventDetail_widgets.dart';

class EventDetailBottomSheet extends StatelessWidget {
  const EventDetailBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // High-impact font sizes matching the Joined version
    final titleStyle = GoogleFonts.robotoCondensed(
      fontSize: 32.sp, // Responsive sizing
      fontWeight: FontWeight.w900,
      color: Colors.white,
      letterSpacing: -2.w,
    );

    final infoStyle = GoogleFonts.poppins(
      fontSize: 16.sp, // Responsive sizing
      color: Colors.white70,
      fontWeight: FontWeight.w400,
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.6,
      expand: false,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 12.h),
                  buildGrabHandle(),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: ListView(
                      controller: controller,
                      physics: const ClampingScrollPhysics(),
                      // Adjusted padding for bottom clearance
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 140.h),
                      children: [
                        // Header Stack: Title, Ribbon, and Stacked Avatars
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("SUNSET CAMP", style: titleStyle),
                                SizedBox(height: 8.h),
                                Text(
                                  "Hedgewar Road City of\nLondon London EC1A 1BB",
                                  style: infoStyle,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  "Sun, 2 Feb 2026  12:00 – 18:00 PM",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            // Red Ribbon (Exact placement)
                            Positioned(
                              top: -15.h,
                              right: -5.w,
                              child: Icon(
                                Icons.bookmark,
                                color: const Color(0xFFD32F2F),
                                size: 65.sp,
                              ),
                            ),
                            // Stacked Avatars (Aligned with info text)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: buildStackedHostAvatars(),
                            ),
                          ],
                        ),

                        SizedBox(height: 30.h),
                        // VIBE CARDS: Same sticker style as Joined/Profile
                        buildStickerVibeTags(),

                        SizedBox(height: 40.h),
                        buildSectionHeader("About event"),
                        SizedBox(height: 10.h),
                        Text(
                          "This isn't a group meetup. This is one human, one human, one evening. Sunset Camp is a quiet, unscripted hang for two van-lifers who feel drawn to the same place at the same time. No itinerary.",
                          style: infoStyle.copyWith(height: 1.6),
                        ),

                        SizedBox(height: 40.h),
                        buildParticipantsSection(context),
                      ],
                    ),
                  ),
                ],
              ),

              // Sticky footer
              buildBottomScrim(),
              Positioned(bottom: 30.h, right: 20.w, child: buildJoinButton()),
            ],
          ),
        );
      },
    );
  }
}
