import 'package:earneasy/app_screens/search.dart';
import 'package:earneasy/services/geolocator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final locatorService = GeolacatorService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context) => locatorService.getLocation(),
      child: MaterialApp(
        title: 'Earn Easy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Search(),
      ),
    );
  }
}
