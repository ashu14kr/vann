import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../profile/presentation/other_User_ProfileCard.dart';

Widget buildStickerVibeTags() {
  final List<Map<String, dynamic>> tags = [
    {'text': 'CALM', 'color': const Color(0xFFD4E157), 'rot': -0.05},
    {'text': 'SOCIAL', 'color': const Color(0xFF81C784), 'rot': 0.04},
    {'text': 'NIGHT', 'color': const Color(0xFF00D1FF), 'rot': -0.03},
  ];

  return Wrap(
    spacing: 12.w,
    runSpacing: 18.h,
    children:
        tags
            .map(
              (tag) => Transform.rotate(
                angle: tag['rot'],
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: tag['color'],
                    border: Border.all(
                      color: Colors.white,
                      width: 2.5.w,
                    ), // Thick white border
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(4.w, 4.h),
                      ),
                    ],
                  ),
                  child: Text(
                    tag['text'],
                    style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
  );
}

// --- REFINED PARTICIPANTS ---
Widget buildParticipantsSection(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(24.r),
    decoration: BoxDecoration(
      color: const Color(0xFF111111),
      borderRadius: BorderRadius.circular(35.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top Participants",
          style: GoogleFonts.robotoCondensed(
            color: Colors.white,
            fontSize: 27.sp,
            letterSpacing: -1.w,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          "Who have already joined",
          style: GoogleFonts.poppins(color: Colors.white30, fontSize: 13.sp),
        ),
        SizedBox(height: 20.h),
        participantItem(
          "#1",
          "Sam Altman",
          "Founder of disciplue",
          const Color(0xFFFFE600),
          () {
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
                  child: const OtherUserProfileCard(
                    otherUserName: 'Sam Altman',
                  ),
                );
              },
            );
          },
        ),
        participantItem(
          "#2",
          "Ritvik Singh",
          "Wipro",
          const Color(0xFFFFA500),
          () {},
        ),
        participantItem(
          "#3",
          "Ravi Sastri",
          "Golfer at MCG",
          const Color(0xFFA066FF),
          () {},
        ),
        participantItem("#4", "RDJ", "Event Planner", Colors.white24, () {}),
      ],
    ),
  );
}

Widget participantItem(
  String rank,
  String name,
  String sub,
  Color rankColor,
  VoidCallback? ontap,
) {
  return Padding(
    padding: EdgeInsets.only(bottom: 25.h),
    child: InkWell(
      onTap: ontap,
      child: Row(
        children: [
          Stack(
            children: [
              Text(
                rank,
                style: GoogleFonts.robotoCondensed(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w900,
                  foreground:
                      Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6.w
                        ..color = Colors.white,
                ),
              ),
              Text(
                rank,
                style: GoogleFonts.robotoCondensed(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w900,
                  color: rankColor,
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          CircleAvatar(
            radius: 28.r,
            backgroundImage: const AssetImage('assets/images/profile.png'),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 17.sp,
                ),
              ),
              Text(
                sub,
                style: GoogleFonts.poppins(
                  color: Colors.white38,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// --- HELPERS ---
Widget buildStackedHostAvatars() {
  return SizedBox(
    width: 110.w,
    height: 45.h,
    child: Stack(
      children: List.generate(3, (index) {
        return Positioned(
          right: index * 28.0.w,
          child: Container(
            padding: EdgeInsets.all(2.r),
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 20.r,
              backgroundImage: const AssetImage('assets/images/profile.png'),
            ),
          ),
        );
      }),
    ),
  );
}

Widget buildSectionHeader(String title) => Text(
  title,
  style: GoogleFonts.robotoCondensed(
    color: Colors.white,
    fontSize: 27.sp,
    fontWeight: FontWeight.w900,
    letterSpacing: -1.w,
  ),
);

Widget buildJoinButton() => Container(
  padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 18.h),
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFFF2BC56), Color(0xFFF9E364)],
    ),
    borderRadius: BorderRadius.circular(35.r),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        blurRadius: 20.r,
        offset: Offset(0, 10.h),
      ),
    ],
  ),
  child: Text(
    'JOIN',
    style: GoogleFonts.robotoCondensed(
      color: Colors.black,
      fontWeight: FontWeight.w900,
      fontSize: 24.sp,
    ),
  ),
);

Widget buildGrabHandle() => Center(
  child: Container(
    width: 55.w,
    height: 8.h,
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(10.r),
    ),
  ),
);

Widget buildBottomScrim() => Positioned(
  bottom: 0,
  left: 0,
  right: 0,
  height: 160.h,
  child: IgnorePointer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0),
            Colors.black.withOpacity(0.8),
            Colors.black,
          ],
        ),
      ),
    ),
  ),
);
