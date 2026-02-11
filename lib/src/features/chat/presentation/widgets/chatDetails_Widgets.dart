import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:google_fonts/google_fonts.dart';

Widget buildFloatingHeader(
  BuildContext context,
  bool isEvent,
  String asset,
  String name,
) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 30.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(25.r),
                border: Border.all(color: Colors.white12, width: 1.5.w),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.5.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors:
                            isEvent
                                ? [
                                  const Color(0xFF0047FF),
                                  const Color(0xFF00D1FF),
                                ]
                                : [
                                  const Color(0xFFF2BC56),
                                  const Color(0xFFF9E364),
                                ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 24.r,
                      backgroundImage: NetworkImage(asset),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Text(
                    name.toUpperCase(),
                    style: GoogleFonts.robotoCondensed(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 26.sp,
                      letterSpacing: -0.5.w,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// --- POPPINS LIGHT MESSAGES ---
Widget buildMessageWithAvatar(String text, {required String asset}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 30.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(radius: 22.r, backgroundImage: AssetImage(asset)),
        SizedBox(width: 12.w),
        buildStickerMessage(text, isMe: false),
      ],
    ),
  );
}

Widget buildStickerMessage(String text, {required bool isMe}) {
  return Align(
    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      constraints: BoxConstraints(maxWidth: 280.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFFF9E364) : const Color(0xFF262626),
        border: isMe ? Border.all(color: Colors.white, width: 2.5.w) : null,
        boxShadow:
            isMe
                ? [BoxShadow(color: Colors.black, offset: Offset(4.w, 4.h))]
                : null,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
          bottomLeft: Radius.circular(isMe ? 20.r : 4.r),
          bottomRight: Radius.circular(isMe ? 4.r : 20.r),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: isMe ? Colors.black : Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 19.sp,
          height: 1.2,
        ),
      ),
    ),
  );
}

Widget buildTimestamp(String time) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 40.h),
    child: Center(
      child: Text(
        time.toUpperCase(),
        style: GoogleFonts.robotoCondensed(
          color: Colors.white30,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

// --- BIGGER INPUT TERMINAL ---
Widget buildInputTerminal(
  VoidCallback onSend,
  TextEditingController controller,
) {
  return InkWell(
    onTap: onSend,
    child: Container(
      padding: EdgeInsets.fromLTRB(20.w, 15.h, 20.w, 35.h),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border(top: BorderSide(color: Colors.white10, width: 1.5.w)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              height: 60.h,
              decoration: BoxDecoration(
                color: const Color(0xFF111111),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: Colors.white24, width: 1.5.w),
              ),
              child: Center(
                child: TextField(
                  controller: controller,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: "TYPE SOMETHING...",
                    hintStyle: GoogleFonts.robotoCondensed(
                      color: Colors.white24,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: const Color(0xFF0047FF),
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: Colors.white, width: 2.5.w),
            ),
            child: Icon(Icons.send_rounded, color: Colors.white, size: 28.sp),
          ),
        ],
      ),
    ),
  );
}
