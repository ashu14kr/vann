import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/chat_widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive Typography
    final titleStyle = GoogleFonts.robotoCondensed(
      fontSize: 48.sp,
      fontWeight: FontWeight.w900,
      fontStyle: FontStyle.italic,
      color: Colors.white,
      letterSpacing: -2.w,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 30.h, 25.w, 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CHATS", style: titleStyle),
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: Icon(Icons.close, color: Colors.white, size: 30),
                  ),
                ],
              ),
            ),

            // 2. STICKER BOXES (Rotated & Bold)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: Row(
                children: [
                  stickerChip(
                    "Direct",
                    const Color(0xFFD4E157),
                    rot: -0.04,
                    isSelected: true,
                  ),
                  SizedBox(width: 15.w),
                  stickerChip("Events", const Color(0xFF81C784), rot: 0.03),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // 3. LARGE CHAT TILES
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 40.h),
                children: [
                  buildLargeChatTile(
                    name: "Sam Altman",
                    message: "Hey how are you?",
                    asset: 'assets/images/profile.png',
                    isEvent: false,
                    time: "Now",
                    ontap: () {
                      context.push('/chat-details');
                    },
                  ),
                  buildLargeChatTile(
                    name: "Sunset Camp",
                    message: "Hi everyone! The vibes are set for Sunday.",
                    asset: 'assets/images/event.jpg',
                    isEvent: true,
                    time: "12m",
                    ontap: () {},
                  ),
                  buildLargeChatTile(
                    name: "Ritvik Singh",
                    message: "Can we check the location again?",
                    asset: 'assets/images/profile.png',
                    isEvent: false,
                    time: "1h",
                    ontap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
