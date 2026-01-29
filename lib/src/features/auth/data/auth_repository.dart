import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:van_life/src/features/auth/domain/auth_interface.dart';

class AuthRepository implements AuthInterface {
  final FirebaseAuth auth;

  AuthRepository({required this.auth});

  @override
  Future<bool> signInWithApple({required BuildContext context}) async {
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
        final userCredential = await auth.signInWithCredential(oauthCredential);
        final user = userCredential.user;

        if (user == null) {
          return false;
        }
      }
      return true;
    } catch (e) {
      EasyLoading.dismiss();
      print("Apple Sign-In Failed: $e");
      return false;
    }
  }
}
