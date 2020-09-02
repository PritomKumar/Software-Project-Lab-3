import 'dart:collection';

import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gigs extends StatefulWidget {
  @override
  _GigsState createState() => _GigsState();
}

class _GigsState extends State<Gigs> {
  final AuthService _authService = AuthService();

  Set<Marker> _markers = HashSet<Marker>();
  Set<Marker> _myMarkers = HashSet<Marker>();
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

  _handleTap(LatLng tappedPoint){
    setState(() {
      _myMarkers.clear();
      _myMarkers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        onDragEnd: (dragEndPosition){
          print(dragEndPosition);
        }
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue[300],
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
              target: LatLng(40.7128, -74.0060),
              zoom: 14.0,
            ),
            markers: _markers,
            onTap: _handleTap,
          ),
        ],
      ),
    );
  }
}