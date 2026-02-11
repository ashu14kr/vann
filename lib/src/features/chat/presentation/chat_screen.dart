import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../share/providers/shared_providers.dart';
import '../../profile/presentation/provider/profile_provider.dart';
import 'provider/chat_provider.dart';
import 'widgets/chat_widgets.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                  Text(
                    'Requests(5)',
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),

            // 3. LARGE CHAT TILES
            Expanded(
              child: StreamBuilder(
                stream: ref.read(chatProvider.notifier).fetchChats(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error loading messages"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No messages yet"));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 40.h),
                      itemBuilder: (context, index) {
                        final chats = snapshot.data![index];
                        return buildLargeChatTile(
                          name: "Jinny Marshall",
                          message: chats.lastMessage,
                          asset: 'assets/images/event.jpg',
                          isEvent: false,
                          time: DateFormat('jm').format(chats.lastMessageTime),
                          ontap: () async {
                            await ref
                                .read(profileProvider.notifier)
                                .getChatUsers(ids: [...chats.participants]);
                            final user = ref
                                .read(profileProvider)
                                .chatUsers
                                .firstWhere(
                                  (u) =>
                                      u.uid !=
                                      ref
                                          .read(firebaseAuthProvider)
                                          .currentUser!
                                          .uid,
                                );
                            context.push('/chat-details', extra: user);
                          },
                        );
                      },
                    );
                  }
                },
              ),

              //  ListView(
              //   physics: const BouncingScrollPhysics(),
              //   padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 40.h),
              //   children: [
              //     buildLargeChatTile(
              //       name: "Sam Altman",
              //       message: "Hey how are you?",
              //       asset: 'assets/images/profile.png',
              //       isEvent: false,
              //       time: "Now",
              //       ontap: () {
              //         context.push('/chat-details');
              //       },
              //     ),
              //     buildLargeChatTile(
              //       name: "Sunset Camp",
              //       message: "Hi everyone! The vibes are set for Sunday.",
              //       asset: 'assets/images/event.jpg',
              //       isEvent: true,
              //       time: "12m",
              //       ontap: () {},
              //     ),
              //     buildLargeChatTile(
              //       name: "Ritvik Singh",
              //       message: "Can we check the location again?",
              //       asset: 'assets/images/profile.png',
              //       isEvent: false,
              //       time: "1h",
              //       ontap: () {},
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
