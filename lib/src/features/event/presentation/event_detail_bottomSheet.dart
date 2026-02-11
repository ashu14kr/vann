import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:google_fonts/google_fonts.dart';
import 'package:van_life/src/features/event/data/models/event_model.dart';
import 'package:van_life/src/features/event/presentation/provider/provider.dart';

import '../../profile/presentation/provider/profile_provider.dart';
import 'widgets/eventDetail_widgets.dart';

class EventDetailBottomSheet extends ConsumerWidget {
  final EventModel eventModel;
  const EventDetailBottomSheet({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleStyle = GoogleFonts.robotoCondensed(
      fontSize: 28.sp, // Responsive sizing
      fontWeight: FontWeight.w900,
      color: Colors.white,
    );

    final infoStyle = GoogleFonts.poppins(
      fontSize: 15.sp, // Responsive sizing
      color: Colors.white70,
      fontWeight: FontWeight.w400,
    );

    // final currentUser = ref.watch(profileProvider).userModel;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
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
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 140.h),
                      children: [
                        // Header Stack: Title, Ribbon, and Stacked Avatars
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(eventModel.title, style: titleStyle),
                                SizedBox(height: 8.h),
                                Text(eventModel.locationText, style: infoStyle),
                                SizedBox(height: 12.h),
                                Text(
                                  ref
                                      .read(eventController.notifier)
                                      .getEventTimeLine(
                                        eventModel.startDate,
                                        eventModel.endDate,
                                      ),
                                  style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(
                                      194,
                                      255,
                                      255,
                                      255,
                                    ),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            // Red Ribbon (Exact placement)
                            // Positioned(
                            //   top: -15.h,
                            //   right: -5.w,
                            //   child: Icon(
                            //     Icons.bookmark,
                            //     color: const Color(0xFFD32F2F),
                            //     size: 65.sp,
                            //   ),
                            // ),
                            // Stacked Avatars (Aligned with info text)
                            // Positioned(
                            //   bottom: 0,
                            //   right: 0,
                            //   child: buildHostAvatar(
                            //     eventModel.hostId == currentUser.uid
                            //         ? currentUser.profileImages
                            //         : [],
                            //   ),
                            // ),
                          ],
                        ),

                        SizedBox(height: 20.h),
                        buildStickerVibeTags(eventModel.vibeTags),

                        SizedBox(height: 40.h),
                        buildSectionHeader("About event"),
                        SizedBox(height: 5.h),
                        Text(
                          eventModel.description,
                          style: infoStyle.copyWith(height: 1.6),
                        ),
                        SizedBox(height: 20.h),
                        buildParticipantsSection(
                          context,
                          users: ref.watch(profileProvider).users,
                          hostId: eventModel.hostId,
                          currentUserId:
                              ref.watch(profileProvider).userModel.uid,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Sticky footer
              buildBottomScrim(),
              eventModel.attendeeIds.contains(
                    ref.watch(profileProvider).userModel.uid,
                  )
                  ? Container()
                  : Positioned(
                    bottom: 60.h,
                    right: 20.w,
                    child: buildJoinButton(),
                  ),
            ],
          ),
        );
      },
    );
  }
}
