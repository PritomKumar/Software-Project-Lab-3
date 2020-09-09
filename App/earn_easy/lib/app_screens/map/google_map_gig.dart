import 'dart:collection';

import 'package:earneasy/app_screens/gigs/gig_page.dart';
import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/auth.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../gigs/add_gig_page.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final AuthService _authService = AuthService();

  Set<Marker> _markers = HashSet<Marker>();
  Set<Marker> _myMarkers = HashSet<Marker>();
  Set<Marker> _gigMarkers = HashSet<Marker>();
  bool isTapped = false;
  LatLng tappedPosition;
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  bool isloading = false;
  String userType = "worker";

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
    _position = tappedCamera != null ? tappedCamera : _position;
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
    // print(tappedPoint);
    // showToast(tappedPoint.toString());
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
        infoWindow: InfoWindow(title: "Add Gig", snippet: "Create new gig?"),
      ));
    });
  }

  addMarkersWIthGig(List<Gig> gigList) {
    setState(() {
      _gigMarkers.clear();
      for (int i = 0; i < gigList.length; i++) {
        _gigMarkers.add(Marker(
          markerId: MarkerId(gigList[i].gigId),
          position: LatLng(
              gigList[i].location.latitude, gigList[i].location.longitude),
          draggable: true,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          },
          infoWindow: InfoWindow(
            title: gigList[i].title,
            snippet: gigList[i].description,
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GigPage(
                    gig: gigList[i],
                  ),
                ));
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //List<Gig> gigList = List<Gig>();
    var gigList = Provider.of<List<Gig>>(context);
    var user = Provider.of<UserAccount>(context);
    setState(() {
      if (gigList != null) addMarkersWIthGig(gigList);
      isloading = true;
    });

    if (isloading) {
      userType = user.type;
      return Scaffold(
        drawer: SideDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
        body: StyledToast(
          textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
          backgroundColor: Color(0x99000000),
          borderRadius: BorderRadius.circular(5.0),
          textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
          toastPositions: StyledToastPosition.bottom,
          toastAnimation: StyledToastAnimation.fade,
          reverseAnimation: StyledToastAnimation.fade,
          curve: Curves.fastOutSlowIn,
          reverseCurve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(seconds: 4),
          animDuration: Duration(seconds: 1),
          dismissOtherOnShow: true,
          movingOnWindowChange: true,
          child: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(40.7128, -74.0060),
                  zoom: 14.0,
                ),
                markers: userType == "worker" ? _gigMarkers : _myMarkers,
                onCameraMove: isTapped
                    ? ((_position) => _updatePosition(_position))
                    : null,
                onTap: _handleTap,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
              ),
              userType == "provider"
                  ? Container(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        child: Text("Add GIG"),
                        onPressed: () {
                          tappedPosition != null
                              ? Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return GigAdd(
                                      location: tappedPosition,
                                    );
                                  },
                                ))
                              : Loading();
                        },
                      ),
                    )
                  : Container(
                      alignment: Alignment.bottomCenter,
                    ),
            ],
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}
