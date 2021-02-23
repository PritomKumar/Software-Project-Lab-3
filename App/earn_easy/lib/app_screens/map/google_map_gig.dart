import 'dart:collection';
import 'dart:math' as Math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/app_screens/gigs/gig_page.dart';
import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/models/user_location.dart';
import 'package:earneasy/services/auth.dart';
import 'package:earneasy/services/location_service.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../gigs/add_gig_page.dart';
import 'map_list_view.dart';

class GoogleMaps extends StatefulWidget {
  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  final AuthService _authService = AuthService();

  Set<Marker> _markers = HashSet<Marker>();
  Set<Marker> _myMarkers = HashSet<Marker>();
  Set<Marker> _gigMarkers = HashSet<Marker>();

  List<Gig> _gigList = List<Gig>();
  List<GigMini> _availableGigList = List<GigMini>();
  UserAccount _user;

  bool _isTapped = false;
  LatLng _tappedPosition;
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  bool _isLoading = false;
  String userType = "worker";
  int _bottomNavigationBarIndex = 0;
  LatLng _currentLocation;
  LatLng _cameraPositionCenter = LatLng(12.960632, 77.641603);
  double radiusLevelCurrent = 2.327804656243825;
  Geoflutterfire geo;
  Stream<List<DocumentSnapshot>> stream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setMarkerIcon();
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    _currentLocation = await _getCurrentLocationFromUserLocation();
    _cameraPositionCenter = _currentLocation;
    geo = Geoflutterfire();
    await _animateCameraToCurrentLocation();
    await _startQuery();
    _calculateDistanceForAllGigs();
    _createAvailableGigMiniListFromGigList();
    _calculateDistanceForAllGigMiniInUserData();
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

  Future _startQuery() async {
    print("_cameraPositionCenter = ${_cameraPositionCenter.toJson()}");
    GeoFirePoint center = geo.point(
        latitude: _cameraPositionCenter.latitude,
        longitude: _cameraPositionCenter.longitude);

    stream = geo.collection(collectionRef: fireStoreGigsRef).within(
          center: center,
          radius: radiusLevelCurrent,
          field: 'location',
          strictMode: true,
        );

    LatLng location = await _getCurrentLocationFromUserLocation();

    // stream.map((List<DocumentSnapshot> documentList) {
    //   documentList.forEach((DocumentSnapshot document) {
    //     _gigList.add(Gig.fromMap(document.data()));
    //     print("_gigList Size  = ${_gigList.length}");
    //   });
    // });

    // var data = await stream.last;
    // print("data = ${data.length}");
    //
    // data.forEach((DocumentSnapshot document) {
    //   _gigList.add(Gig.fromMap(document.data()));
    //   print("_gigList Size  = ${_gigList.length}");
    // });

    // stream.listen((List<DocumentSnapshot> documentList) {
    //   print("documentList = ${documentList.length}");
    //   documentList.forEach((DocumentSnapshot document) {
    //     _gigList.add(Gig.fromMap(document.data()));
    //     print("_gigList Size  = ${_gigList.length}");
    //   });
    // }).onDone(() {
    //   print("Marker on Done Number = ${_gigList.length}");
    //   addMarkersWIthGig(_gigList);
    // });

    stream.listen((_) {}).onData((List<DocumentSnapshot> documentList) {
      _gigList.clear();
      print("documentList = ${documentList.length}");
      documentList.forEach((DocumentSnapshot document) {
        _gigList.add(Gig.fromMap(document.data()));
        //  print("_gigList Size  = ${_gigList.length}");
      });
      print("Marker on data hk Number = ${_gigList.length}");
      _createAvailableGigMiniListFromGigList();
      addMarkersWIthGig(_gigList);
      setState(() {});
    });
    print("Marker sdfhksjhf kjasdhfkjsd hk Number = ${_gigList.length}");

    //if (_gigList != null) addMarkersWIthGig(_gigList);
  }

  double radiusLevel(double zoom, double latitude) {
    return 156543.03392 *
        Math.cos(latitude * Math.pi / 180) /
        Math.pow(2, zoom + 1);
  }

  _createAvailableGigMiniListFromGigList() {
    if (_gigList != null) {
      _availableGigList.clear();
      for (var gig in _gigList) {
        _availableGigList.add(GigMini(
          gigId: gig.gigId,
          money: gig.money,
          title: gig.title,
          location: gig.location,
          // distance: gig.distance,
        ));
      }
      _addDistanceToAvailableGigs();
    }
  }

  _addDistanceToAvailableGigs() {
    if (_availableGigList.length > 0 && _currentLocation != null) {
      for (var gigMini in _availableGigList) {
        gigMini.distance = LocationService()
            .calculateDistanceGigAndUserCurrentLocation(gigMini.location);
      }
    }
  }

  //<editor-fold desc="Calculate distance for all user gig mini list">
  _calculateDistanceForAllGigMiniInUserData() {
    _addDistanceToUserAllGigs();
    _addDistanceToUserAttemptedGigs();
    _addDistanceToUserWaitListedGigs();
    _addDistanceToUserCompletedGigs();
  }

  _addDistanceToUserAllGigs() {
    if (_user.allGigs.length > 0 && _currentLocation != null) {
      for (var gigMini in _user.allGigs) {
        gigMini.distance = LocationService()
            .calculateDistanceGigAndUserCurrentLocation(gigMini.location);
      }
    }
  }

  _addDistanceToUserWaitListedGigs() {
    if (_user.waitListGigs.length > 0 && _currentLocation != null) {
      for (var gigMini in _user.waitListGigs) {
        gigMini.distance = LocationService()
            .calculateDistanceGigAndUserCurrentLocation(gigMini.location);
      }
    }
  }

