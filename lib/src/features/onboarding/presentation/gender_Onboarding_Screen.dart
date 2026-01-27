import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/build_logo.dart';

class GenderOnboardingScreen extends StatelessWidget {
  const GenderOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            _genderOption(context, "Female"),
            _buildDashedDivider(),
            _genderOption(context, "Male"),
            _buildDashedDivider(),
            _genderOption(context, "Non - Binary"),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _genderOption(BuildContext context, String label) {
    return GestureDetector(
      onTap: () {
        context.push('/onboarding-interests');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0.h),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildDashedDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.0.w),
      child: Row(
        children: List.generate(
          30,
          (index) => Expanded(
            child: Container(
              color: index % 2 == 0 ? Colors.transparent : Colors.white24,
              height: 1.h,
            ),
          ),
        ),
      ),
    );
  }
}
