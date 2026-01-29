import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.onTap, required this.image});

  final VoidCallback onTap;
  final List<String> image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 15.r,
              offset: Offset(0, 5.h),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: 34.r,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 31.r,
            backgroundImage:
                image.isEmpty
                    ? AssetImage('assets/images/male_avatar.png')
                    : NetworkImage(image[0]),
          ),
        ),
      ),
    );
  }
}
