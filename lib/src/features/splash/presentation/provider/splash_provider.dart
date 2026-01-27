import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/features/splash/presentation/splash_controller.dart';

final splashProvider = AsyncNotifierProvider<SplashController, void>(() {
  return SplashController();
});
