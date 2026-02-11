import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String eventId;
  final String hostId;
  final String status;
  final String title;
  final String description;
  final String locationText;
  final GeoPoint geo;
  final String geohash;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final int capacity;
  final List<String> vibeTags;
  final List<String> attendeeIds;
  final int attendeeCount;
  final String coverImage;
  final List<String> galleryImages;

  EventModel({
    required this.eventId,
    required this.hostId,
    required this.status,
    required this.title,
    required this.description,
    required this.locationText,
    required this.geo,
    required this.geohash,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.capacity,
    required this.vibeTags,
    required this.attendeeIds,
    required this.attendeeCount,
    required this.coverImage,
    required this.galleryImages,
  });

  EventModel copyWith({
    String? eventId,
    String? hostId,
    String? status,
    String? title,
    String? description,
    String? locationText,
    GeoPoint? geo,
    String? geohash,
    DateTime? startDate,
    DateTime? endDate,
    double? price,
    int? capacity,
    List<String>? vibeTags,
    List<String>? attendeeIds,
    int? attendeeCount,
    String? coverImage,
    List<String>? galleryImages,
  }) {
    return EventModel(
      eventId: eventId ?? this.eventId,
      hostId: hostId ?? this.hostId,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      locationText: locationText ?? this.locationText,
      geo: geo ?? this.geo,
      geohash: geohash ?? this.geohash,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      capacity: capacity ?? this.capacity,
      vibeTags: vibeTags ?? this.vibeTags,
      attendeeIds: attendeeIds ?? this.attendeeIds,
      attendeeCount: attendeeCount ?? this.attendeeCount,
      coverImage: coverImage ?? this.coverImage,
      galleryImages: galleryImages ?? this.galleryImages,
    );
  }

  // Convert a Firestore Document (Map) into a Dart Object (GET)
  factory EventModel.fromMap(Map<String, dynamic> map, String id) {
    return EventModel(
      eventId: id,
      hostId: map['hostId'] ?? '',
      status: map['status'] ?? 'upcoming',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      locationText: map['locationText'] ?? '',
      geo: map['geo'] ?? const GeoPoint(0, 0),
      geohash: map['geohash'] ?? '',
      // Firebase Timestamps must be converted to Dart DateTime
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      price: (map['price'] ?? 0).toDouble(),
      capacity: map['capacity'] ?? 0,
      vibeTags: List<String>.from(map['vibeTags'] ?? []),
      attendeeIds: List<String>.from(map['attendeeIds'] ?? []),
      attendeeCount: map['attendeeCount'] ?? 0,
      coverImage: map['coverImage'] ?? '',
      galleryImages: List<String>.from(map['galleryImages'] ?? []),
    );
  }

  // Convert a Dart Object into a Map for Firestore (POST/PUT)
  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'hostId': hostId,
      'status': status,
      'title': title,
      'description': description,
      'locationText': locationText,
      'geo': geo,
      'geohash': geohash,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'price': price,
      'capacity': capacity,
      'vibeTags': vibeTags,
      'attendeeIds': attendeeIds,
      'attendeeCount': attendeeCount,
      'coverImage': coverImage,
      'galleryImages': galleryImages,
    };
  }
}
