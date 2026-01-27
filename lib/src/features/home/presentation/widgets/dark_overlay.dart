import 'package:flutter/material.dart';

class DarkOverlay extends StatelessWidget {
  const DarkOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.0, 0.6, 0.8, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
