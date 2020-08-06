import 'package:earneasy/app_screens/wrapper.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/auth.dart';

import 'app_screens/home/login_screen.dart';
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Parking App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
      ),
    );
  }
}
