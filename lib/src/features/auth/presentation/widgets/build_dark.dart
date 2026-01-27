import 'package:flutter/material.dart';

class BuildDark extends StatelessWidget {
  const BuildDark({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.1),
              Colors.black.withOpacity(0.7), // Darker at the bottom
            ],
          ),
        ),
      ),
    );
  }
}
