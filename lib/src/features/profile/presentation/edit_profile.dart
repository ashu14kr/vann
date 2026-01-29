import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:van_life/src/features/profile/presentation/provider/profile_provider.dart';

import 'widgets/edit_profile_generalWidgets.dart';

class EditProfileBottomSheet extends ConsumerStatefulWidget {
  const EditProfileBottomSheet({super.key});

  @override
  ConsumerState<EditProfileBottomSheet> createState() =>
      _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState
    extends ConsumerState<EditProfileBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileProvider);
    TextEditingController name = TextEditingController(
      text: user.userModel.displayName,
    );
    String travelStyle = user.userModel.travelType;
    TextEditingController age = TextEditingController(text: user.userModel.age);
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
          ),
          child: Column(
            children: [
              // --- FIXED HEADER (NON-SCROLLABLE) ---
              buildFixedHeader(context),

              // --- SCROLLABLE FORM CONTENT ---
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  children: [
                    SizedBox(height: 10.h),

                    // Profile Image Section
                    Center(
                      child: buildAestheticImagePicker(
                        image: user.userModel.profileImages,
                      ),
                    ),

                    SizedBox(height: 50.h),

                    // Input Sections
                    buildCustomInput("NAME", 'name', name),
                    buildCustomInput("AGE", 'age', age),
                    // _buildCustomInput(
                    //   "BIO",
                    //   "Chasing sunsets in a 4x4...",
                    //   maxLines: 3,
                    // ),

                    // Travel Style Section
                    buildLabel("TRAVEL STYLE"),
                    SizedBox(height: 16.h),
                    buildTravelStyleGrid(selectedStyle: travelStyle),

                    SizedBox(height: 30.h),

                    // Interests Section
                    buildLabel("INTERESTS"),
                    SizedBox(height: 16.h),

                    buildInterestsGrid(
                      interest: user.userModel.interests,
                      onTap: () {},
                    ),
                    SizedBox(height: 60.h),
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
