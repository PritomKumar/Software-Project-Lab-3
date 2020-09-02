import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';

class Gig {
  final int money;
  final Geolocation location;
  final String title;
  final String description;
  final Timestamp startTime;
  final Timestamp endTime;
  final String gigId;
  final String providerId;
  final String type;

  Gig({
    this.money,
    this.location,
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.gigId,
    this.providerId,
    this.type,
  });
}
