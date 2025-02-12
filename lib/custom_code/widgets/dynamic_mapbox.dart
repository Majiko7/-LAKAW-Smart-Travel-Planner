// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
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
  });

  final double? width;
  final double? height;
  final List<LatLng>? points; // FlutterFlow's LatLng type
  final String accessToken;
  final LatLng? startingPoint; // FlutterFlow's LatLng type
  final double startingZoom;

  @override
  State<DynamicMapbox> createState() => _DynamicMapboxState();
}

class _DynamicMapboxState extends State<DynamicMapbox> {
  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
    addMarkersToMap(widget.points);
  }

  void addMarkersToMap(List<LatLng>? points) {
    if (points != null) {
      for (var point in points) {
        allMarkers.add(
          Marker(
            point: ll.LatLng(
              point.latitude,
              point.longitude,
            ),
            width: 30,
            height: 30,
            child: Icon(
              // Use "child" instead of "builder"
              Icons.location_pin,
              color: Colors.red,
              size: 30,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        // Use "initialCenter" and "initialZoom" for newer versions of flutter_map
        initialCenter: widget.startingPoint != null
            ? ll.LatLng(
                widget.startingPoint!.latitude,
                widget.startingPoint!.longitude,
              )
            : ll.LatLng(13.1333, 123.7333), // Default to Albay
        initialZoom: widget.startingZoom,
      ),
      // Use "children" instead of "layers" for newer versions of flutter_map
      children: [
        TileLayer(
          urlTemplate:
              'https://api.mapbox.com/styles/v1/majiko27/cm6yz30te002y01sra0b4hbu0/tiles/256/{z}/{x}/{y}@2x?access_token=${widget.accessToken}',
        ),
        MarkerLayer(
          markers: allMarkers,
        ),
      ],
    );
  }
}
