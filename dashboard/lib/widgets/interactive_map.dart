import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:transport_dashboard/global/environment.dart';

class InteractiveMap extends StatefulWidget {
  final Size size;
  final Function(LatLng)? onMapTap;
  final Function(LatLng)? onMapMoved; // Callback cuando el mapa se mueve
  final List<LatLng>? markers;
  final LatLng? initialCenter;

  const InteractiveMap({
    super.key,
    required this.size,
    this.onMapTap,
    this.onMapMoved,
    this.markers,
    this.initialCenter,
  });

  @override
  State<InteractiveMap> createState() => _InteractiveMapState();
}

class _InteractiveMapState extends State<InteractiveMap> {
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    // Escuchar cambios en la posición del mapa
    _mapController.mapEventStream.listen((event) {
      if (event is MapEventMoveEnd && widget.onMapMoved != null) {
        // Obtener el centro actual del mapa cuando termina el movimiento
        final center = _mapController.camera.center;
        widget.onMapMoved?.call(center);
      }
    });
  }

  @override
  void didUpdateWidget(InteractiveMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si cambia el initialCenter, mover el mapa
    if (widget.initialCenter != oldWidget.initialCenter && 
        widget.initialCenter != null) {
      _mapController.move(widget.initialCenter!, _mapController.camera.zoom);
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapboxToken = Environment.getMapboxToken();
    final center = widget.initialCenter ?? const LatLng(-27.3254869, -58.65748235);
    const initialZoom = 12.0;
    const mapboxStyle = 'mapbox/streets-v11';

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: center,
        initialZoom: initialZoom,
        onTap: (tapPosition, point) {
          widget.onMapTap?.call(point);
        },
      ),
      children: [
        TileLayer(
          urlTemplate: mapboxToken.isNotEmpty
              ? 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}'
              : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          additionalOptions: mapboxToken.isNotEmpty
              ? {
                  'id': mapboxStyle,
                  'accessToken': mapboxToken,
                }
              : {},
          userAgentPackageName: 'com.example.transport_dashboard',
          maxZoom: 18,
        ),
        if (widget.markers != null && widget.markers!.isNotEmpty)
          MarkerLayer(
            markers: widget.markers!.map((marker) {
              return Marker(
                point: marker,
                width: 30,
                height: 30,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 30,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}

