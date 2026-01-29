import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/settings_general_widgets.dart';

class SettingsBottomSheet extends ConsumerWidget {
  const SettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0), // Consistent deep black
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
          ),
          child: Column(
            children: [
              buildHeader(context),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  children: [
                    SizedBox(height: 20.h),

                    buildSectionLabel("LEGAL & COMMUNITY"),
                    buildSettingsTile(
                      "Privacy Policy",
                      Icons.security_outlined,
                      () {},
                    ),
                    buildSettingsTile(
                      "Terms of Service",
                      Icons.description_outlined,
                      () {},
                    ),
                    buildSettingsTile(
                      "Community Guidelines",
                      Icons.people_outline,
                      () {},
                    ),

                    SizedBox(height: 40.h),

                    buildSectionLabel("APP PREFERENCES"),
                    buildSettingsTile(
                      "Notifications",
                      Icons.notifications_none,
                      () {},
                    ),
                    buildSettingsTile(
                      "Blocked Users",
                      Icons.block_flipped,
                      () {},
                    ),

                    SizedBox(height: 50.h),

                    // --- APPLE MANDATORY: ACCOUNT DELETION ---
                    buildDangerSection(context),

                    SizedBox(height: 60.h),

                    Center(
                      child: Text(
                        "VANN V1.0.2",
                        style: GoogleFonts.robotoCondensed(
                          color: Colors.white10,
                          fontSize: 12.sp,
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
