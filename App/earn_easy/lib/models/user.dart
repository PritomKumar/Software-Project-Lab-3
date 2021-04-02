import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'gig.dart';

class UserMinimum {
  final String uid;
  final String photoUrl;
  final String firstName;
  final String lastName;
  final String email;
  final int level;
  final String type;
  final List<String> token;
  int numberOfCurrentGigs;
  double distance;
  final bool writeAccess;

  UserMinimum({
    @required this.uid,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.photoUrl = "",
    this.token,
    this.level = 1,
    this.numberOfCurrentGigs = 0,
    this.distance = double.infinity,
    this.type = "worker",
    this.writeAccess = false,
  });

  UserMinimum.fromMap(Map<String, dynamic> data)
      : this.uid = data["uid"] ?? "",
        this.firstName = data["firstName"] ?? "",
        this.lastName = data["lastName"] ?? "",
        this.email = data["email"] ?? "",
        this.photoUrl = data["photoUrl"] ?? "",
        this.token = List.from(data["token"]) ?? <String>[],
        this.level = data["level"] ?? 1,
        this.numberOfCurrentGigs = data["numberOfCurrentGigs"] ?? 0,
        this.distance = data["distance"] ?? double.infinity,
        this.type = data["type"] ?? "worker",
        this.writeAccess = data["writeAccess"];

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid ?? "",
      'firstName': this.firstName ?? "",
      'lastName': this.lastName ?? "",
      'email': this.email ?? "",
      'photoUrl': this.photoUrl ?? "",
      'token': this.token ?? [],
      'level': this.level ?? 1,
      'numberOfCurrentGigs': this.numberOfCurrentGigs ?? 0,
      'distance': this.distance ?? double.infinity,
      'type': this.type ?? "",
      'writeAccess': this.writeAccess ?? "",
    };
  }
}

class UserAccount {
  final String uid;
  final String photoUrl;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final Timestamp birthDay;
  final String gender;
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;
  final String bio;
  final String occupation;
  final String maritalStatus;
  final String educationLevel;
  final String employmentStatus;
  final String householdIncome;
  List<String> token;

  final int
      level; // 1 to 10 // changes positive tasks completion and completion rate
  // negative misconduct, inactivity, not finishing task
  final double rating; // 1.0 to 5.0
  final String type;
  final bool writeAccess;

  //<editor-fold desc="List of GigMini">
  final List<GigMini> attemptedGigs;
  final List<GigMini> currentGigs;
  final List<GigMini> createdGigs;
  final List<GigMini> completedGigs;
  final List<GigMini> waitListGigs;
  final List<GigMini> allGigs;

  //</editor-fold>

  UserAccount({
    @required this.uid,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.photoUrl = "",
    this.phoneNumber = "",
    this.birthDay,
    this.gender = "Not set",
    this.streetAddress = "",
    this.city = "Dhaka",
    this.state = "",
    this.zipCode = "",
    this.bio = "",
    this.occupation = "",
    this.maritalStatus = "Not set",
    this.educationLevel = "Not set",
    this.employmentStatus = "Not set",
    this.householdIncome = "Not set",
    this.token,
    this.level = 1,
    this.rating = 1.0,
    this.type = "worker",
    this.writeAccess = false,
    this.allGigs,
    this.attemptedGigs,
    this.completedGigs,
    this.currentGigs,
    this.waitListGigs,
    this.createdGigs,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": FirebaseAuth.instance.currentUser.uid,
      "firstName": this.firstName ?? "",
      "lastName": this.lastName ?? "",
      "email": this.email ?? "",
      "photoUrl": this.photoUrl ?? "",
      "phoneNumber": this.phoneNumber ?? "",
      "birthDay": this.birthDay ?? defaultInitializedTimestamp,
      "gender": this.gender ?? "Not set",
      "streetAddress": this.streetAddress ?? "",
      "city": this.city ?? "",
      "state": this.state ?? "",
      "zipCode": this.zipCode ?? "",
      "bio": this.bio ?? "",
      "occupation": this.occupation ?? "",
      "token": this.token ?? [],
      "maritalStatus": this.maritalStatus ?? "Not set",
      "educationLevel": this.educationLevel ?? "Not set",
      "employmentStatus": this.employmentStatus ?? "Not set",
      "householdIncome": this.householdIncome ?? "Not set",
      "level": this.level ?? 1,
      "rating": this.rating ?? 1.0,
      "type": this.type ?? "worker",
      "writeAccess": this.writeAccess ?? false,
      "allGigs": this.allGigs == null
          ? []
          : List.from(this.allGigs.map((index) => index.toMap())),
      "attemptedGigs": this.attemptedGigs == null
          ? []
          : List.from(this.attemptedGigs.map((index) => index.toMap())) ?? [],
      "currentGigs": this.currentGigs == null
          ? []
          : List.from(this.currentGigs.map((index) => index.toMap())) ?? [],
      "completedGigs": this.completedGigs == null
          ? []
          : List.from(this.completedGigs.map((index) => index.toMap())) ?? [],
      "waitListGigs": this.waitListGigs == null
          ? []
          : List.from(this.waitListGigs.map((index) => index.toMap())) ?? [],
      "createdGigs": this.createdGigs == null
          ? []
          : List.from(this.createdGigs.map((index) => index.toMap())) ?? [],
    };
  }

