import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/build_logo.dart';
import 'widgets/fade_slideIn.dart';

class NameOnboardingScreen extends StatefulWidget {
  const NameOnboardingScreen({super.key});

  @override
  State<NameOnboardingScreen> createState() => _NameOnboardingScreenState();
}

class _NameOnboardingScreenState extends State<NameOnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),

              // 1. Logo (appears almost immediately)
              const FadeSlideIn(delay: 0.1, child: BuildLogo()),

              const Spacer(flex: 1),

              // 2. The Question (appears after 0.3s)
              FadeSlideIn(
                delay: 0.3,
                child: Text(
                  "What's your name?",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              // 3. Name Input (appears after 0.5s)
              FadeSlideIn(
                delay: 0.5,
                child: TextField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  autofocus: true,
                  cursorColor: Colors.white,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 38.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  onSubmitted: (value) {
                    context.push('/onboarding-age');
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Your Name",
                    hintStyle: TextStyle(
                      color: Colors.white24,
                      fontSize: 38.sp,
                    ),
                  ),
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
