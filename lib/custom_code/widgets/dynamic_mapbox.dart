// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/flutter_flow/flutter_flow_util.dart'; // Keep this for LatLng
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;

class DynamicMapboxWidget extends StatefulWidget {
  const DynamicMapboxWidget({
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
  final List<LatLng>? points;
  final String accessToken;
  final LatLng? startingPoint;
  final double startingZoom;

  @override
  State<DynamicMapboxWidget> createState() => _DynamicMapboxWidgetState();
}

class _DynamicMapboxWidgetState extends State<DynamicMapboxWidget> {
  List<Marker> allMarkers = [];
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
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
            child: const Icon(
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
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height ?? MediaQuery.of(context).size.height,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          initialCenter: widget.startingPoint != null
              ? ll.LatLng(
                  widget.startingPoint!.latitude,
                  widget.startingPoint!.longitude,
                )
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
                'https://api.mapbox.com/styles/v1/majiko27/cm6yz30te002y01sra0b4hbu0/tiles/256/{z}/{x}/{y}@2x?access_token=${widget.accessToken}',
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
