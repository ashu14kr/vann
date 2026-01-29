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

  updateUserInfo() async {}
}