  UserAccount.fromMap(Map<String, dynamic> data)
      : this.uid = data['uid'],
        firstName = data['firstName'],
        lastName = data['lastName'],
        email = data['email'],
        photoUrl = data['photoUrl'],
        phoneNumber = data['phoneNumber'],
        birthDay = data['birthDay'],
        gender = data['gender'],
        streetAddress = data['streetAddress'],
        city = data['city'],
        state = data['state'],
        zipCode = data['zipCode'],
        bio = data['bio'],
        occupation = data['occupation'],
        maritalStatus = data['maritalStatus'],
        educationLevel = data['educationLevel'],
        employmentStatus = data['employmentStatus'],
        householdIncome = data['householdIncome'],
        token = List.from(data["token"]) ?? <String>[],
        level = data['level'],
        rating = data['rating'] ?? 1.0,
        type = data['type'],
        writeAccess = data['writeAccess'],
        allGigs =
            List.from(data['allGigs'].map((index) => GigMini.fromMap(index))) ??
                [],
        attemptedGigs = List.from(
                data['attemptedGigs'].map((index) => GigMini.fromMap(index))) ??
            [],
        currentGigs = List.from(
                data['currentGigs'].map((index) => GigMini.fromMap(index))) ??
            [],
        completedGigs = List.from(
                data['completedGigs'].map((index) => GigMini.fromMap(index))) ??
            [],
        waitListGigs = List.from(
                data['waitListGigs'].map((index) => GigMini.fromMap(index))) ??
            [],
        //TODO HAve to think about its use
        createdGigs = List.from(
                data['createdGigs'].map((index) => GigMini.fromMap(index))) ??
            [];
}

class UserResponse {
  final String userId;
  final List<TaskSnippet> taskSnippetList;
  final int completedTaskCount;
  double distance;
  final String gigId;

  UserResponse({
    @required this.userId,
    @required this.taskSnippetList,
    @required this.completedTaskCount,
    @required this.distance,
    @required this.gigId,
  });

  UserResponse.fromMap(Map<String, dynamic> data)
      : this.userId = data["userId"],
        this.taskSnippetList = List.from(data["taskSnippetList"]
                .map((index) => TaskSnippet.fromMap(index))) ??
            [],
        this.distance = data["distance"] ?? double.infinity,
        this.gigId = data["gigId"],
        this.completedTaskCount = data["completedTaskCount"];

  Map<String, dynamic> toMap() {
    return {
      'userId': this.userId ?? "",
      'taskSnippetList': this.taskSnippetList == null
          ? []
          : List.from(this.taskSnippetList.map((index) => index.toMap())) ?? [],
      'distance': this.distance ?? double.infinity,
      'gigId': this.gigId ?? "",
      'completedTaskCount': this.completedTaskCount ?? 0,
    };
  }
}
