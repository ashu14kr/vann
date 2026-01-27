import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/build_bg.dart';
import 'widgets/build_button.dart';
import 'widgets/build_dark.dart';
import 'widgets/build_logo.dart';
import 'widgets/fade_slideIn.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BuildBg(),
          const BuildDark(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.0.w,
                vertical: 20.0.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Logo
                  FadeSlideIn(delay: 0.2, child: const BuildLogo()),
                  SizedBox(height: 2.h),

                  // 2. Main Header
                  FadeSlideIn(
                    delay: 0.4,
                    child: Text(
                      'SIGN IN NOW TO FIND COOL PEOPLES',
                      style: GoogleFonts.robotoCondensed(
                        color: Colors.white,
                        fontSize: 40.sp,
                        height: 1.1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // 3. Apple Button
                  FadeSlideIn(
                    delay: 0.6,
                    child: BuildButton(
                      onTap: () => context.go('/onboarding-name'),
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // 4. Footer Terms
                  FadeSlideIn(
                    delay: 0.8,
                    child: Center(
                      child: Text(
                        'By continuing you agree to\nterms and conditions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.sp,
                          letterSpacing: 0.5.w,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
