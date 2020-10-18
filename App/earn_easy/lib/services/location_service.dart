import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/user_location.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mapToolkit;

class LocationService {
  // Keep track of current Location
  UserLocation _currentLocation;
  Location location = Location();

  // Continuously emit location updates
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } catch (e) {
      print('Could not get the location: $e');
    }

    return _currentLocation;
  }

  double calculateDistanceBetweenTwoPoints(
      LatLng firstPoint, LatLng secondPoint) {
    var distanceBetweenPoints = mapToolkit.SphericalUtil.computeDistanceBetween(
            mapToolkit.LatLng(firstPoint.latitude, firstPoint.longitude),
            mapToolkit.LatLng(secondPoint.latitude, secondPoint.longitude)) /
        1000.0;
    print("Distance =  $distanceBetweenPoints");
    return distanceBetweenPoints;
  }

  double calculateDistanceGigAndUserCurrentLocation(GeoPoint gigLocation) {
    if (currentUserLocation != null) {
      var distanceBetweenPoints =
          mapToolkit.SphericalUtil.computeDistanceBetween(
                  mapToolkit.LatLng(currentUserLocation.latitude,
                      currentUserLocation.longitude),
                  mapToolkit.LatLng(
                      gigLocation.latitude, gigLocation.longitude)) /
              1000.0;
      print("Distance =  $distanceBetweenPoints");
      return distanceBetweenPoints;
    } else {
      return double.maxFinite;
    }
  }
}
