import 'dart:async';
import 'dart:math' as Math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoFlutterExampleVersion2 extends StatefulWidget {
  @override
  _GeoFlutterExampleVersion2State createState() =>
      _GeoFlutterExampleVersion2State();
}

class _GeoFlutterExampleVersion2State extends State<GeoFlutterExampleVersion2> {
  GoogleMapController _mapController;
  TextEditingController _latitudeController, _longitudeController;

  // firestore init
  final _firestore = FirebaseFirestore.instance;
  Geoflutterfire geo;
  Stream<List<DocumentSnapshot>> stream;

  //final radius = BehaviorSubject<double>.seeded(1.0);
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng _cameraPositionCenter = LatLng(12.960632, 77.641603);
  double radiusLevelCurrent = 2.327804656243825;

  @override
  void initState() {
    super.initState();
    _latitudeController = TextEditingController();
    _longitudeController = TextEditingController();
    //geo = Geoflutterfire();
  }

  @override
  void dispose() {
    _latitudeController.dispose();
    _longitudeController.dispose();
    // radius.close();
    super.dispose();
  }

  double radiusLevel(double zoom, double latitude) {
    return 156543.03392 *
        Math.cos(latitude * Math.pi / 180) /
        Math.pow(2, zoom + 1);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GeoFlutterFire'),
          actions: <Widget>[
            IconButton(
              onPressed: _mapController == null
                  ? null
                  : () {
                      _showHome();
                    },
              icon: Icon(Icons.home),
            )
          ],
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: _onMapCreated,
                onCameraMove: (CameraPosition cameraPosition) {
                  // print("Zoom Level = ${cameraPosition.zoom}");
                  //markers.clear();
                  _cameraPositionCenter = cameraPosition.target;
                  radiusLevelCurrent = radiusLevel(
                      cameraPosition.zoom, cameraPosition.target.latitude);
                },

                //onCameraIdle: _startQuery,

                onTap: (latlong) {
                  print(latlong.toJson());
                  final lat = latlong.latitude;
                  final lng = latlong.longitude;
                  _addPoint(lat, lng);
                  //_addNestedPoint(lat,lng);
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(12.960632, 77.641603),
                  zoom: 15.0,
                ),
                markers: Set<Marker>.of(markers.values),
              ),
              RaisedButton(
                child: Text(
                  "Search Area",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _startQuery,
                color: Colors.blue[700],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    //  var locationData = await  Location().getLocation();
    // _cameraPositionCenter = LatLng(locationData.latitude,locationData.longitude);
    _mapController = controller;
    geo = Geoflutterfire();
    //radius.add(2.327804656243825);
    await _startQuery();
    setState(() {});
  }

  Future _startQuery() async {
    print("_cameraPositionCenter = ${_cameraPositionCenter.toJson()}");
    GeoFirePoint center = geo.point(
        latitude: _cameraPositionCenter.latitude,
        longitude: _cameraPositionCenter.longitude);

    var collectionReference = _firestore.collection('locations');

    stream = geo.collection(collectionRef: collectionReference).within(
          center: center,
          radius: radiusLevelCurrent,
          field: 'position',
          strictMode: true,
        );

    // stream = geo.collection(collectionRef: fireStoreGigsRef).within(
    //   center: center,
    //   radius: radiusLevelCurrent,
    //   field: 'location',
    //   strictMode: true,
    // );

    // _gigList.clear();
    // stream.listen((List<DocumentSnapshot> documentList) {
    //   documentList.forEach((DocumentSnapshot document) {
    //     _gigList.add(Gig.fromMap(document.data()));
    //   });
    // });

    stream.listen((List<DocumentSnapshot> documentList) {
      _updateMarkers(documentList);
    });
  }

  void _showHome() {
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      const CameraPosition(
        target: LatLng(12.960632, 77.641603),
        zoom: 15.0,
      ),
    ));
  }

  void _addPoint(double lat, double lng) {
    GeoFirePoint geoFirePoint = geo.point(latitude: lat, longitude: lng);
    _firestore
        .collection('locations')
        .add({'name': 'random name', 'position': geoFirePoint.data}).then((_) {
      print('added ${geoFirePoint.hash} successfully');
    });
  }

  //example to add geoFirePoint inside nested object
  void _addNestedPoint(double lat, double lng) {
    GeoFirePoint geoFirePoint = geo.point(latitude: lat, longitude: lng);
    _firestore.collection('nestedLocations').add({
      'name': 'random name',
      'address': {
        'location': {'position': geoFirePoint.data}
      }
    }).then((_) {
      print('added ${geoFirePoint.hash} successfully');
    });
  }

  void _addMarker(double lat, double lng) {
    final id = MarkerId(lat.toString() + lng.toString());
    final _marker = Marker(
      markerId: id,
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      infoWindow: InfoWindow(title: 'latLng', snippet: '$lat,$lng'),
    );
    setState(() {
      markers[id] = _marker;
    });
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    markers.clear();
    documentList.forEach((DocumentSnapshot document) {
      // final GeoPoint point = document.data()['location']['geopoint'];
      final GeoPoint point = document.data()['position']['geopoint'];
      final GeoFirePoint firePoint =
          GeoFirePoint(point.latitude, point.longitude);
      print(" GeoFirePoint =  " + firePoint.data.toString());
      _addMarker(point.latitude, point.longitude);
    });
    print("Marker sdfhksjhf kjasdhfkjsd hk Number = ${markers.length}");
  }

  double _value = 20.0;
  String _label = '';

  changed(value) {
    setState(() {
      _value = value;
      _label = '${_value.toInt().toString()} kms';

      markers.clear();
    });
    //radius.add(value);
  }
}
