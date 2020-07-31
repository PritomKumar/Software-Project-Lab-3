import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final currentPosition = Provider.of<Position>(context);
    return Scaffold(
      body: (currentPosition!=null) ? Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(currentPosition.latitude, currentPosition.longitude),
                zoom: 16.0,
              ),
              zoomGesturesEnabled: true,
            ),
          )
        ],
      ): Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
