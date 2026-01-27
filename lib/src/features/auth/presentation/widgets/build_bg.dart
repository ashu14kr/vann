import 'package:flutter/material.dart';

class BuildBg extends StatelessWidget {
  const BuildBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/van-life-cool-scene.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
