import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../profile/data/models/user_model.dart';
import '../../../profile/presentation/other_User_ProfileCard.dart';

Widget buildStickerVibeTags(List<String> vibeTags) {
  // A vibrant, sticker-style color palette
  final List<Color> palette = [
    const Color(0xFFD4E157), // Lime
    const Color(0xFF81C784), // Green
    const Color(0xFF00D1FF), // Blue
    const Color(0xFFFFB74D), // Orange
    const Color(0xFFBA68C8), // Purple
    const Color(0xFFF06292), // Pink
  ];

  final List<double> rotations = [-0.05, 0.04, -0.02, 0.03, -0.04];

  return Wrap(
    spacing: 12.w,
    runSpacing: 16.h,
    children:
        vibeTags.asMap().entries.map((entry) {
          int idx = entry.key;
          String tag = entry.value.toUpperCase();

          return Transform.rotate(
            angle:
                rotations[idx % rotations.length], // Cycles through rotations
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: palette[idx % palette.length], // Cycles through colors
                border: Border.all(color: Colors.white, width: 2.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(3.w, 3.h),
                    blurRadius: 0, // Keeps it "flat" and sticker-like
                  ),
                ],
              ),
              child: Text(
                tag,
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w900,
                  fontSize: 16.sp, // Scaled down slightly for "too big" fix
                  color: Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
  );
}

Widget buildParticipantsSection(
  BuildContext context, {
  required List<UserModel> users,
  required String hostId,
  required String currentUserId,
}) {
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

        // --- DYNAMIC LIST START ---
        if (users.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Center(
              child: Text(
                "No participants yet",
                style: GoogleFonts.poppins(color: Colors.white24),
              ),
            ),
          )
        else
          Column(
            children:
                users.asMap().entries.map((entry) {
                  int index = entry.key;
                  UserModel user = entry.value;
                  Color rankColor =
                      (index == 0)
                          ? const Color(0xFFFFE600)
                          : (index == 1)
                          ? const Color(0xFFFFA500)
                          : (index == 2)
                          ? const Color(0xFFA066FF)
                          : Colors.white24;

                  return participantItem(
                    "#${index + 1}",
                    user.displayName,
                    user.bio ?? "Member",
                    rankColor,
                    user.profileImages,
                    user.uid == hostId ? true : false,
                    user.uid == currentUserId
                        ? null
                        : () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.black54,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: OtherUserProfileCard(user: user),
                              );
                            },
                          );
                        },
                  );
                }).toList(),
          ),
      ],
    ),
  );
}

Widget participantItem(
  String rank,
  String name,
  String sub,
  Color rankColor,
  List<String> image,
  bool isHost,
  VoidCallback? ontap,
) {
  return Padding(
    padding: EdgeInsets.only(bottom: 25.h),
    child: InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(12.r),
      child: Row(
        children: [
          // 1. Rank Section (Fixed width ensures alignment)
          SizedBox(
            width: 55.w,
            child: Stack(
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
          ),

          SizedBox(width: 5.w),

          // 2. Avatar Section with Top-Right Crown
          Stack(
            clipBehavior: Clip.none, // Allows crown to hang outside the circle
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor:
                    isHost ? const Color(0xFFFFE600) : Colors.transparent,
                child: CircleAvatar(
                  radius: 26.r, // Smaller radius creates the gold border effect
                  backgroundImage:
                      image.isEmpty
                          ? const AssetImage('assets/images/male_avatar.png')
                          : NetworkImage(image.first) as ImageProvider,
                ),
              ),
              if (isHost)
                Positioned(
                  top: -12.h, // Pulls emoji up
                  right: -8.w, // Pulls emoji to the right
                  child: Transform.rotate(
                    angle: 0.25, // Tilts the crown slightly (approx 15 degrees)
                    child: Text(
                      '👑',
                      style: TextStyle(
                        fontSize: 22.sp,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(width: 15.w),

          // 3. Text Section (Wrapped in Expanded to fix overflow)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 17.sp,
                  ),
                ),
                Text(
                  sub,
                  maxLines: 1, // Strictly one line as requested
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    color: Colors.white38,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// --- HELPERS ---
Widget buildHostAvatar(List<String> hostImage) {
  return Container(
    padding: const EdgeInsets.all(3),
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
    child: CircleAvatar(
      radius: 23, // Bigger avatar
      backgroundImage:
          hostImage.isEmpty
              ? AssetImage('assets/images/male_avatar.png')
              : NetworkImage(hostImage.first),
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
