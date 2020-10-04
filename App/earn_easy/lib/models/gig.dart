import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/shared/constants.dart';
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
  final String details;
  final Timestamp startTime;
  final Timestamp endTime;
  final String gigId;
  final String providerId;
  final String type;
  final String access;
  final String importantNote;
  final String notice;
  final List<String> fileAttachmentUrls;
  final List<String> attemptedUsers;
  final List<String> finishTaskUsers;

  Gig({
    this.money = 0,
    this.location,
    this.title = "",
    this.description = "",
    this.details = "",
    this.startTime,
    this.endTime,
    this.gigId = "",
    this.providerId = "",
    this.type = "Not set",
    this.access = "",
    this.importantNote = "",
    this.notice = "",
    this.fileAttachmentUrls,
    this.attemptedUsers,
    this.finishTaskUsers,
  });

  Gig.fromMap(Map<String, dynamic> data)
      : this.gigId = data["gigId"],
        this.money = data["money"],
        this.title = data["title"],
        this.location = data["location"],
        this.description = data["description"],
        this.details = data["details"],
        this.startTime = data["startTime"],
        this.endTime = data["endTime"],
        this.providerId = data["providerId"],
        this.type = data["type"],
        this.access = data["access"],
        this.importantNote = data["importantNote"],
        this.notice = data["notice"],
        this.fileAttachmentUrls = data["fileAttachmentUrls"],
        this.attemptedUsers = data["attemptedUsers"],
        this.finishTaskUsers = data["finishTaskUsers"];

  Map<String, dynamic> toMap() {
    return {
      'gigId': this.gigId ?? "",
      'money': this.money ?? 0,
      'title': this.title ?? "",
      'location': this.location ?? null,
      'description': this.description ?? "",
      'details': this.details ?? "",
      'startTime': this.startTime ?? defalultInitializedTimestamp,
      'endTime': this.endTime ?? defalultInitializedTimestamp,
      'providerId': this.providerId ?? "",
      'type': this.type ?? "Not set",
      'access': this.access ?? "public",
      'importantNote': this.importantNote ?? "",
      'notice': this.notice ?? "",
      'fileAttachmentUrls': this.fileAttachmentUrls,
      'attemptedUsers': this.attemptedUsers,
      'finishTaskUsers': this.finishTaskUsers,
    };
  }
}
