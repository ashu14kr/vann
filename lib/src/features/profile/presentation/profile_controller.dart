import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/features/profile/data/models/profileController_model.dart';
import 'package:van_life/src/features/profile/presentation/provider/profile_provider.dart';
import 'package:van_life/src/share/providers/shared_providers.dart';

class ProfileController extends Notifier<ProfilecontrollerModel> {
  @override
  ProfilecontrollerModel build() {
    Future.microtask(() => getUserInfo());
    return ProfilecontrollerModel.intial();
  }

  Future getUserInfo() async {
    final uid = ref.read(firebaseAuthProvider).currentUser!.uid;
    final user = await ref.read(profileRepo).getUserInfo(uid);
    state = state.copyWith(userModel: user, isLoading: false);
  }

  Future getUsers({required List<String> ids}) async {
    final user = await ref.read(profileRepo).users(ids);
    state = state.copyWith(users: user);
  }

  Future getChatUsers({required List<String> ids}) async {
    final user = await ref.read(profileRepo).users(ids);
    state = state.copyWith(chatUsers: user);
  }

  updateUserInfo() async {}

  Future<void> hostedEvent(String uid, String eventId) async {
    try {
      final db = ref.read(firestoreProvider);
      state = state.copyWith(
        userModel: state.userModel.copyWith(
          eventsHosted: [...state.userModel.eventsHosted, eventId],
          eventsJoined: [...state.userModel.eventsJoined, eventId],
        ),
      );
      await db.collection('users').doc(uid).update({
        'eventsHosted': state.userModel.eventsHosted,
        'eventsJoined': state.userModel.eventsJoined,
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> joinedEvent(String uid, String eventId) async {
    try {
      final db = ref.read(firestoreProvider);
      state = state.copyWith(
        userModel: state.userModel.copyWith(
          eventsJoined: [...state.userModel.eventsJoined, eventId],
        ),
      );
      await db.collection('users').doc(uid).update({
        'eventsJoined': state.userModel.eventsJoined,
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
