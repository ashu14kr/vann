import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String id;
  String type;
  String status;
  String createdBy;
  List<String> participants;
  String lastMessage;
  DateTime lastMessageTime;

  ChatModel({
    required this.id,
    required this.type,
    required this.status,
    required this.createdBy,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
  });

  ChatModel copyWith({
    String? id,
    String? type,
    String? status,
    String? createdBy,
    List<String>? participants,
    String? lastMessage,
    DateTime? lastMessageTime,
  }) {
    return ChatModel(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      createdBy: createdBy ?? this.createdBy,
      participants: participants ?? this.participants,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }

  ChatModel.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      type = map['type'],
      status = map['status'],
      createdBy = map['createdBy'],
      participants = List<String>.from(map['participants']),
      lastMessage = map['lastMessage'],
      lastMessageTime = (map['lastMessageTime'] as Timestamp).toDate();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'status': status,
      'createdBy': createdBy,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
    };
  }
}
