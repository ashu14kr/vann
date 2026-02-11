import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:van_life/src/features/event/presentation/provider/provider.dart';
import 'package:van_life/src/features/home/presentation/provider/home_provider.dart';

class EventDiscoveryScreen extends ConsumerStatefulWidget {
  const EventDiscoveryScreen({super.key});

  @override
  ConsumerState<EventDiscoveryScreen> createState() =>
      _EventDiscoveryScreenState();
}

class _EventDiscoveryScreenState extends ConsumerState<EventDiscoveryScreen> {
  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventController);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: events.events.length,
            itemBuilder: (context, index) {
              return EventCardStack(
                image: events.events[index].coverImage,
                title: events.events[index].title,
                subtitle: events.events[index].description,
                host: events.events[index].hostId ?? 'Unknown Host',
                ontap: () {
                  ref
                      .read(homeProvider.notifier)
                      .showEventDetail(context, events.events[index]);
                },
              );
            },
          ),
          Positioned(top: 80.h, left: 20.w, right: 20.w, child: buildTopBar()),
        ],
      ),
    );
  }
}

class EventCardStack extends StatelessWidget {
  const EventCardStack({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.host,
    required this.ontap,
  });

  final String image;
  final String title;
  final String subtitle;
  final String host;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Image.network(image, fit: BoxFit.cover)),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.transparent,
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 100.h,
          left: 20.w,
          right: 20.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAvatarGroup(),
              SizedBox(height: 8.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoCondensed(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white70, fontSize: 14.sp),
              ),
              SizedBox(height: 25.h),
              _buildBottomActions(ontap),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildAvatarGroup() {
  return SizedBox(
    height: 80.h,
    width: 160.w,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.black, width: 3),
            image: const DecorationImage(
              image: AssetImage('assets/images/male_avatar.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _circleAvatar(String img, {double size = 50}) {
  return Container(
    width: size.w,
    height: size.h,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.white, width: 2),
      image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
    ),
  );
}

Widget _buildBottomActions(VoidCallback ontap) {
  return Row(
    children: [
      // Left Side Icons
      _glassCircleIcon(Icons.favorite_border),
      const Spacer(),
      InkWell(
        onTap: ontap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  Text(
                    "View Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 14.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _glassCircleIcon(IconData icon) {
  return Container(
    width: 45.w,
    height: 45.h,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withOpacity(0.15),
      border: Border.all(color: Colors.white10),
    ),
    child: Icon(icon, color: Colors.white, size: 22.sp),
  );
}

Widget buildTopBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20.r,
              spreadRadius: 5.r,
            ),
          ],
        ),
        child: Stack(
          children: [
            Text(
              'EXPLORE',
              style: GoogleFonts.robotoCondensed(
                fontSize: 42.sp,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                letterSpacing: -2.w,
                foreground:
                    Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 8.w
                      ..color = Colors.white,
              ),
            ),
            Text(
              'EXPLORE',
              style: GoogleFonts.robotoCondensed(
                fontSize: 42.sp,
                fontWeight: FontWeight.w900,
                fontStyle: FontStyle.italic,
                color: Colors.black,
                letterSpacing: -2.w,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
