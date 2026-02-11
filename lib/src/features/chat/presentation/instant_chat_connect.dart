import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:van_life/src/features/chat/data/models/msg_model.dart';
import 'package:van_life/src/features/chat/presentation/provider/chat_provider.dart';
import 'package:van_life/src/features/profile/data/models/user_model.dart';
import 'package:van_life/src/share/providers/shared_providers.dart';
// Importing your existing widgets
import 'widgets/chatDetails_Widgets.dart';

class InstantConnectSheet extends ConsumerStatefulWidget {
  final UserModel stranger;

  const InstantConnectSheet({super.key, required this.stranger});

  @override
  ConsumerState<InstantConnectSheet> createState() =>
      _InstantConnectSheetState();
}

class _InstantConnectSheetState extends ConsumerState<InstantConnectSheet> {
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return DraggableScrollableSheet(
      initialChildSize: 0.85, // Matches your OtherUserProfileCard
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black, // Matches your Scaffold color
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
          ),
          child: Column(
            children: [
              // 1. YOUR HEADER STYLE (Simplified for the sheet)
              _buildSheetHeader(widget.stranger),

              // 2. THE CHAT TIMELINE (Using your buildStickerMessage)
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
                  children: [
                    buildTimestamp("START A CONNECTION"),
                    SizedBox(height: 20.h),
                    // Example sticker to show the "vibe"
                    // buildStickerMessage(
                    //   "Hey ${stranger.displayName}! Let's connect!",
                    //   isMe: true,
                    // ),
                    SizedBox(height: 10.h),
                    Text(
                      "Tap below to send your first message...",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white24, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),

              // 3. YOUR BOLDER INPUT TERMINAL
              // This is the specific widget from your DetailedChatScreen logic
              buildInputTerminal(() async {
                final senderId =
                    ref.read(firebaseAuthProvider).currentUser!.uid;
                await ref
                    .read(chatProvider.notifier)
                    .sendMessage(
                      MessageModel(
                        senderId: senderId,
                        content: _messageController.text,
                        timestamp: DateTime.now(),
                      ),
                      widget.stranger.uid,
                    );
              }, _messageController),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSheetHeader(UserModel user) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        // Your existing grab handle logic
        Container(
          width: 40.w,
          height: 4.h,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 25.w),
          leading: CircleAvatar(
            radius: 20.r,
            backgroundImage: NetworkImage(user.profileImages.first),
          ),
          title: Text(
            user.displayName.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900, // Bolder as per your style
              letterSpacing: 1.2,
              fontSize: 18.sp,
            ),
          ),
          subtitle: Text(
            "WANT TO CONNECT?",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(color: Colors.white10, height: 1.h),
      ],
    );
  }
}
