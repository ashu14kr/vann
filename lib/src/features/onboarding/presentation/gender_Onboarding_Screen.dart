import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:van_life/src/features/onboarding/presentation/provider.dart/onboarding_provider.dart';

import 'widgets/build_logo.dart';
import 'widgets/general_widgets.dart';

class GenderOnboardingScreen extends ConsumerWidget {
  const GenderOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60.h),
            const BuildLogo(),

            const Spacer(flex: 1),

            Text(
              "How do you identify?",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
            ),

            SizedBox(height: 50.h),

            // Gender Options
            genderOption(context, "Female", () {
              ref
                  .read(onboardingProvider.notifier)
                  .addGender(gender: 'Female', context: context);
            }),
            buildDashedDivider(),
            genderOption(context, "Male", () {
              ref
                  .read(onboardingProvider.notifier)
                  .addGender(gender: 'Male', context: context);
            }),
            buildDashedDivider(),
            genderOption(context, "Non - Binary", () {
              ref
                  .read(onboardingProvider.notifier)
                  .addGender(gender: 'Non - Binary', context: context);
            }),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
