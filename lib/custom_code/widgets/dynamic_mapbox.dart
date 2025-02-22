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

    // ✅ Add starting point marker if available
    if (widget.currentLocation != null) {
      allMarkers.add(
        Marker(
          point: ll.LatLng(widget.currentLocation!.latitude,
              widget.currentLocation!.longitude),
          width: 40,
          height: 40,
          child: const Icon(Icons.my_location, color: Colors.blue, size: 40),
        ),
      );
    }

    addMarkersToMap(widget.points);
  }

  void addMarkersToMap(List<LatLng>? points) {
    if (points != null) {
      setState(() {
        allMarkers = points
            .map((point) => Marker(
                  point: ll.LatLng(point.latitude, point.longitude),
                  width: 30,
                  height: 30,
                  child: const Icon(Icons.location_pin,
                      color: Colors.red, size: 30),
                ))
            .toList();
      });
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
          initialCenter: widget.currentLocation !=
                  null // ✅ Set initial center to current location
              ? ll.LatLng(widget.currentLocation!.latitude,
                  widget.currentLocation!.longitude)
              : widget.startingPoint != null
                  ? ll.LatLng(widget.startingPoint!.latitude,
                      widget.startingPoint!.longitude)
                  : const ll.LatLng(13.1333, 123.7333),
          initialZoom: widget.startingZoom,
          interactionOptions: const InteractionOptions(
            enableScrollWheel: true,
            enableMultiFingerGestureRace: true,
          ),
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
