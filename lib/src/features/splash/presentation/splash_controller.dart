import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:van_life/src/core/services/storage_service.dart';

class SplashController extends AsyncNotifier {
  @override
  FutureOr build() {
    throw UnimplementedError();
  }

  Future navigateFromSplash({required BuildContext context}) async {
    final uuid = await StorageService().getUserId();
    final onboardingStatus = await StorageService().getOnboardingStatus();
    if (uuid != null) {
      if (!onboardingStatus) {
        Timer(Duration(seconds: 2), () {
          context.go('/onboarding-name');
        });
      } else {
        Timer(Duration(seconds: 2), () {
          context.go('/home');
        });
      }
    } else {
      Timer(Duration(seconds: 2), () {
        context.go('/authentication-screen');
      });
    }
  }
}
