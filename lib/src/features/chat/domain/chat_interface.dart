import 'package:van_life/src/features/chat/data/models/chat_model.dart';

import '../data/models/msg_model.dart';

abstract class ChatInterface {
  Future<void> sendMessage(MessageModel message, ChatModel chat);
  Stream<List<MessageModel>> fetchMessages(String id);
  Stream<List<ChatModel>> fetchChats(String myUid);
}
