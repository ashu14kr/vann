import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:van_life/src/features/onboarding/presentation/provider.dart/onboarding_provider.dart';
import 'dart:math';

import '../data/onboarding_constant_data.dart';
import 'widgets/build_button.dart';
import 'widgets/build_logo.dart';
import 'widgets/interest_card.dart';

class InterestOnboardingScreen extends ConsumerStatefulWidget {
  const InterestOnboardingScreen({super.key});

  @override
  ConsumerState<InterestOnboardingScreen> createState() =>
      _InterestOnboardingScreenState();
}

class _InterestOnboardingScreenState
    extends ConsumerState<InterestOnboardingScreen> {
  final List<String> selectedIndices = [];

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
                        isSelected: selectedIndices.contains(interests[index]),
                        onTap: () {
                          setState(() {
                            if (selectedIndices.contains(interests[index])) {
                              selectedIndices.remove(interests[index]);
                            } else {
                              selectedIndices.add(interests[index]);
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
                ref
                    .read(onboardingProvider.notifier)
                    .addInterest(interest: selectedIndices, context: context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
