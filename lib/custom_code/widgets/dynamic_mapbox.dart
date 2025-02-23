// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
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
  });

  final double? width;
  final double? height;
  final List<LatLng>? points;
  final String accessToken;
  final LatLng? startingPoint;
  final double startingZoom;
  final LatLng? currentLocation;

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
    addMarkersToMap(
        widget.points, widget.currentLocation); // ✅ Fixed function call
  }

  void addMarkersToMap(List<LatLng>? points, LatLng? currentLocation) {
    // ✅ Fixed function signature
    List<Marker> markers = [];

    // ✅ Ensure a BLUE marker for the current location
    if (currentLocation != null) {
      print(
          "Adding marker for current location at: ${currentLocation.latitude}, ${currentLocation.longitude}");
      markers.add(
        Marker(
          point: ll.LatLng(currentLocation.latitude, currentLocation.longitude),
          width: 40,
          height: 40,
          child: const Icon(Icons.location_pin, color: Colors.blue, size: 40),
        ),
      );
    } else {
      print("No current location available");
    }

    if (points != null) {
      markers.addAll(points.map((point) => Marker(
            point: ll.LatLng(point.latitude, point.longitude),
            width: 30,
            height: 30,
            child: const Icon(Icons.location_pin, color: Colors.red, size: 30),
          )));
    }

    setState(() {
      allMarkers = markers;
    });
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
  void didUpdateWidget(covariant DynamicMapbox oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentLocation != oldWidget.currentLocation ||
        widget.points != oldWidget.points) {
      print("Detected change in current location, updating markers...");

      setState(() {
        // ✅ Forces a full widget rebuild
        allMarkers = [];
      });

      addMarkersToMap(widget.points, widget.currentLocation);
    }
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }
}
