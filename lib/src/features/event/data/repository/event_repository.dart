import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:van_life/src/features/event/data/models/event_model.dart';
import 'package:van_life/src/features/event/domain/interface/event_interface.dart';

class EventRepository implements EventInterface {
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  EventRepository({required this.db, required this.auth});

  @override
  Future<void> createEvent(EventModel event, String evntId) async {
    try {
      await db.collection('events').doc(evntId).set(event.toMap());
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<List<EventModel>> getEvents() async {
    try {
      // 1. Fetch the collection from Firestore
      final querySnapshot =
          await db
              .collection('events')
              .where('attendeeIds', arrayContains: auth.currentUser!.uid)
              .orderBy('startDate', descending: false)
              .get();

      // 2. Map the documents to your EventModel
      return querySnapshot.docs.map((doc) {
        return EventModel.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching events: $e");
      throw Exception("Failed to fetch events: $e");
    }
  }

  @override
  Future<List<EventModel>> fetchEventsInRegion({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  }) async {
    try {
      final querySnapshot =
          await db
              .collection('events')
              // Filter Latitude
              .where('lat', isGreaterThanOrEqualTo: minLat)
              .where('lat', isLessThanOrEqualTo: maxLat)
              .where('lng', isGreaterThanOrEqualTo: minLng)
              .where('lng', isLessThanOrEqualTo: maxLng)
              .get();

      final newEvents =
          querySnapshot.docs
              .map((doc) => EventModel.fromMap(doc.data(), doc.id))
              .toList();

      return newEvents;
    } catch (e) {
      print("Firestore Index Error: $e");
      return [];
    }
  }

  @override
  Future<List<EventModel>> fetchEventsNearby({
    required double centerLat,
    required double centerLng,
    required double radiusInKm,
  }) async {
    try {
      final geoHasher = GeoHasher();
      String userHash = geoHasher.encode(centerLng, centerLat);

      // 2. Determine how many characters to match based on the radius
      // 3 chars covers ~150km, 4 chars covers ~20km, 5 chars covers ~5km
      int precision = 3;
      if (radiusInKm <= 10) {
        precision = 5;
      } else if (radiusInKm <= 50) {
        precision = 4;
      }

      // 3. Truncate the hash to create the search "prefix"
      String searchPrefix = userHash.substring(0, precision);

      // 4. Query Firestore for hashes that start with that prefix
      final querySnapshot =
          await db
              .collection('events')
              .orderBy('geohash')
              .startAt([searchPrefix])
              .endAt(['$searchPrefix\uf8ff'])
              .limit(50)
              .get();

      // 5. Map to models and do a final fine-tuned distance check
      final nearbyEvents =
          querySnapshot.docs
              .map((doc) => EventModel.fromMap(doc.data(), doc.id))
              .where((event) {
                double distance = _calculateDistance(
                  centerLat,
                  centerLng,
                  event.geo.latitude,
                  event.geo.longitude,
                );
                return distance <= radiusInKm;
              })
              .toList();

      return nearbyEvents;
    } catch (e) {
      print("Geohash Query Error: $e");
      return [];
    }
  }

  //HELPER FUNCTION TO CALCULATE DISTANCE BETWEEN TWO LAT/LNG POINTS
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    var p = 0.017453292519943295;
    var a =
        0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
