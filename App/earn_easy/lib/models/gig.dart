import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/task.dart';
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
  List<TaskSnippet> taskSnippetList = List<TaskSnippet>();
  List<String> fileAttachmentUrls = List<String>();
  List<String> attemptedUsers = List<String>();
  List<String> finishTaskUsers = List<String>();

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
    this.taskSnippetList,
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
        this.taskSnippetList = List.from(data["taskSnippetList"]
                .map((index) => TaskSnippet.fromMap(index))) ??
            [],
        this.fileAttachmentUrls =
            List.from(data["fileAttachmentUrls"]) ?? List<String>(),
        this.attemptedUsers =
            List.from(data["attemptedUsers"]) ?? List<String>(),
        this.finishTaskUsers =
            List.from(data["finishTaskUsers"]) ?? List<String>();

  Map<String, dynamic> toMap() {
    return {
      'gigId': this.gigId ?? "",
      'money': this.money ?? 0,
      'title': this.title ?? "",
      'location': this.location ?? null,
      'description': this.description ?? "",
      'details': this.details ?? "",
      'startTime': this.startTime ?? defaultInitializedTimestamp,
      'endTime': this.endTime ?? defaultInitializedTimestamp,
      'providerId': this.providerId ?? "",
      'type': this.type ?? "Not set",
      'access': this.access ?? "public",
      'importantNote': this.importantNote ?? "",
      'notice': this.notice ?? "",
      'taskSnippetList': this.taskSnippetList ?? [],
      'fileAttachmentUrls': this.fileAttachmentUrls ?? List<String>(),
      'attemptedUsers': this.attemptedUsers ?? List<String>(),
      'finishTaskUsers': this.finishTaskUsers ?? List<String>(),
    };
  }
}
