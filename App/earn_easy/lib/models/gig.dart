import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GigMini {
  final String gigId;
  final int money;
  final String title;

  GigMini({this.gigId, this.money, this.title});

  GigMini.fromMap(Map<String, dynamic> data)
      : this.gigId = data["gigId"],
        this.money = data["money"],
        this.title = data["title"];

  Map<String, dynamic> toMap() {
    return {
      'gigId': this.gigId,
      'money': this.money,
      'title': this.title,
    };
  }
}

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
  final String access;
  final String importantNote;
  final List<String> fileAttachmentUrls;
  final List<String> attemptedUsers;
  final List<String> finishTaskUsers;

  Gig({
    this.money = 0,
    this.location,
    this.title = "",
    this.description = "",
    this.startTime,
    this.endTime,
    this.gigId = "",
    this.providerId = "",
    this.type = "Not set",
    this.access = "",
    this.importantNote = "",
    this.fileAttachmentUrls,
    this.attemptedUsers,
    this.finishTaskUsers,
  });
}
