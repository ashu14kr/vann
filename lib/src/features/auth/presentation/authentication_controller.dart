import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:van_life/src/core/services/storage_service.dart';
import 'package:van_life/src/features/auth/presentation/provider/authentication_provider.dart';
import 'package:van_life/src/share/providers/shared_providers.dart';

class AuthenticationController extends AsyncNotifier {
  @override
  FutureOr build() {
    throw UnimplementedError();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> signIn({required BuildContext context}) async {
    try {
      final result = await ref.read(authRepo).signInWithApple(context: context);
      if (result) {
        final user = ref.read(firebaseAuthProvider).currentUser;
        if (user != null) {
          final result = await _db.collection('users').doc(user.uid).get();
          final data = result.data();

          if (!result.exists) {
            // 3. Save locally as you were doing
            await StorageService().setOnboardingStatus(false);
            await StorageService().setUserId(user.uid);

            if (user.email != null) {
              await StorageService().setUserEmail(user.email!);
            }

            if (!context.mounted) return;
            EasyLoading.dismiss();
            context.go('/onboarding-name');
          } else {
            await StorageService().setOnboardingStatus(data!['isOnboarded']);
            await StorageService().setUserId(user.uid);

            if (user.email != null) {
              await StorageService().setUserEmail(user.email!);
            }

            if (!context.mounted) return;
            EasyLoading.dismiss();
            if (data['isOnboarded'] == false) {
              context.go('/onboarding-name');
            } else {
              context.go('/home');
            }
          }
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("Apple Sign-In Failed: $e");
    }
  }
}
