import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/build_logo.dart';
import 'widgets/general_widgets.dart';

class TravelStyleScreen extends ConsumerWidget {
  const TravelStyleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = [
      "Solo Adventurer",
      "Couple's Journey",
      "Nomadic Crew",
      "Weekend Warrior",
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60.h),
            const BuildLogo(),
            const Spacer(),
            Text(
              "What's your travel style?",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
            ),
            SizedBox(height: 50.h),
            ...styles
                .expand(
                  (style) => [
                    genderOption(context, style, () {
                      context.push('/onboarding-profileImage');
                      // Using your provider logic
                      // ref.read(onboardingProvider.notifier).addTravelStyle(style: style, context: context);
                    }),
                    buildDashedDivider(),
                  ],
                )
                .toList()
              ..removeLast(), // Remove last divider for clean look
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
