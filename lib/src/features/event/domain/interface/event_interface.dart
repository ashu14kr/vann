import '../../data/models/event_model.dart';

abstract class EventInterface {
  Future<void> createEvent(EventModel event, String evntId);
  Future<List<EventModel>> getEvents();
  Future<List<EventModel>> fetchEventsInRegion({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
  });
  Future<List<EventModel>> fetchEventsNearby({
    required double centerLat,
    required double centerLng,
    required double radiusInKm,
  });
}
