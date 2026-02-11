import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/features/event/data/models/event_controller_model.dart';
import 'package:van_life/src/features/event/presentation/event_controller.dart';
import 'package:van_life/src/share/providers/shared_providers.dart';

import '../../data/repository/event_repository.dart';

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  final db = ref.read(firestoreProvider);
  final auth = ref.read(firebaseAuthProvider);
  return EventRepository(db: db, auth: auth);
});

final eventController = NotifierProvider<EventController, EventControllerModel>(
  () {
    return EventController();
  },
);
