import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/build_logo.dart';

class AgeOnboardingScreen extends StatefulWidget {
  const AgeOnboardingScreen({super.key});

  @override
  State<AgeOnboardingScreen> createState() => _AgeOnboardingScreenState();
}

class _AgeOnboardingScreenState extends State<AgeOnboardingScreen> {
  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Deep aesthetic black
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),

              // 1. EXPLORE LOGO (Roboto Condensed)
              const BuildLogo(),

              const Spacer(flex: 1),

              // 2. THE QUESTION (Poppins)
              Text(
                "What's your age?",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 30.h),

              // 3. AGE INPUT (Poppins)
              TextField(
                controller: _ageController,
                textAlign: TextAlign.center,
                autofocus: true,
                cursorColor: Colors.white,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 38.sp,
                  fontWeight: FontWeight.w700,
                ),
                onSubmitted: (value) {
                  context.push('/onboarding-gender');
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Your Age",
                  hintStyle: TextStyle(color: Colors.white24, fontSize: 38.sp),
                ),
              ),

              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
