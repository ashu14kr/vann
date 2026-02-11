import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:van_life/src/features/onboarding/presentation/provider.dart/onboarding_provider.dart';

class DummyUserGenerator extends ConsumerWidget {
  const DummyUserGenerator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFE600),
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        onPressed: () async {
          ref
              .read(onboardingProvider.notifier)
              .dummyUser(context: context, uid: 'UfP5mvBpEffFKz0B6OZ746Ut2sV2');
        },
        child: Text(
          "GENERATE DUMMY USERS",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
