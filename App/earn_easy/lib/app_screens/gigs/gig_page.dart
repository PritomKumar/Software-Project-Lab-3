import 'dart:collection';

import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'add_gig_page.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final AuthService _authService = AuthService();

  Set<Marker> _markers = HashSet<Marker>();
  Set<Marker> _myMarkers = HashSet<Marker>();
  bool isTapped = false;
  LatLng tappedPosition;
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

  void _updatePosition(CameraPosition _position) {
    CameraPosition realCamera = _position;
    CameraPosition tappedCamera = CameraPosition(target: tappedPosition);
    _position = tappedCamera != null ?  tappedCamera :  _position ;
    print(
        'inside updatePosition ${_position.target.latitude} ${_position.target.longitude}');
    Marker marker = _myMarkers.firstWhere(
        (p) => p.markerId == MarkerId('marker_2'),
        orElse: () => null);

    _myMarkers.remove(marker);
    _myMarkers.add(
      Marker(
        markerId: MarkerId('marker_2'),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
      ),
    );
    setState(() {});
  }

  _handleTap(LatLng tappedPoint) {
    print(tappedPoint);
    setState(() {
      tappedPosition = tappedPoint;
      isTapped = true;
      _myMarkers.clear();
      _myMarkers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        onDragEnd: (dragEndPosition) {
          print(dragEndPosition);
        },
        infoWindow: InfoWindow(
          title: "Add Marker",
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return GigAdd();
        },
      ),
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
            markers: _myMarkers,
            onCameraMove: isTapped ? ((_position) => _updatePosition(_position)) : null,
            onTap: _handleTap,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
          ),
        ],
      ),
    );
  }
}
