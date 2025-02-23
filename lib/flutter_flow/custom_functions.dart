import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

String? joinSelectedDestinations() {
  // Convert the App State variable "selectedDestinations" to a string. Items should be separated by a ", ". It is an app state variable so import something to be able to access the app state variables of the project
  // Import the necessary package to access the app state variables
  // Assuming the app state variable "selectedDestinations" is a List of DestinationsStruct objects
  List<DestinationsStruct> selectedDestinations = [];

  // Convert the List of DestinationsStruct objects to a List of strings
  List<String> destinationNames =
      selectedDestinations.map((destination) => destination.name).toList();

  // Join the List of strings with ", " separator
  String result = destinationNames.join(", ");

  return result;
}
