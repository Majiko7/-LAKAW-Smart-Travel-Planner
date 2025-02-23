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
    LatLng(13.3524479, 123.6212622),
    LatLng(0.0, 0.0)
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

  LatLng? _currentLocation;
  LatLng? get currentLocation => _currentLocation;
  set currentLocation(LatLng? value) {
    _currentLocation = value;
  }

  /// loading of Mapbox Map in route optimization page
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
  }

  /// List of chosen destinations
  List<String> _selectedDestinations = [];
  List<String> get selectedDestinations => _selectedDestinations;
  set selectedDestinations(List<String> value) {
    _selectedDestinations = value;
  }

  void addToSelectedDestinations(String value) {
    selectedDestinations.add(value);
  }

  void removeFromSelectedDestinations(String value) {
    selectedDestinations.remove(value);
  }

  void removeAtIndexFromSelectedDestinations(int index) {
    selectedDestinations.removeAt(index);
  }

  void updateSelectedDestinationsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    selectedDestinations[index] = updateFn(_selectedDestinations[index]);
  }

  void insertAtIndexInSelectedDestinations(int index, String value) {
    selectedDestinations.insert(index, value);
  }

  /// controls visibility of list view in Route Optimization Page
  bool _isListVisibleROpt = false;
  bool get isListVisibleROpt => _isListVisibleROpt;
  set isListVisibleROpt(bool value) {
    _isListVisibleROpt = value;
  }

  /// latitudes of the selected destinations in the Route Optimization page
  List<double> _selectedLatitude = [];
  List<double> get selectedLatitude => _selectedLatitude;
  set selectedLatitude(List<double> value) {
    _selectedLatitude = value;
  }

  void addToSelectedLatitude(double value) {
    selectedLatitude.add(value);
  }

  void removeFromSelectedLatitude(double value) {
    selectedLatitude.remove(value);
  }

  void removeAtIndexFromSelectedLatitude(int index) {
    selectedLatitude.removeAt(index);
  }

  void updateSelectedLatitudeAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    selectedLatitude[index] = updateFn(_selectedLatitude[index]);
  }

  void insertAtIndexInSelectedLatitude(int index, double value) {
    selectedLatitude.insert(index, value);
  }

  /// longitude of selected destinations in the RouteOptimizationPage
  List<double> _selectedLongitude = [];
  List<double> get selectedLongitude => _selectedLongitude;
  set selectedLongitude(List<double> value) {
    _selectedLongitude = value;
  }

  void addToSelectedLongitude(double value) {
    selectedLongitude.add(value);
  }

  void removeFromSelectedLongitude(double value) {
    selectedLongitude.remove(value);
  }

  void removeAtIndexFromSelectedLongitude(int index) {
    selectedLongitude.removeAt(index);
  }

  void updateSelectedLongitudeAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    selectedLongitude[index] = updateFn(_selectedLongitude[index]);
  }

  void insertAtIndexInSelectedLongitude(int index, double value) {
    selectedLongitude.insert(index, value);
  }
}
