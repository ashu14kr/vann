import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/share/providers/shared_providers.dart';

import '../../data/models/chatController_model.dart';
import '../../data/repository/chat_repository.dart';
import '../chat_controller.dart';

final chatProvider = NotifierProvider<ChatController, ChatControllerModel>(() {
  return ChatController();
});

final chatRepos = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return ChatRepository(db: firestore);
});
