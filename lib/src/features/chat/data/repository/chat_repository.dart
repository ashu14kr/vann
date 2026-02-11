import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:van_life/src/features/chat/data/models/chat_model.dart';
import 'package:van_life/src/features/chat/data/models/msg_model.dart';
import 'package:van_life/src/features/chat/domain/chat_interface.dart';

class ChatRepository implements ChatInterface {
  final FirebaseFirestore db;

  ChatRepository({required this.db});

  @override
  Stream<List<MessageModel>> fetchMessages(String id) {
    return db
        .collection('chats')
        .doc(id)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return MessageModel(
              senderId: data['senderId'] ?? '',
              content: data['message'] ?? '',
              timestamp:
                  data['timestamp'] != null
                      ? (data['timestamp'] as Timestamp).toDate()
                      : DateTime.now(),
            );
          }).toList();
        });
  }

  @override
  Future<void> sendMessage(MessageModel message, ChatModel chat) async {
    try {
      await db.collection('chats').doc(chat.id).set({
        'id': chat.id,
        'type': chat.type,
        'status': chat.status,
        'participants': chat.participants,
        'lastMessage': message.content,
        'lastMessageTime': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await db.collection('chats').doc(chat.id).collection('messages').add({
        'senderId': message.senderId,
        'message': message.content,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<ChatModel>> fetchChats(String myUid) {
    return db
        .collection('chats')
        .where('participants', arrayContains: myUid)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return ChatModel(
              id: data['id'] ?? '',
              type: data['type'] ?? 'direct',
              status: data['status'] ?? 'active',
              createdBy: data['createdBy'] ?? '',
              participants: List<String>.from(data['participants'] ?? []),
              lastMessage: data['lastMessage'] ?? '',
              lastMessageTime:
                  data['lastMessageTime'] != null
                      ? (data['lastMessageTime'] as Timestamp).toDate()
                      : DateTime.now(),
            );
          }).toList();
        });
  }
}
