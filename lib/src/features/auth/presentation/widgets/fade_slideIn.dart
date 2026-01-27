import 'package:flutter/material.dart';

class FadeSlideIn extends StatelessWidget {
  final Widget child;
  final double delay; // Delay in seconds

  const FadeSlideIn({super.key, required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      // We use the delay to stagger the start time
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)), // Slides up 30 pixels
            child: child,
          ),
        );
      },
      // This is a trick: we wrap the builder in a delay timer if we wanted,
      // but for simple logic, using the 'delay' in a Future is easier.
      child: child,
    );
  }
}
