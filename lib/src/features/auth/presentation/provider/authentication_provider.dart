import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/features/auth/data/auth_repository.dart';
import 'package:van_life/src/features/auth/presentation/authentication_controller.dart';
import 'package:van_life/src/share/providers/shared_providers.dart';

final authenticationProvider =
    AsyncNotifierProvider<AuthenticationController, void>(() {
      return AuthenticationController();
    });

final authRepo = Provider((ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  return AuthRepository(auth: firebaseAuth);
});
