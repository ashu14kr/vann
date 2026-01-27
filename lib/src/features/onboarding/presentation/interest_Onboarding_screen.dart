import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'widgets/build_button.dart';
import 'widgets/build_logo.dart';
import 'widgets/interest_card.dart';

class InterestOnboardingScreen extends StatefulWidget {
  const InterestOnboardingScreen({super.key});

  @override
  State<InterestOnboardingScreen> createState() =>
      _InterestOnboardingScreenState();
}

class _InterestOnboardingScreenState extends State<InterestOnboardingScreen> {
  final List<String> interests = [
    "CRICKET",
    "HIKING",
    "SURFING",
    "CAMPING",
    "SNAPS",
    "COFFEE",
    "VAN LIFE",
    "MUSIC",
    "ROAD TRIPS",
    "STARS",
    "FISHING",
    "COOKING",
    "READING",
    "MAPS",
    "DOGS",
  ];

  final Set<int> selectedIndices = {};

  @override
  Widget build(BuildContext context) {
    bool canContinue = selectedIndices.length >= 5;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60.h),
            const BuildLogo(),
            SizedBox(height: 40.h),
            Text(
              "What are you into?",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 30.h),

            // The "Cloud" of interests
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Wrap(
                  spacing: 10.w,
                  runSpacing: 12.h,
                  alignment: WrapAlignment.center,
                  children: List.generate(interests.length, (index) {
                    // Random rotation for that "un-aligned" sticker look
                    final double rotation =
                        (Random(index).nextDouble() * 0.14) - 0.07;

                    return Transform.rotate(
                      angle: rotation,
                      child: InterestCard(
                        label: interests[index],
                        isRounded: Random(index).nextBool(),
                        isSelected: selectedIndices.contains(index),
                        onTap: () {
                          setState(() {
                            if (selectedIndices.contains(index)) {
                              selectedIndices.remove(index);
                            } else {
                              selectedIndices.add(index);
                            }
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),

            // BIG BOLD CONTINUE BUTTON
            BuildButton(
              canContinue: canContinue,
              onTap: () {
                context.push('/onboarding-accountLoading');
              },
            ),
          ],
        ),
      ),
    );
  }
}
