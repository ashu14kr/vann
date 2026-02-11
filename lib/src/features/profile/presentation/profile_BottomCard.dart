import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:van_life/src/features/event/presentation/provider/provider.dart';
import 'package:van_life/src/features/profile/presentation/edit_profile.dart';
import 'package:van_life/src/features/profile/presentation/provider/profile_provider.dart';
import 'package:van_life/src/features/setting/presentation/setting_bottomSheet.dart';

import '../../event/presentation/joined_event_detailed_bottomSheet.dart';
import 'widgets/profile_general_widget.dart';

class ProfileBottomCard extends ConsumerStatefulWidget {
  const ProfileBottomCard({super.key});

  @override
  ConsumerState<ProfileBottomCard> createState() => _ProfileBottomCardState();
}

class _ProfileBottomCardState extends ConsumerState<ProfileBottomCard> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileProvider);
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
              user.isLoading
                  ? Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                  : Expanded(
                    child: ListView(
                      controller: controller,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      children: [
                        SizedBox(height: 10.h),
                        buildTopActions(
                          edit: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              barrierColor: Colors.black54,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                  ),
                                  child: const EditProfileBottomSheet(),
                                );
                              },
                            );
                          },
                          settings: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              barrierColor: Colors.black54,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                  ),
                                  child: const SettingsBottomSheet(),
                                );
                              },
                            );
                          },
                        ),
                        buildAvatarWithName(
                          image: user.userModel.profileImages,
                          name: user.userModel.displayName,
                        ),
                        buildIdentityBadges(
                          travelType: user.userModel.travelType,
                          age: user.userModel.age,
                          country: user.userModel.currentCountry,
                        ),
                        SizedBox(height: 30.h),
                        buildSectionHeader("Events"),
                        SizedBox(height: 15.h),
                        // buildCategoryTabs(),
                        // SizedBox(height: 20.h),
                        buildEventCard(
                          (eventId) {
                            final eventsData =
                                ref.read(eventController).myEvents;
                            final event = eventsData.firstWhere(
                              (evnt) => evnt.eventId == eventId,
                            );
                            ref
                                .read(profileProvider.notifier)
                                .getUsers(ids: event.attendeeIds);
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              barrierColor: Colors.black54,
                              builder: (context) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                  ),
                                  child: JoinedEventDetailedBottomSheet(
                                    eventId: eventId,
                                  ),
                                );
                              },
                            );
                          },
                          user.userModel.eventsHosted,
                          user.userModel.eventsJoined,
                          user.userModel.eventsSaved,
                          context,
                        ),
                        SizedBox(height: 30.h),
                        buildSectionHeader(
                          "My Baby",
                          hasViewAll:
                              user.userModel.vehicleImages.isEmpty
                                  ? false
                                  : true,
                        ),
                        SizedBox(height: 15.h),
                        buildVehicleCard(
                          vehileImage: user.userModel.vehicleImages,
                        ),
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
