import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import

import 'widgets/others_user_general_widgets.dart';

class OtherUserProfileCard extends StatelessWidget {
  final String otherUserName;

  const OtherUserProfileCard({super.key, required this.otherUserName});

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
                        buildTopActions(),
                        buildAvatarWithDynamicName(otherUserName),
                        buildIdentityBadges(),
                        SizedBox(height: 25.h),
                        buildPlacesBanner(),
                        SizedBox(height: 30.h),
                        buildSectionHeader("Events"),
                        SizedBox(height: 15.h),
                        buildEventCard(),
                        SizedBox(height: 30.h),
                        buildSectionHeader("My Interests"),
                        SizedBox(height: 15.h),
                        buildInterestsWrap(),
                        SizedBox(height: 30.h),
                        buildSectionHeader("My Baby"),
                        SizedBox(height: 15.h),
                        buildVehicleCard(),
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
                child: buildConnectButton(),
              ),
            ],
          ),
        );
      },
    );
  }
}
