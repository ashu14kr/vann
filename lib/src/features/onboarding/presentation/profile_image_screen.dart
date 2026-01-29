import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'widgets/build_button.dart';
import 'widgets/build_logo.dart';

class ProfileImageScreen extends StatefulWidget {
  const ProfileImageScreen({super.key});

  @override
  State<ProfileImageScreen> createState() => _ProfileImageScreenState();
}

class _ProfileImageScreenState extends State<ProfileImageScreen> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 60.h),
            const BuildLogo(),

            const Spacer(flex: 2),

            // Subtle "Scanning" or "Identity" header vibe
            Text(
              _image == null ? "SET YOUR PROFILE" : "LOOKING GOOD",
              style: GoogleFonts.robotoCondensed(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),

            SizedBox(height: 12.h),

            Text(
              _image == null
                  ? "Upload a photo for the community"
                  : "You're all set to proceed",
              style: GoogleFonts.poppins(
                color: Colors.white38,
                fontSize: 13.sp,
              ),
            ),

            SizedBox(height: 50.h),

            // THE PROFILE FRAME
            GestureDetector(
              onTap: () async {
                final picked = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 80, // Optimized for mobile
                );
                if (picked != null) setState(() => _image = File(picked.path));
              },
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 220.h,
                  width: 220.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Subtle glow effect when image is selected
                    boxShadow: [
                      BoxShadow(
                        color:
                            _image != null
                                ? Colors.white.withOpacity(0.05)
                                : Colors.transparent,
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                    border: Border.all(
                      color: _image != null ? Colors.white : Colors.white10,
                      width: 1,
                    ),
                    image:
                        _image != null
                            ? DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      _image == null
                          ? Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.white24,
                            size: 32.sp,
                          )
                          : null,
                ),
              ),
            ),

            const Spacer(flex: 3),

            // Consistency with VANN Onboarding Button
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: BuildButton(
                canContinue: _image != null,
                onTap: () => context.go('/onboarding-verification'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
