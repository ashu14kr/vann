import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import

import '../../event/presentation/joined_event_detailed_bottomSheet.dart';
import 'widgets/profile_general_widget.dart';

class ProfileBottomCard extends StatelessWidget {
  const ProfileBottomCard({super.key});

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
          child: Column(
            children: [
              // --- STATIC TOP PART (Doesn't scroll) ---
              SizedBox(height: 12.h),
              Center(
                child: Container(
                  width: 55.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(194, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              // --- SCROLLABLE CONTENT ---
              Expanded(
                child: ListView(
                  controller: controller,
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  children: [
                    SizedBox(height: 10.h),
                    buildTopActions(),
                    buildAvatarWithName(),
                    buildIdentityBadges(),
                    SizedBox(height: 30.h),
                    buildSectionHeader("Events"),
                    SizedBox(height: 15.h),
                    buildCategoryTabs(),
                    SizedBox(height: 20.h),
                    buildEventCard(() {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.black54,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: const JoinedEventDetailedBottomSheet(),
                          );
                        },
                      );
                    }),
                    SizedBox(height: 30.h),
                    buildSectionHeader("My Baby", hasViewAll: true),
                    SizedBox(height: 15.h),
                    buildVehicleCard(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
