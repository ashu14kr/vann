import 'dart:io';

import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:van_life/src/features/home/presentation/provider/home_provider.dart';
import 'package:van_life/src/features/profile/presentation/provider/profile_provider.dart';
import 'package:van_life/src/share/providers/shared_providers.dart';

import '../data/models/event_controller_model.dart';
import 'provider/provider.dart';

class EventController extends Notifier<EventControllerModel> {
  @override
  EventControllerModel build() {
    Future.microtask(() => getEvents());
    return EventControllerModel.initial();
  }

  Future<void> addEvent({
    required String title,
    required String description,
  }) async {
    try {
      EasyLoading.show();
      final repository = ref.read(eventRepositoryProvider);
      final auth = ref.read(firebaseAuthProvider);
      final firestore = ref.read(firestoreProvider);
      final user = ref.read(profileProvider.notifier);

      final String eventId = firestore.collection('events').doc().id;
      state = state.copyWith(
        eventModel: state.eventModel.copyWith(
          hostId: auth.currentUser!.uid,
          eventId: eventId,
          title: title,
          description: description,
          attendeeIds: [auth.currentUser!.uid],
          attendeeCount: 1,
          coverImage:
              "https://i.pinimg.com/1200x/03/1f/55/031f550c198fc8b73e9d1a0139f0f0e1.jpg",
        ),
      );
      await repository.createEvent(state.eventModel, eventId);
      await user.hostedEvent(auth.currentUser!.uid, eventId);
      state = state.copyWith(events: [...state.events, state.eventModel]);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      rethrow;
    }
  }

  Future<void> getEvents() async {
    try {
      final repository = ref.read(eventRepositoryProvider);
      final events = await repository.getEvents();
      state = state.copyWith(myEvents: events, isLoading: false);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> getEventsByRadius({required double radiusInKm}) async {
    try {
      final repository = ref.read(eventRepositoryProvider);
      final homeContro = ref.read(homeProvider);
      final events = await repository.fetchEventsNearby(
        centerLat: homeContro.location.latitude,
        centerLng: homeContro.location.longitude,
        radiusInKm: radiusInKm,
      );
      print("events: ${events.length}");
      state = state.copyWith(events: events, isLoading: false);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<void> getEventsByRegion({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) async {
    try {
      final repository = ref.read(eventRepositoryProvider);
      final events = await repository.fetchEventsInRegion(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
      );
      print("events: ${events.length}");
      state = state.copyWith(events: events, isLoading: false);
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  void updateLocation({required LatLng latLng, required String address}) {
    final geoHasher = GeoHasher();
    final String hash = geoHasher.encode(latLng.longitude, latLng.latitude);
    print(hash);
    state = state.copyWith(
      eventModel: state.eventModel.copyWith(
        locationText: address,
        geo: GeoPoint(latLng.latitude, latLng.longitude),
        geohash: hash,
      ),
    );
  }

  void updateStartDate(DateTime newDate) {
    state = state.copyWith(
      eventModel: state.eventModel.copyWith(startDate: newDate),
    );
  }

  void updateEndDate(DateTime newDate) {
    state = state.copyWith(
      eventModel: state.eventModel.copyWith(endDate: newDate),
    );
  }

  void updateCapacity(int capacity) {
    state = state.copyWith(
      eventModel: state.eventModel.copyWith(capacity: capacity),
    );
  }

  void updateVibeList(List<String> vibes) {
    state = state.copyWith(
      eventModel: state.eventModel.copyWith(vibeTags: vibes),
    );
  }

  String getEventTimeLine(DateTime start, DateTime end) {
    final DateFormat full = DateFormat('EEE, d MMM');
    final DateFormat time = DateFormat('h:mm a');

    if (start.day == end.day) {
      return "${full.format(start)} • ${time.format(start).replaceAll(' AM', '').replaceAll(' PM', '')} – ${time.format(end)}";
    } else {
      return "${DateFormat('d MMM, h:mm a').format(start)} – ${DateFormat('d MMM, h:mm a').format(end)}";
    }
  }

  Future<void> openMap(double lat, double lng) async {
    // Use the 'query' parameter with coordinates to force a pin drop
    final String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    final String appleUrl = "https://maps.apple.com/?q=$lat,$lng";

    if (Platform.isAndroid) {
      final Uri uri = Uri.parse(googleUrl);
      // mode: LaunchMode.externalApplication is the key to bypass the browser
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } else if (Platform.isIOS) {
      // Try Google Maps first if the user has it, then fallback to Apple Maps
      final Uri googleUri = Uri.parse(googleUrl);
      final Uri appleUri = Uri.parse(appleUrl);

      if (await canLaunchUrl(googleUri)) {
        await launchUrl(googleUri, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(appleUri)) {
        await launchUrl(appleUri, mode: LaunchMode.externalApplication);
      }
    }
  }
}
