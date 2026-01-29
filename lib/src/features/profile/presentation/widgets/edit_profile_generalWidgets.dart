import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../onboarding/data/onboarding_constant_data.dart';

Widget buildFixedHeader(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(30.w, 15.h, 25.w, 10.h),
    child: Column(
      children: [
        // Handlebar
        Container(
          width: 55.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: const Color.fromARGB(194, 255, 255, 255),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "EDIT PROFILE",
              style: GoogleFonts.robotoCondensed(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),
            // THE DONE BUTTON
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "DONE",
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        const Divider(color: Colors.white10, thickness: 1),
      ],
    ),
  );
}

// --- 2. THE IMAGE PICKER ---
Widget buildAestheticImagePicker({required List<String> image}) {
  return Stack(
    children: [
      Container(
        height: 110.h,
        width: 110.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12, width: 2),
          image: DecorationImage(
            image:
                image.isEmpty
                    ? AssetImage('assets/images/profile.png')
                    : NetworkImage(image.first),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: CircleAvatar(
          radius: 16.r,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.camera_alt_outlined,
            size: 14.sp,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}

// --- 3. CUSTOM INPUT ---
Widget buildCustomInput(
  String label,
  String hint,
  TextEditingController controller, {
  int maxLines = 1,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 35.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(label),
        TextField(
          maxLines: maxLines,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          cursorColor: Colors.white,
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white30),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white30),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  );
}

// --- 4. THE GRID SELECTORS ---
Widget buildTravelStyleGrid({required String selectedStyle}) {
  final styles = ["Solo", "Couple", "Nomad", "Weekend Traveller"];
  return Wrap(
    spacing: 10.w,
    runSpacing: 10.h,
    children:
        styles
            .map(
              (s) => buildSelectionBox(s, selectedStyle == s, () {
                selectedStyle = s;
                print(selectedStyle);
              }),
            )
            .toList(),
  );
}

Widget buildInterestsGrid({
  required List<String> interest,
  required VoidCallback onTap,
}) {
  return Wrap(
    spacing: 10.w,
    runSpacing: 10.h,
    children:
        interests
            .map((i) => buildSelectionBox(i, interest.contains(i), onTap))
            .toList(),
  );
}

Widget buildSelectionBox(String label, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: isSelected ? Colors.white : Colors.white10),
      ),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.robotoCondensed(
          color: isSelected ? Colors.black : Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buildLabel(String text) {
  return Text(
    text,
    style: GoogleFonts.robotoCondensed(
      color: Colors.white,
      fontSize: 11.sp,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.5,
    ),
  );
}
