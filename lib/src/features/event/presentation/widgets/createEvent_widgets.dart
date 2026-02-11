import 'dart:math';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:van_life/src/features/event/presentation/provider/provider.dart';
import 'package:van_life/src/features/event/presentation/widgets/select_location.dart';

import '../../../onboarding/presentation/widgets/interest_card.dart';

Widget buildGrabHandle() {
  return Center(
    child: Container(
      width: 50.w,
      height: 6.h,
      margin: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
  );
}

Widget buildBadge() {
  return Center(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        'NEW EVENT',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget buildVibeWrap(
  List<String> vibes,
  Function(int index) onTap,
  List<int> selectedIndices,
) {
  return Wrap(
    spacing: 12.w,
    runSpacing: 15.h,
    children: List.generate(vibes.length, (index) {
      final double rotation = (Random(index).nextDouble() * 0.12) - 0.06;
      return Transform.rotate(
        angle: rotation,
        child: InterestCard(
          label: vibes[index],
          isRounded: index % 2 == 0,
          isSelected: selectedIndices.contains(index),
          onTap: () => onTap(index), // Fixed: Wrapped in a closure
        ),
      );
    }),
  );
}

Widget buildPublishButton({required VoidCallback ontap}) {
  return InkWell(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 18.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF2BC56), Color(0xFFF9E364)],
        ),
        borderRadius: BorderRadius.circular(35.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 20.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: Text(
        'PUBLISH',
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20.sp,
        ),
      ),
    ),
  );
}

Widget buildFullDetailsBox(
  TextStyle style,
  BuildContext context,
  String location,
  String startDate,
  String endDate,
  String capacity,
) {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFF1A1A1A),
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Consumer(
      builder:
          (context, ref, child) => Column(
            children: [
              buildDetailRow(
                'Location',
                location,
                style,
                icon: Icons.location_on_outlined,
                ontap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.black54,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: AestheticLocationPicker(
                          onSelect: (LatLng, placeData) {
                            ref
                                .read(eventController.notifier)
                                .updateLocation(
                                  latLng: LatLng,
                                  address: placeData,
                                );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              buildDetailRow(
                'Starts',
                startDate,
                style,
                icon: Icons.calendar_today_outlined,
                ontap: () {
                  showDateTimePicker(context, isStart: true);
                },
              ),
              buildDetailRow(
                'Ends',
                endDate,
                style,
                icon: Icons.calendar_month_outlined,
                ontap: () {
                  showDateTimePicker(context, isStart: false);
                },
              ),
              // buildDetailRow(
              //   'Price',
              //   'Free',
              //   style,
              //   icon: Icons.payments_outlined,
              //   ontap: () {},
              // ),
              buildDetailRow(
                'Group capacity',
                capacity,
                style,
                icon: Icons.group_outlined,
                isLast: true,
                ontap: () {
                  showWheelPicker(
                    context,
                    title: 'Group Capacity',
                    unit: 'Person',
                    onConfirm: (capacity) {
                      ref
                          .read(eventController.notifier)
                          .updateCapacity(capacity);
                    },
                    minValue: 1,
                    maxValue: 100,
                    initialValue: 1,
                  );
                },
              ),
            ],
          ),
    ),
  );
}

Widget buildDetailRow(
  String label,
  String value,
  TextStyle style, {
  required IconData icon,
  required VoidCallback ontap,
  bool isLast = false,
}) {
  return Container(
    padding: EdgeInsets.all(18.r),
    decoration: BoxDecoration(
      border:
          isLast
              ? null
              : Border(bottom: BorderSide(color: Colors.white10, width: 0.8.w)),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white54, size: 20.sp),
        SizedBox(width: 12.w),
        Text(
          label,
          style: style.copyWith(color: Colors.white, fontSize: 16.sp),
        ),
        const Spacer(),
        InkWell(
          onTap: ontap,
          child: Row(
            children: [
              Text(
                value,
                style: style.copyWith(color: Colors.white38, fontSize: 16.sp),
              ),
              SizedBox(width: 5.w),
              Icon(Icons.chevron_right, color: Colors.white24, size: 20.sp),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildTextField({
  required String hint,
  required TextStyle fontStyle,
  required TextEditingController controller,
  int maxLines = 1,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
    decoration: BoxDecoration(
      color: const Color(0xFF1A1A1A),
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: TextField(
      controller: controller,
      maxLines: maxLines,
      style: fontStyle.copyWith(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: fontStyle.copyWith(color: Colors.white24, fontSize: 14.sp),
        border: InputBorder.none,
        isDense: true,
      ),
    ),
  );
}

Widget buildTile({
  required String label,
  required String value,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.robotoCondensed(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: Colors.white38,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(icon, size: 14, color: Colors.white24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

void showDateTimePicker(BuildContext context, {required bool isStart}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A), // Match your tile color
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Consumer(
          builder:
              (context, ref, child) => Column(
                children: [
                  // Handle & Title
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isStart ? "SELECT START TIME" : "SELECT END TIME",
                        style: GoogleFonts.robotoCondensed(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "DONE",
                          style: GoogleFonts.poppins(
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // The Picker
                  Expanded(
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        brightness: Brightness.dark,
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.dateAndTime,
                        initialDateTime:
                            isStart
                                ? DateTime.now()
                                : DateTime.now().add(const Duration(hours: 2)),
                        onDateTimeChanged: (DateTime newDateTime) {
                          if (isStart) {
                            ref
                                .read(eventController.notifier)
                                .updateStartDate(newDateTime);
                          } else {
                            ref
                                .read(eventController.notifier)
                                .updateEndDate(newDateTime);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
        ),
      );
    },
  );
}

void showWheelPicker(
  BuildContext context, {
  required String title,
  required int minValue,
  required int maxValue,
  required int initialValue,
  required String unit,
  required Function(int) onConfirm,
}) {
  int selectedVal = initialValue;

  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Handle & Header
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onConfirm(selectedVal);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "SET",
                    style: GoogleFonts.poppins(
                      color: Colors.cyanAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            // The Wheel Picker
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Unit Label Overlay (Static in center)
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.25,
                    child: Text(
                      unit,
                      style: GoogleFonts.poppins(
                        color: Colors.white24,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  CupertinoTheme(
                    data: const CupertinoThemeData(brightness: Brightness.dark),
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: initialValue - minValue,
                      ),
                      itemExtent: 45,
                      onSelectedItemChanged:
                          (index) => selectedVal = minValue + index,
                      children: List.generate(
                        (maxValue - minValue) + 1,
                        (index) => Center(
                          child: Text(
                            "${minValue + index}",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
