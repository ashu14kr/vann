import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'widgets/chatDetails_Widgets.dart';

class DetailedChatScreen extends StatelessWidget {
  final String name;
  final String asset;
  final bool isEvent;

  const DetailedChatScreen({
    super.key,
    this.name = "SUNSET CHAMP",
    this.asset = 'assets/images/event.jpg',
    this.isEvent = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // 1. BIGGER FLOATING HEADER
          buildFloatingHeader(context, isEvent, asset, name),

          // 2. CHAT TIMELINE (Bigger Fonts)
          Expanded(
            child: ListView(
              reverse: true,
              // Applied .w and .h to padding for consistent spacing
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 110.h),
              children: [
                buildStickerMessage("Night guys, see ya!", isMe: true),
                buildMessageWithAvatar(
                  "Night, sam! Don't forget the gear.",
                  asset: 'assets/images/profile.png',
                ),
                buildTimestamp("TODAY 12:15 AM"),
              ],
            ),
          ),

          // 3. BOLDER INPUT TERMINAL
          buildInputTerminal(),
        ],
      ),
    );
  }
}
