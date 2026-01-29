import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:van_life/src/core/services/storage_service.dart';

class AuthenticationController extends AsyncNotifier {
  @override
  FutureOr build() {
    throw UnimplementedError();
  }

  Future<void> signInWithApple({required BuildContext context}) async {
    try {
      EasyLoading.show();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.identityToken != null) {
        // 1. Create Firebase Credential
        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: credential.identityToken,
          accessToken: credential.authorizationCode,
        );

        // 2. Sign in to Firebase Auth
        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          oauthCredential,
        );
        final user = userCredential.user;

        if (user != null) {
          // 3. Save locally as you were doing
          await StorageService().setOnboardingStatus(false);
          await StorageService().setUserId(user.uid);

          // Note: Apple only sends email/name on the VERY FIRST sign-in
          if (credential.email != null) {
            await StorageService().setUserEmail(credential.email!);
          }

          if (!context.mounted) return;
          EasyLoading.dismiss();
          context.go('/onboarding-name');
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("Apple Sign-In Failed: $e");
    }
  }
}
