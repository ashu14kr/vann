import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:van_life/src/features/profile/presentation/provider/profile_provider.dart';

import 'provider/provider.dart';
import 'widgets/joinedEvent_Widgets.dart';

class JoinedEventDetailedBottomSheet extends ConsumerWidget {
  const JoinedEventDetailedBottomSheet({super.key, required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Standardized typography scale
    final infoStyle = GoogleFonts.poppins(
      fontSize: 13.sp, // Reduced from 16
      color: Colors.white70,
      fontWeight: FontWeight.w400,
    );

    final eventsData = ref.watch(eventController).myEvents;
    final event = eventsData.firstWhere((evnt) => evnt.eventId == eventId);
    final currentUser = ref.watch(profileProvider).userModel;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.6,
      expand: false,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
            ), // Slightly smaller radius
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 10.h),
                  buildGrabHandle(),
                  Expanded(
                    child: ListView(
                      controller: controller,
                      physics: const ClampingScrollPhysics(),
                      // Tighter padding
                      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 120.h),
                      children: [
                        SizedBox(height: 15.h), // Reduced spacing
                        buildTopNavigation(event.hostId == currentUser.uid),
                        SizedBox(height: 20.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.title,
                                    style: GoogleFonts.robotoCondensed(
                                      fontSize: 26.sp, // Reduced from 32
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: -0.5.w, // Less aggressive
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(event.locationText, style: infoStyle),
                                  SizedBox(height: 10.h),
                                  Text(
                                    ref
                                        .read(eventController.notifier)
                                        .getEventTimeLine(
                                          event.startDate,
                                          event.endDate,
                                        ),
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            buildHostAvatar(
                              event.hostId == currentUser.uid
                                  ? currentUser.profileImages
                                  : [],
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),
                        buildStickerVibeTags(event.vibeTags),

                        SizedBox(height: 30.h), // Reduced from 40
                        buildSectionHeader(
                          "About Event",
                          "Add Media",
                          event.hostId == currentUser.uid,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          event.description,
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            color: Colors.white.withOpacity(0.85),
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        buildHorizontalGallery(
                          images: event.galleryImages,
                          isHost: event.hostId == currentUser.uid,
                        ),

                        SizedBox(height: 30.h),
                        buildSectionHeader(
                          "Getting There",
                          "",
                          event.hostId == currentUser.uid,
                        ),
                        SizedBox(height: 12.h),
                        buildMapWithBlueGradient(
                          onTap: () {
                            ref
                                .read(eventController.notifier)
                                .openMap(
                                  event.geo.latitude,
                                  event.geo.longitude,
                                );
                          },
                        ),

                        SizedBox(height: 30.h),
                        buildSectionHeader(
                          "Participants",
                          "",
                          event.hostId == currentUser.uid,
                        ),
                        SizedBox(height: 12.h),
                        buildParticipantsSection(
                          context,
                          users: ref.watch(profileProvider).users,
                          hostId: event.hostId,
                          currentUserUid:
                              ref.watch(profileProvider).userModel.uid,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              buildBottomScrim(),
              Positioned(
                bottom: 25.h,
                left: 16.w,
                right: 16.w,
                child: buildChatButton(),
              ),
            ],
          ),
        );
      },
    );
  }
}
