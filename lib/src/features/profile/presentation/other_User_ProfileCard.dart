import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:go_router/go_router.dart';
import 'package:van_life/src/features/profile/data/models/user_model.dart';

import 'widgets/others_user_general_widgets.dart';

class OtherUserProfileCard extends StatelessWidget {
  final UserModel user;

  const OtherUserProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
          ),
          child: Stack(
            children: [
              // 1. SCROLLABLE CONTENT
              Column(
                children: [
                  SizedBox(height: 12.h),
                  buildGrabHandle(),
                  Expanded(
                    child: ListView(
                      controller: controller,
                      physics: const ClampingScrollPhysics(),
                      // Large bottom padding (120) so content clears the Connect button
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 120.h),
                      children: [
                        // buildTopActions(),
                        SizedBox(height: 12.h),
                        buildAvatarWithDynamicName(
                          user.displayName,
                          user.profileImages,
                        ),
                        buildIdentityBadges(
                          user.travelType,
                          user.age,
                          user.currentCountry,
                        ),
                        SizedBox(height: 25.h),
                        buildPlacesBanner(user.visitedScratchMap.length),
                        SizedBox(height: 30.h),
                        buildSectionHeader(
                          "Events",
                          [...user.eventsHosted, ...user.eventsJoined].length >
                              2,
                        ),
                        SizedBox(height: 15.h),
                        buildEventCard(
                          (eventId) {},
                          user.eventsHosted,
                          user.eventsJoined,
                          user.eventsSaved,
                          context,
                        ),
                        SizedBox(height: 30.h),
                        buildSectionHeader("My Interests", false),
                        SizedBox(height: 15.h),
                        buildInterestsWrap(user.interests),
                        SizedBox(height: 30.h),
                        buildSectionHeader(
                          "My Baby",
                          user.vehicleImages.length > 1,
                        ),
                        SizedBox(height: 15.h),
                        buildVehicleCard(vehileImage: user.vehicleImages),
                      ],
                    ),
                  ),
                ],
              ),

              // 2. BOTTOM SHADOW SCRIM
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 150.h, // Scaled height for the shadow area
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.0),
                          Colors.black.withOpacity(0.7),
                          Colors.black,
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
              ),

              // 3. FIXED CONNECT BUTTON
              Positioned(
                bottom: 30.h,
                left: 20.w,
                right: 20.w,
                child: buildConnectButton(() {
                  context.push('/chat-details', extra: user);
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
