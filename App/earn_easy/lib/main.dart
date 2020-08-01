import 'package:earneasy/app_screens/login_screen.dart';
import 'package:earneasy/app_screens/search.dart';
import 'package:earneasy/app_screens/search_screen_loader.dart';
import 'package:earneasy/app_screens/splash_screen.dart';
import 'package:earneasy/services/geolocator_service.dart';
import 'package:earneasy/services/places_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'models/place.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    ),
  );
}
