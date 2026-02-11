import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/features/chat/data/models/chatController_model.dart';
import 'package:van_life/src/features/chat/data/models/msg_model.dart';
import 'package:van_life/src/features/chat/presentation/provider/chat_provider.dart';
import 'package:van_life/src/features/profile/presentation/provider/profile_provider.dart';
import 'package:van_life/src/share/providers/shared_providers.dart';

import '../data/models/chat_model.dart';

class ChatController extends Notifier<ChatControllerModel> {
  @override
  ChatControllerModel build() {
    return ChatControllerModel.initial();
  }

  Stream<List<MessageModel>> fetchMessages(String chatId) {
    try {
      final chatRep = ref.read(chatRepos);
      return chatRep.fetchMessages(chatId);
    } catch (e) {
      print(e);
      throw Exception("Failed to fetch messages: $e");
    }
  }

  Stream<List<ChatModel>> fetchChats() {
    try {
      final chatRep = ref.read(chatRepos);
      final myUid = ref.read(firebaseAuthProvider).currentUser!.uid;
      return chatRep.fetchChats(myUid);
    } catch (e) {
      print(e);
      throw Exception("Failed to fetch messages: $e");
    }
  }

  Future<void> sendMessage(MessageModel message, String receiverId) async {
    final List<String> ids = [message.senderId, receiverId]..sort();
    final String chatId = ids.join('_');

    final updatedChat = state.newChat.copyWith(
      id: chatId,
      participants: ids,
      lastMessage: message.content,
      lastMessageTime: message.timestamp,
    );

    final chatRep = ref.read(chatRepos);

    try {
      await chatRep.sendMessage(message, updatedChat);
      state = state.copyWith(newChat: updatedChat);
    } catch (e) {
      print("Failed to send: $e");
    }
  }
}
