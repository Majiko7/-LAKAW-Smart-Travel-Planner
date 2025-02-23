// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;

class DynamicMapbox extends StatefulWidget {
  const DynamicMapbox({
    super.key,
    this.width,
    this.height,
    this.points,
    required this.accessToken,
    this.startingPoint,
    required this.startingZoom,
    this.currentLocation,
    required this.selectedLatitude,
    required this.selectedLongitude,
  });

  final double? width;
  final double? height;
  final List<LatLng>? points;
  final String accessToken;
  final LatLng? startingPoint;
  final double startingZoom;
  final LatLng? currentLocation;
  final List<double> selectedLatitude;
  final List<double> selectedLongitude;

  @override
  State<DynamicMapbox> createState() => _DynamicMapboxWidgetState();
}

class _DynamicMapboxWidgetState extends State<DynamicMapbox> {
  List<Marker> allMarkers = [];
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    refreshMarkers(); // Call this once when the widget initializes
  }

  void refreshMarkers() {
    print("🔥 Refreshing markers with:");
    print("📌 Selected Latitudes: ${widget.selectedLatitude}");
    print("📌 Selected Longitudes: ${widget.selectedLongitude}");

    List<Marker> markers = [];

    // Add BLUE marker for the current location
    if (widget.currentLocation != null) {
      markers.add(
        Marker(
          point: ll.LatLng(widget.currentLocation!.latitude,
              widget.currentLocation!.longitude),
          width: 40,
          height: 40,
          child: const Icon(Icons.location_pin, color: Colors.blue, size: 40),
        ),
      );
    }

    // Add RED markers for selected locations
    for (int i = 0; i < widget.selectedLatitude.length; i++) {
      double lat = widget.selectedLatitude[i];
      double lon = widget.selectedLongitude[i];

      if (lat.isFinite && lon.isFinite) {
        markers.add(
          Marker(
            point: ll.LatLng(lat, lon),
            width: 30,
            height: 30,
            child: const Icon(Icons.location_pin, color: Colors.red, size: 30),
          ),
        );
      }
    }

    setState(() {
      allMarkers = markers;
      print("✅ Markers Updated! Total markers: ${allMarkers.length}");
    });
  }

  @override
  void didUpdateWidget(covariant DynamicMapbox oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedLatitude != oldWidget.selectedLatitude ||
        widget.selectedLongitude != oldWidget.selectedLongitude) {
      print("🔄 Widget Updated! Rebuilding Markers...");
      refreshMarkers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height ?? MediaQuery.of(context).size.height,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: widget.currentLocation != null
              ? ll.LatLng(widget.currentLocation!.latitude,
                  widget.currentLocation!.longitude)
              : widget.startingPoint != null
                  ? ll.LatLng(widget.startingPoint!.latitude,
                      widget.startingPoint!.longitude)
                  : const ll.LatLng(13.1333, 123.7333),
          initialZoom: widget.startingZoom,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=${widget.accessToken}',
            additionalOptions: {
              'accessToken': widget.accessToken,
            },
          ),
          MarkerLayer(
            markers: allMarkers,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
