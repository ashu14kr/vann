import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:van_life/src/features/event/data/models/event_model.dart';

class EventControllerModel {
  final bool isLoading;
  final EventModel eventModel;
  final List<EventModel> events;
  final List<EventModel> myEvents;

  EventControllerModel({
    required this.isLoading,
    required this.eventModel,
    required this.events,
    required this.myEvents,
  });

  factory EventControllerModel.initial() {
    return EventControllerModel(
      isLoading: true,
      eventModel: EventModel(
        eventId: '',
        hostId: '',
        status: 'upcoming',
        title: '',
        description: '',
        locationText: '',
        geo: const GeoPoint(0, 0),
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(hours: 2)),
        price: 0.0,
        capacity: 0,
        vibeTags: [],
        attendeeIds: [],
        attendeeCount: 0,
        coverImage: '',
        galleryImages: [],
        geohash: '',
      ),
      events: [],
      myEvents: [],
    );
  }

  EventControllerModel copyWith({
    bool? isLoading,
    EventModel? eventModel,
    List<EventModel>? events,
    List<EventModel>? myEvents,
  }) {
    return EventControllerModel(
      isLoading: isLoading ?? this.isLoading,
      eventModel: eventModel ?? this.eventModel,
      events: events ?? this.events,
      myEvents: myEvents ?? this.myEvents,
    );
  }
}
