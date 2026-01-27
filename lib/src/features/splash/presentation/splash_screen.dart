import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:van_life/src/features/splash/presentation/provider/splash_provider.dart';

import 'widgets/build_logo.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    // Start your navigation logic
    ref.read(splashProvider.notifier).navigateFromSplash(context: context);
  }

  Future<void> _startAnimation() async {
    // Small delay to ensure the frame is rendered before animating
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      setState(() => _animate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/van-life-cool-scene.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeIn,
            opacity: _animate ? 1.0 : 0.0,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 800),
              curve: Curves.bounceOut, // Gives a slight "pop" effect
              scale: _animate ? 1.0 : 0.5,
              child: const BuildLogo(),
            ),
          ),
        ),
      ),
    );
  }
}
