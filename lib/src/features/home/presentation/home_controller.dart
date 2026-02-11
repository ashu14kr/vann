import 'dart:ui' as ui;

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:van_life/src/features/home/data/models/home_state_model.dart';
import 'package:van_life/src/features/profile/presentation/provider/profile_provider.dart';

import '../../../core/services/location_service.dart';
import '../../event/data/models/event_model.dart';
import '../../event/presentation/event_detail_bottomSheet.dart';

class HomeController extends Notifier<HomeStateModel> {
  @override
  HomeStateModel build() {
    Future.microtask(() => getCurrentPosition());
    return HomeStateModel.initial();
  }

  getCurrentPosition() async {
    final location = await LocationService().getCurrentLocation();
    await initMarkers();
    state = state.copyWith(location: location, isLoading: false);
    // List<Placemark> placemarks = await placemarkFromCoordinates(
    //   state.location.latitude,
    //   state.location.longitude,
    // );
    // Placemark place = placemarks[0];
    // print(place.country);
  }

  Set<Annotation> buildAdaptiveMarkers(
    double currentZoom,
    List<EventModel> allEvents,
    BuildContext context,
  ) {
    print(currentZoom);
    // STAGE 1: Zoomed out (World/Country View)
    if (currentZoom < 7) {
      // Return empty or return a single "Heatmap" style annotation
      return {};
    }

    // STAGE 2: Mid Zoom (City View)
    if (currentZoom < 12) {
      // This is where you would return "Clusters"
      // (e.g., one big circle that says "10 events here")
      return {};
      //_buildClusters(allEvents);
    }

    // STAGE 3: Zoomed In (Street View)
    // Show the actual van/dating profiles
    return allEvents
        .map(
          (e) => Annotation(
            annotationId: AnnotationId(e.eventId),
            position: LatLng(e.geo.latitude, e.geo.longitude),
            icon: state.event ?? BitmapDescriptor.defaultAnnotation,
            onTap: () => showEventDetail(context, e),
          ),
        )
        .toSet();
  }

  Future<void> initMarkers() async {
    final userIcon = await resizeMarker('assets/images/van_marker.png', 300);
    final eventIcon = await resizeMarker('assets/images/event_marker.png', 300);
    final bigEventIcon = await resizeMarker('assets/images/big_event.png', 300);
    state = state.copyWith(van: userIcon, event: bigEventIcon);
  }

  Future<BitmapDescriptor> resizeMarker(String assetPath, int width) async {
    final data = await rootBundle.load(assetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    final frame = await codec.getNextFrame();
    final bytes = await frame.image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  Annotation buildUserAnnotations(BuildContext context) {
    return Annotation(
      annotationId: AnnotationId('me'),
      position: LatLng(state.location.latitude, state.location.longitude),
      icon: state.van ?? BitmapDescriptor.defaultAnnotation,
      onTap: () => EasyLoading.showInfo('ITS YOU'),
    );
  }

  Annotation buildUserAnnotations1(BuildContext context) {
    return Annotation(
      annotationId: AnnotationId('me1'),
      position: LatLng(23.367059219433905, 85.31054551122169),
      icon: state.van ?? BitmapDescriptor.defaultAnnotation,
      onTap: () => EasyLoading.showInfo('ITS YOU'),
    );
  }

  Annotation buildUserAnnotations2(BuildContext context) {
    return Annotation(
      annotationId: AnnotationId('me2'),
      position: LatLng(23.370722953720083, 85.30320095238666),
      icon: state.van ?? BitmapDescriptor.defaultAnnotation,
      onTap: () => EasyLoading.showInfo('ITS YOU'),
    );
  }

  // Set<Annotation> buildEventAnnotations(
  //   List<EventModel> events,
  //   BuildContext context,
  // ) {
  //   final nearbyEvents =
  //       events.where((event) {
  //         double distanceInMeters = Geolocator.distanceBetween(
  //           state.location.latitude,
  //           state.location.longitude,
  //           event.geo.latitude,
  //           event.geo.longitude,
  //         );
  //         // 100km = 100,000 meters
  //         return distanceInMeters <= 5000000;
  //       }).toList();
  //   return nearbyEvents.map((event) {
  //     return Annotation(
  //       annotationId: AnnotationId(event.eventId),
  //       position: LatLng(event.geo.latitude, event.geo.longitude),
  //       icon: state.event ?? BitmapDescriptor.defaultAnnotation,
  //       onTap: () => showEventDetail(context, event),
  //     );
  //   }).toSet();
  // }

  void showEventDetail(BuildContext context, EventModel event) async {
    await ref.read(profileProvider.notifier).getUsers(ids: event.attendeeIds);
    if (!context.mounted) return;
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
          child: EventDetailBottomSheet(eventModel: event),
        );
      },
    );
  }
}
