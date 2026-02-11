import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class HomeStateModel {
  final Position location;
  final bool isLoading;
  final BitmapDescriptor van;
  final BitmapDescriptor event;

  HomeStateModel({
    required this.location,
    required this.isLoading,
    required this.van,
    required this.event,
  });

  factory HomeStateModel.initial() {
    return HomeStateModel(
      location: Position(
        longitude: 0.0,
        latitude: 0.0,
        timestamp: DateTime.now(),
        accuracy: 0.0,
        altitude: 0.0,
        altitudeAccuracy: 0.0,
        heading: 0.0,
        headingAccuracy: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      ),
      isLoading: true,
      van: BitmapDescriptor.defaultAnnotation,
      event: BitmapDescriptor.defaultAnnotation,
    );
  }

  HomeStateModel copyWith({
    Position? location,
    bool? isLoading,
    BitmapDescriptor? van,
    BitmapDescriptor? event,
  }) {
    return HomeStateModel(
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      van: van ?? this.van,
      event: event ?? this.event,
    );
  }
}
