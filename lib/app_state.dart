import 'package:flutter/material.dart';
import 'backend/supabase/supabase.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxqaHBlam9hbHJvZ2NoZ2t6c2ZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzY5MTYwNzAsImV4cCI6MjA1MjQ5MjA3MH0.j0DrlSVYNp2_vAtXFy47X2gFTkItz6gZQYTnUgmste0';
  String get apiKey => _apiKey;
  set apiKey(String value) {
    _apiKey = value;
  }

  List<LatLng> _destinations = [
    LatLng(13.1659984, 123.701149),
    LatLng(13.1605556, 123.7291667),
    LatLng(13.2260225, 123.5546708),
    LatLng(13.3524479, 123.6212622)
  ];
  List<LatLng> get destinations => _destinations;
  set destinations(List<LatLng> value) {
    _destinations = value;
  }

  void addToDestinations(LatLng value) {
    destinations.add(value);
  }

  void removeFromDestinations(LatLng value) {
    destinations.remove(value);
  }

  void removeAtIndexFromDestinations(int index) {
    destinations.removeAt(index);
  }

  void updateDestinationsAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    destinations[index] = updateFn(_destinations[index]);
  }

  void insertAtIndexInDestinations(int index, LatLng value) {
    destinations.insert(index, value);
  }
}
