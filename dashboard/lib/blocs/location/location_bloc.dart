import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationInitial()) {
    on<GetCurrentLocationEvent>(_getCurrentLocation);
  }

  Future<void> _getCurrentLocation(
    GetCurrentLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationLoading());

    try {
      // En Web, los permisos se solicitan automáticamente al obtener la ubicación
      // El navegador mostrará el diálogo de permisos cuando se llame a getCurrentPosition
      if (kIsWeb) {
        try {
          // Intentar obtener la ubicación directamente
          // El navegador pedirá permisos automáticamente si no los tienes
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            timeLimit: const Duration(seconds: 10),
          );

          emit(LocationLoaded(
            location: LatLng(position.latitude, position.longitude),
          ));
          return;
        } catch (e) {
          // Si el usuario niega los permisos o hay un error, usar ubicación por defecto
          emit(const LocationError(
            defaultLocation: LatLng(-27.3254869, -58.65748235),
          ));
          return;
        }
      }

      // Para Android/iOS: seguir el flujo normal de verificación de permisos
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(const LocationError(
          defaultLocation: LatLng(-27.3254869, -58.65748235),
        ));
        return;
      }

      // Verificar permisos
      LocationPermission permission = await Geolocator.checkPermission();
      
      // Si está denegado permanentemente, no podemos hacer nada
      if (permission == LocationPermission.deniedForever) {
        emit(const LocationError(
          defaultLocation: LatLng(-27.3254869, -58.65748235),
        ));
        return;
      }
      
      // Si está denegado, solicitar permisos
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        
        // Verificar el resultado después de solicitar
        if (permission == LocationPermission.denied || 
            permission == LocationPermission.deniedForever) {
          emit(const LocationError(
            defaultLocation: LatLng(-27.3254869, -58.65748235),
          ));
          return;
        }
      }

      // Verificar que el permiso esté concedido
      if (permission != LocationPermission.whileInUse && 
          permission != LocationPermission.always) {
        emit(const LocationError(
          defaultLocation: LatLng(-27.3254869, -58.65748235),
        ));
        return;
      }

      // Obtener la ubicación actual
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      emit(LocationLoaded(
        location: LatLng(position.latitude, position.longitude),
      ));
    } catch (e) {
      // Si hay un error, usar ubicación por defecto
      emit(const LocationError(
        defaultLocation: LatLng(-27.3254869, -58.65748235),
      ));
    }
  }
}

