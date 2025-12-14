part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {
  const LocationInitial();
}

class LocationLoading extends LocationState {
  const LocationLoading();
}

class LocationLoaded extends LocationState {
  final LatLng location;

  const LocationLoaded({required this.location});

  @override
  List<Object?> get props => [location];
}

class LocationError extends LocationState {
  final LatLng defaultLocation;

  const LocationError({required this.defaultLocation});

  @override
  List<Object?> get props => [defaultLocation];
}

