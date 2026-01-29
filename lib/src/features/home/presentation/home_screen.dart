import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:van_life/src/features/event/presentation/create_event_bottomSheet.dart';
import 'package:van_life/src/features/event/presentation/event_detail_bottomSheet.dart';
import 'package:van_life/src/features/profile/presentation/provider/profile_provider.dart';

import '../../profile/presentation/profile_BottomCard.dart';
import 'widgets/dark_overlay.dart';
import 'widgets/general_ui_widgets.dart';
import 'widgets/profile_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  BitmapDescriptor? _carIcon;
  Set<Annotation> _annotations = {};

  @override
  void initState() {
    super.initState();
    _loadCustomIcon();
  }

  // Load the asset as a BitmapDescriptor
  Future<void> _loadCustomIcon() async {
    _carIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(20, 20)),
      'assets/images/cool_sticker.png',
    );
    _updateCarPointer(39.0490, -77.1197, 90.0); // Initial position
  }

  void _updateCarPointer(double lat, double lng, double heading) {
    if (_carIcon == null) return;

    setState(() {
      _annotations = {
        Annotation(
          annotationId: AnnotationId('car_pointer'),
          position: LatLng(lat, lng),
          icon: _carIcon!,
          onTap: () {
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
                  child: const EventDetailBottomSheet(),
                );
              },
            );
          },
          anchor: const Offset(0.5, 0.5),
        ),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. APPLE MAP LAYER
          AppleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(39.0490, -77.1197),
              zoom: 14,
              pitch: 60,
              heading: 0,
            ),
            annotations: _annotations,
            onMapCreated: (AppleMapController controller) {},
          ),

          // 2. GRADIENT OVERLAY
          const DarkOverlay(),

          // 3. TOP UI BAR (Logo and Profile)
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w, // Applied ScreenUtil
                vertical: 10.h, // Applied ScreenUtil
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildExploreLogo(), // Assuming this already uses .sp/.w inside its definition
                  ProfileView(
                    onTap: () {
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
                            child: const ProfileBottomCard(),
                          );
                        },
                      );
                    },
                    image: ref.watch(profileProvider).userModel.profileImages,
                  ),
                ],
              ),
            ),
          ),

          // 4. BOTTOM NAVIGATION BAR
          Positioned(
            bottom: 40.h, // Applied ScreenUtil
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCircularNavIcon(
                  Icons.public,
                  isSmall: true,
                  ontap: () {
                    context.push('/travel-progress');
                  },
                ),
                buildCircularNavIcon(
                  Icons.add,
                  isLarge: true,
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
                          child: const CreateEventBottomSheet(),
                        );
                      },
                    );
                  },
                ),
                buildCircularNavIcon(
                  Icons.chat_bubble_outline,
                  isSmall: true,
                  ontap: () {
                    context.push('/chat');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
