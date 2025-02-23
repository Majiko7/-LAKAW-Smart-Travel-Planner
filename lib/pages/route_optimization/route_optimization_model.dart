import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'route_optimization_widget.dart' show RouteOptimizationWidget;
import 'package:flutter/material.dart';

class RouteOptimizationModel extends FlutterFlowModel<RouteOptimizationWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getCurrentLocation] action in RouteOptimization widget.
  LatLng? currentLocation;
  // State field(s) for Checkbox widget.
  Map<DestinationsRow, bool> checkboxValueMap = {};
  List<DestinationsRow> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
