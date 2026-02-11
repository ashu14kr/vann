import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import '../../../share/providers/shared_providers.dart';
import '../../profile/data/models/user_model.dart';
import '../data/models/msg_model.dart';
import 'provider/chat_provider.dart';
import 'widgets/chatDetails_Widgets.dart';

class DetailedChatScreen extends ConsumerStatefulWidget {
  final UserModel user;
  final bool isEvent;

  const DetailedChatScreen({
    super.key,
    required this.user,
    this.isEvent = true,
  });

  @override
  ConsumerState<DetailedChatScreen> createState() => _DetailedChatScreenState();
}

class _DetailedChatScreenState extends ConsumerState<DetailedChatScreen> {
  TextEditingController _messageController = TextEditingController();

  late String chatId;

  @override
  void initState() {
    super.initState();
    // Ensure the ID is always alphabetical so it matches the DB
    final myId = ref.read(firebaseAuthProvider).currentUser!.uid;
    final otherId = widget.user.uid;
    final List<String> ids = [myId, otherId]..sort();
    chatId = ids.join('_');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // 1. BIGGER FLOATING HEADER
          buildFloatingHeader(
            context,
            false,
            widget.user.profileImages.first,
            widget.user.displayName,
          ),

          // 2. CHAT TIMELINE (Bigger Fonts)
          Expanded(
            child: StreamBuilder(
              stream: ref.read(chatProvider.notifier).fetchMessages(chatId),
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
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 110.h),
                    //buildTimestamp("TODAY 12:15 AM"),
                    itemBuilder: (context, index) {
                      final message = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: buildStickerMessage(
                          message.content,
                          isMe:
                              message.senderId ==
                              ref.read(firebaseAuthProvider).currentUser!.uid,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),

          // 3. BOLDER INPUT TERMINAL
          buildInputTerminal(() async {
            if (_messageController.text.trim().isEmpty) return;
            final senderId = ref.read(firebaseAuthProvider).currentUser!.uid;
            await ref
                .read(chatProvider.notifier)
                .sendMessage(
                  MessageModel(
                    senderId: senderId,
                    content: _messageController.text,
                    timestamp: DateTime.now(),
                  ),
                  widget.user.uid,
                );
            HapticFeedback.selectionClick();
            _messageController.clear();
          }, _messageController),
        ],
      ),
    );
  }
}
