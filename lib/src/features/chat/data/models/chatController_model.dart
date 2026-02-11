import 'package:van_life/src/features/chat/data/models/chat_model.dart';

class ChatControllerModel {
  final List<ChatModel> chatModel;
  final ChatModel newChat;
  final bool isLoading;

  ChatControllerModel({
    required this.chatModel,
    required this.newChat,
    required this.isLoading,
  });
  factory ChatControllerModel.initial() {
    return ChatControllerModel(
      chatModel: [],
      newChat: ChatModel(
        id: '',
        type: '',
        status: '',
        participants: [],
        lastMessage: '',
        lastMessageTime: DateTime.now(),
        createdBy: '',
      ),
      isLoading: true,
    );
  }
  ChatControllerModel copyWith({
    List<ChatModel>? chatModel,
    ChatModel? newChat,
    bool? isLoading,
  }) {
    return ChatControllerModel(
      chatModel: chatModel ?? this.chatModel,
      newChat: newChat ?? this.newChat,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
