import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({
    super.key,
    required this.canContinue,
    required this.onTap,
  });

  final bool canContinue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      // Fade out and slide down when not ready
      child:
          canContinue
              ? SizedBox(
                width: double.infinity,
                height: 75.h, // Increased height for better presence
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "CONTINUE",
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp, // Much larger font size
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0.w, // Spaced out for premium look
                    ),
                  ),
                ),
              )
              : SizedBox(height: 75.h), // Keep space so layout doesn't jump
    );
  }
}
