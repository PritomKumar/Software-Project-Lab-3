import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gig {
  final int money;
  final GeoPoint location;
  final String title;
  final String description;
  final Timestamp startTime;
  final Timestamp endTime;
  final String gigId;
  final String providerId;
  final String type;

  Gig({
    this.money = 0,
    this.location ,
    this.title = "",
    this.description = "",
    this.startTime ,
    this.endTime,
    this.gigId = "",
    this.providerId = "",
    this.type = "",
  });
}
