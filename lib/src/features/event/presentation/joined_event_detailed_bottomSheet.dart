import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:google_fonts/google_fonts.dart';

import 'widgets/joinedEvent_Widgets.dart';

class JoinedEventDetailedBottomSheet extends StatelessWidget {
  const JoinedEventDetailedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaled up typography using .sp
    final infoStyle = GoogleFonts.poppins(
      fontSize: 16.sp,
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
                  Expanded(
                    child: ListView(
                      controller: controller,
                      physics: const ClampingScrollPhysics(),
                      // Adjusted padding for bottom clearance
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 140.h),
                      children: [
                        SizedBox(height: 25.h),
                        buildTopNavigation(),
                        SizedBox(height: 25.h),

                        // Refined Header: Host avatar aligned to top
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SUNSET CAMP",
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: -2.w,
                                    ),
                                  ),
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
                            ),
                            SizedBox(width: 15.w),
                            buildHostAvatar(),
                          ],
                        ),

                        SizedBox(height: 25.h),
                        buildStickerVibeTags(),

                        SizedBox(height: 40.h),
                        buildSectionHeader(
                          "About Event",
                          "Add Media  |  Edit Text",
                        ),
                        SizedBox(height: 15.h),
                        buildHorizontalGallery(),

                        SizedBox(height: 40.h),
                        buildSectionHeader("Getting There", ""),
                        SizedBox(height: 15.h),
                        buildMapWithBlueGradient(),

                        SizedBox(height: 40.h),
                        buildSectionHeader("Participants", ""),
                        SizedBox(height: 15.h),
                        buildParticipantsList(),
                      ],
                    ),
                  ),
                ],
              ),

              // Sticky footer elements
              buildBottomScrim(),
              Positioned(
                bottom: 30.h,
                left: 20.w,
                right: 20.w,
                child: buildChatButton(),
              ),
            ],
          ),
        );
      },
    );
  }
}
