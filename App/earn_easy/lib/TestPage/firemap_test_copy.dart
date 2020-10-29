import 'dart:async';
import 'dart:math' as Math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class FireMap extends StatefulWidget {
//   State createState() => FireMapState();
// }
//
//
// class FireMapState extends State<FireMap> {
//   GoogleMapController mapController;
//   Location location = new Location();
//
//   Firestore firestore = Firestore.instance;
//   Geoflutterfire geo = Geoflutterfire();
//
//   // Stateful Data
//   BehaviorSubject<double> radius = BehaviorSubject(seedValue: 100.0);
//   Stream<dynamic> query;
//
//   // Subscription
//   StreamSubscription subscription;
//
//   build(context) {
//     return Stack(children: [
//
//       GoogleMap(
//         initialCameraPosition: CameraPosition(
//             target: LatLng(24.142, -110.321),
//             zoom: 15
//         ),
//         onMapCreated: _onMapCreated,
//         myLocationEnabled: true,
//         mapType: MapType.hybrid,
//         compassEnabled: true,
//         trackCameraPosition: true,
//       ),
//       Positioned(
//           bottom: 50,
//           right: 10,
//           child:
//           FlatButton(
//               child: Icon(Icons.pin_drop, color: Colors.white),
//               color: Colors.green,
//               onPressed: _addGeoPoint
//           )
//       ),
//       Positioned(
//           bottom: 50,
//           left: 10,
//           child: Slider(
//             min: 100.0,
//             max: 500.0,
//             divisions: 4,
//             value: radius.value,
//             label: 'Radius ${radius.value}km',
//             activeColor: Colors.green,
//             inactiveColor: Colors.green.withOpacity(0.2),
//             onChanged: _updateQuery,
//           )
//       )
//     ]);
//   }
//
//   // Map Created Lifecycle Hook
//   _onMapCreated(GoogleMapController controller) {
//     _startQuery();
//     setState(() {
//       mapController = controller;
//     });
//   }
//
//   _addMarker() {
//     var marker = Marker(
//         position: mapController.cameraPosition.target,
//         icon: BitmapDescriptor.defaultMarker,
//         infoWindowText: InfoWindowText('Magic Marker', '🍄🍄🍄')
//     );
//
//     mapController.addMarker(marker);
//   }
//
//   _animateToUser() async {
//     var pos = await location.getLocation();
//     mapController.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(pos['latitude'], pos['longitude']),
//           zoom: 17.0,
//         )
//     )
//     );
//   }
//
//   // Set GeoLocation Data
//   Future<DocumentReference> _addGeoPoint() async {
//     var pos = await location.getLocation();
//     GeoFirePoint point = geo.point(latitude: pos['latitude'], longitude: pos['longitude']);
//     return firestore.collection('locations').add({
//       'position': point.data,
//       'name': 'Yay I can be queried!'
//     });
//   }
//
//   void _updateMarkers(List<DocumentSnapshot> documentList) {
//     print(documentList);
//     mapController.clearMarkers();
//     documentList.forEach((DocumentSnapshot document) {
//       GeoPoint pos = document.data['position']['geopoint'];
//       double distance = document.data['distance'];
//       var marker = MarkerOptions(
//           position: LatLng(pos.latitude, pos.longitude),
//           icon: BitmapDescriptor.defaultMarker,
//           infoWindowText: InfoWindowText('Magic Marker', '$distance kilometers from query center')
//       );
//
//
//       mapController.addMarker(marker);
//     });
//   }
//
//   _startQuery() async {
//     // Get users location
//     var pos = await location.getLocation();
//     double lat = pos['latitude'];
//     double lng = pos['longitude'];
//
//
//     // Make a referece to firestore
//     var ref = firestore.collection('locations');
//     GeoFirePoint center = geo.point(latitude: lat, longitude: lng);
//
//     // subscribe to query
//     subscription = radius.switchMap((rad) {
//       return geo.collection(collectionRef: ref).within(
//           center: center,
//           radius: rad,
//           field: 'position',
//           strictMode: true
//       );
//     }).listen(_updateMarkers);
//   }
//
//   _updateQuery(value) {
//     final zoomMap = {
//       100.0: 12.0,
//       200.0: 10.0,
//       300.0: 7.0,
//       400.0: 6.0,
//       500.0: 5.0
//     };
//     final zoom = zoomMap[value];
//     mapController.moveCamera(CameraUpdate.zoomTo(zoom));
//
//     setState(() {
//       radius.add(value);
//     });
//   }
//
//   @override
//   dispose() {
//     subscription.cancel();
//     super.dispose();
//   }
//
//
// }

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
