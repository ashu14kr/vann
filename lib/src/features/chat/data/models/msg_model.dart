class MessageModel {
  final String senderId;
  final String content;
  final DateTime timestamp;

  MessageModel({
    required this.senderId,
    required this.content,
    required this.timestamp,
  });
}
