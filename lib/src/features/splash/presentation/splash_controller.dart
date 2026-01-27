import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashController extends AsyncNotifier {
  @override
  FutureOr build() {
    throw UnimplementedError();
  }

  void navigateFromSplash({required BuildContext context}) {
    Timer(Duration(seconds: 2), () {
      context.go('/authentication-screen');
    });
  }
}
