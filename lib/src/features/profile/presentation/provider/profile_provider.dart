import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/features/profile/data/models/profileController_model.dart';
import 'package:van_life/src/features/profile/data/repository/profile_repository.dart';
import 'package:van_life/src/features/profile/presentation/profile_controller.dart';
import 'package:van_life/src/share/providers/shared_providers.dart';

final profileProvider =
    NotifierProvider<ProfileController, ProfilecontrollerModel>(() {
      return ProfileController();
    });

final profileRepo = Provider((ref) {
  final db = ref.read(firestoreProvider);
  return ProfileRepository(db: db);
});
