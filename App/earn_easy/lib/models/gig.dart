import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class GigMini {
  final String gigId;
  final int money;
  final String title;
  final GeoPoint location;
  double distance;

  GigMini({
    @required this.gigId,
    this.money,
    this.title,
    @required this.location,
    this.distance,
  });

  GigMini.fromMap(Map<String, dynamic> data)
      : this.gigId = data["gigId"],
        this.money = data["money"],
        this.location = data["location"]['geopoint'] ?? null,
        this.distance = data["distance"],
        this.title = data["title"];

  Map<String, dynamic> toMap() {
    return {
      'gigId': this.gigId,
      'money': this.money,
      'title': this.title,
      //'location': this.location,
      'location':
          GeoFirePoint(this.location.latitude, this.location.longitude).data ??
              null,
      'distance': this.distance,
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
  double distance;
  List<TaskSnippet> taskSnippetList = <TaskSnippet>[];
  List<String> fileAttachmentUrls = <String>[];
  List<UserMinimum> attemptedUsers = <UserMinimum>[];
  List<UserMinimum> finishTaskUsers = <UserMinimum>[];
  final UserMinimum assignedUser;

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
    this.assignedUser,
    this.notice = "",
    this.distance,
    this.taskSnippetList,
    this.fileAttachmentUrls,
    this.attemptedUsers,
    this.finishTaskUsers,
  });

  Gig.fromMap(Map<String, dynamic> data)
      : this.gigId = data["gigId"],
        this.money = data["money"],
        this.title = data["title"],
        this.location = data["location"]['geopoint'] ?? null,
        this.description = data["description"],
        this.details = data["details"],
        this.startTime = data["startTime"],
        this.endTime = data["endTime"],
        this.providerId = data["providerId"],
        this.type = data["type"],
        this.access = data["access"],
        this.importantNote = data["importantNote"],
        this.notice = data["notice"],
        this.assignedUser = data["assignedUser"] == null
            ? null
            : UserMinimum.fromMap(data["assignedUser"]),
        this.taskSnippetList = List.from(data["taskSnippetList"]
                .map((index) => TaskSnippet.fromMap(index))) ??
            [],
        this.fileAttachmentUrls =
            List.from(data["fileAttachmentUrls"]) ?? List<String>(),
        this.attemptedUsers = List.from(data['attemptedUsers']
                .map((index) => UserMinimum.fromMap(index))) ??
            [],
        this.finishTaskUsers = List.from(data['finishTaskUsers']
                .map((index) => UserMinimum.fromMap(index))) ??
            [];

  Map<String, dynamic> toMap() {
    return {
      'gigId': this.gigId ?? "",
      'money': this.money ?? 0,
      'title': this.title ?? "",
      'location':
          GeoFirePoint(this.location.latitude, this.location.longitude).data ??
              null,
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
      'fileAttachmentUrls': this.fileAttachmentUrls ?? [],
      'assignedUser':
          this.assignedUser == null ? null : this.assignedUser.toMap(),
      'attemptedUsers': this.attemptedUsers == null
          ? []
          : List.from(this.attemptedUsers.map((index) => index.toMap())) ?? [],
      'finishTaskUsers': this.finishTaskUsers == null
          ? []
          : List.from(this.finishTaskUsers.map((index) => index.toMap())) ?? [],
    };
  }
}
