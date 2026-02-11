import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Added import
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:van_life/src/features/event/presentation/create_event_bottomSheet.dart';
import 'package:van_life/src/features/event/presentation/provider/provider.dart';
import 'package:van_life/src/features/home/presentation/provider/home_provider.dart';
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
  AppleMapController? _mapController;
  Timer? _debounceTimer;
  double _currentZoom = 12.05; // Default zoom level

  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventController);
    final position = ref.watch(homeProvider);

    ref.listen(homeProvider, (previous, next) {
      if (_mapController != null && next.isLoading != true) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(next.location.latitude, next.location.longitude),
          ),
        );
      }
    });
    return Scaffold(
      body: Stack(
        children: [
          // 1. APPLE MAP LAYER
          AppleMap(
            // minMaxZoomPreference: MinMaxZoomPreference(11, 13),
            // zoomGesturesEnabled: false,
            mapType: MapType.standard,
            onCameraIdle: () async {
              _debounceTimer?.cancel();
              if (_mapController == null) return;

              _debounceTimer = Timer(
                const Duration(milliseconds: 300),
                () async {
                  // 1. Get the screen's boundary coordinates
                  final LatLngBounds bounds =
                      await _mapController!.getVisibleRegion();

                  _currentZoom = (await _mapController!.getZoomLevel())!;
                  // 2. Trigger the fetch logic in your Provider
                  ref
                      .read(eventController.notifier)
                      .getEventsByRadius(radiusInKm: 100);
                  // ref
                  //     .read(eventController.notifier)
                  //     .getEventsByRegion(
                  //       minLat: bounds.southwest.latitude,
                  //       maxLat: bounds.northeast.latitude,
                  //       minLng: bounds.southwest.longitude,
                  //       maxLng: bounds.northeast.longitude,
                  //     );
                },
              );
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(
                position.location.latitude,
                position.location.longitude,
              ),
              zoom: _currentZoom,
              // pitch: 60,
              // heading: 0,
            ),
            annotations: {
              ref.read(homeProvider.notifier).buildUserAnnotations(context),
              ref.read(homeProvider.notifier).buildUserAnnotations1(context),
              ref.read(homeProvider.notifier).buildUserAnnotations2(context),
              ..._annotations, // Your current car/user pointer
              ...ref
                  .read(homeProvider.notifier)
                  .buildAdaptiveMarkers(
                    _currentZoom,
                    events.events,
                    context,
                  ), // Your dynamic event markers
            },
            onMapCreated: (AppleMapController controller) {
              _mapController = controller;
            },
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildExploreLogo(),
                  SizedBox(
                    height: 150.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                    bottom:
                                        MediaQuery.of(
                                          context,
                                        ).viewInsets.bottom,
                                  ),
                                  child: const ProfileBottomCard(),
                                );
                              },
                            );
                          },
                          image:
                              ref
                                  .watch(profileProvider)
                                  .userModel
                                  .profileImages,
                        ),
                        // buildCircularNavIcon(
                        //   Icons.notifications,
                        //   isSmall: true,
                        //   ontap: () {
                        //     context.push('/travel-progress');
                        //   },
                        // ),
                      ],
                    ),
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
                  CupertinoIcons.globe,
                  isSmall: true,
                  ontap: () {
                    context.push('/event-discovery');
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