  _addDistanceToUserAttemptedGigs() {
    if (_user.attemptedGigs.length > 0 && _currentLocation != null) {
      for (var gigMini in _user.attemptedGigs) {
        gigMini.distance = LocationService()
            .calculateDistanceGigAndUserCurrentLocation(gigMini.location);
      }
    }
  }

  _addDistanceToUserCompletedGigs() {
    if (_user.completedGigs.length > 0 && _currentLocation != null) {
      for (var gigMini in _user.completedGigs) {
        gigMini.distance = LocationService()
            .calculateDistanceGigAndUserCurrentLocation(gigMini.location);
      }
    }
  }

  //</editor-fold>

  //<editor-fold desc="Distance calculation methods">
  LatLng geoPointToLatLong(GeoPoint geoPoint) {
    return LatLng(geoPoint.latitude, geoPoint.longitude);
  }

  _calculateDistanceForAllGigs() {
    if (_gigList.length > 0 && _currentLocation != null) {
      for (var gig in _gigList) {
        gig.distance = LocationService()
            .calculateDistanceGigAndUserCurrentLocation(gig.location);
      }
    }
    print("distance between gigs and current location...");
    for (var gig in _gigList) {
      print("For gig with money ${gig.money}, distance = ${gig.distance}");
    }
  }

  //</editor-fold>

  //<editor-fold desc="Camera drag">
  void _updatePosition(CameraPosition _position) {
    CameraPosition tappedCamera = CameraPosition(target: _tappedPosition);
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

  //</editor-fold>

  _handleTap(LatLng tappedPoint) {
    print(tappedPoint.toJson());
    // showToast(tappedPoint.toString());

    setState(() {
      //Distance

      _tappedPosition = tappedPoint;
      _isTapped = true;
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

  //<editor-fold desc="Add Marker Methods">
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

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/money_icon.jpg");
  }

  //</editor-fold>

  Widget _selectCustomMapBox(UserAccount user, int index) {
    switch (index) {
      case 0:
        return MapCustomItemBoxViewer(gigs: _availableGigList);
        break;
      case 1:
        return MapCustomItemBoxViewer(gigs: user.allGigs);
        break;
      case 2:
        return MapCustomItemBoxViewer(gigs: user.waitListGigs);
        break;
      case 3:
        return MapCustomItemBoxViewer(gigs: user.completedGigs);
        break;
      default:
        return Container();
        break;
    }
  }

  //<editor-fold desc="Location Methods for getting current location">
  Future<LatLng> _getCurrentLocationFromUserLocation() async {
    UserLocation location = await LocationService().getLocation();
    print(location.latitude.toString() + location.longitude.toString());
    currentUserLocation = LatLng(location.latitude, location.longitude);
    return LatLng(location.latitude, location.longitude);
  }

  Future _animateCameraToCurrentLocation() async {
    if (_mapController != null) {
      _mapController
          .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: _currentLocation,
        zoom: 15.0,
        tilt: 0,
      )));
    }
  }

  //</editor-fold>

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<UserAccount>(context);
    setState(() {
      if (_gigList != null) addMarkersWIthGig(_gigList);
      if (_user != null) {
        _isLoading = true;
      }
    });

    if (_isLoading) {
      userType = _user.type;
      return SafeArea(
        child: Scaffold(
          drawer: SideDrawer(),
          // floatingActionButton: FloatingActionButton(
          //   child: Icon(Icons.location_searching),
          //   onPressed: () async {
          //     _animateCameraToCurrentLocation();
          //   },
          // ),
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
          //#region bottomNavigationBar
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _bottomNavigationBarIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_run),
                title: Text("Available"),
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_turned_in),
                title: Text("My gigs"),
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.hourglass_empty),
                title: Text("Waitlisted"),
                backgroundColor: Colors.blue,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment),
                title: Text("Completed"),
                backgroundColor: Colors.blue,
              ),
            ],
            onTap: (value) {
              setState(() {
                _bottomNavigationBarIndex = value;
              });
            },
          ),
          //#endregion bottomNavigationBar
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
                  onCameraMove: (CameraPosition cameraPosition) {
                    // print("Zoom Level = ${cameraPosition.zoom}");
                    //markers.clear();
                    _cameraPositionCenter = cameraPosition.target;
                    radiusLevelCurrent = radiusLevel(
                        cameraPosition.zoom, cameraPosition.target.latitude);
                  },

                  markers: userType == "worker" ? _gigMarkers : _myMarkers,
                  //TODO Drag option
                  // onCameraMove: _isTapped
                  //     ? ((_position) => _updatePosition(_position))
                  //     : null,
                  onTap: _handleTap,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  compassEnabled: true,
                ),
                userType == "worker"
                    ? Positioned(
                        top: 0,
                        left: 10,
                        child: RaisedButton(
                          child: Text(
                            "Search Area",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _startQuery,
                          // color: Theme.of(context).buttonColor,
                          color: Colors.blueAccent,
                        ),
                      )
                    : Container(),
                userType == "provider"
                    ? Container(
                        alignment: Alignment.bottomCenter,
                        child: RaisedButton(
                          child: Text(
                            "Add GIG",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.deepPurpleAccent,
                          onPressed: () {
                            _tappedPosition != null
                                ? Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return GigAddPage(
                                        location: _tappedPosition,
                                      );
                                    },
                                  ))
                                : Loading();
                          },
                        ),
                      )
                    : _selectCustomMapBox(_user, _bottomNavigationBarIndex),
              ],
            ),
          ),
        ),
      );
    } else {
      return Loading();
    }
  }
}
