import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:van_life/src/features/onboarding/presentation/provider.dart/onboarding_provider.dart';

import 'widgets/build_logo.dart';

class AccountLoadingScreen extends ConsumerStatefulWidget {
  const AccountLoadingScreen({super.key});

  @override
  ConsumerState<AccountLoadingScreen> createState() =>
      _AccountLoadingScreenState();
}

class _AccountLoadingScreenState extends ConsumerState<AccountLoadingScreen> {
  @override
  void initState() {
    ref.read(onboardingProvider.notifier).navigateToHome(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Solid dark background
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60.h),
              // 1. Brand Logo (VANN with thick border/black fill)
              const BuildLogo(),
              SizedBox(height: 100.h),
              // 2. Loading Texts (Poppins)
              Text(
                "Creating your account",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "Just a sec!",
                style: GoogleFonts.poppins(
                  color: Colors.white54, // Muted white
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const Spacer(),
              // 3. Static Rocket Image
              Padding(
                padding: EdgeInsets.only(bottom: 120.0.h),
                child: Image.asset(
                  'assets/images/rocket.webp', // Replace with your static asset
                  height: 280.h,
                  width: 280.w,
                  fit: BoxFit.contain,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
