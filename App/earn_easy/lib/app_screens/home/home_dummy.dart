import 'dart:collection';

import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/app_screens/notification/notification_page.dart';
import 'package:earneasy/app_screens/profile/profile_page.dart';
import 'package:earneasy/app_screens/setting/setting_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:earneasy/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Gigs(),
    );
  }
}

class Gigs extends StatefulWidget {
  @override
  _GigsState createState() => _GigsState();
}

class _GigsState extends State<Gigs> {
  final AuthService _authService = AuthService();

  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setMarkerIcon();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/money_icon.jpg");
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("0"),
          position: LatLng(23.8103, 90.4125),
          infoWindow: InfoWindow(
            title: "উপার্জন",
            snippet: "একটি উত্তেজনাপূর্ণ জায়গা",
          ),
          icon: _markerIcon,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Logout"),
            onPressed: () async {
              await _authService.signOut();
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(23.8103, 90.4125),
              zoom: 12,
            ),
            markers: _markers,
          ),
        ],
      ),
    );
  }
}
