import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/features/auth/presentation/authentication_controller.dart';

final authenticationProvider =
    AsyncNotifierProvider<AuthenticationController, void>(() {
      return AuthenticationController();
    });
