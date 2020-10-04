import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/shared/constants.dart';
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
  final bool writeAccess;

  UserMinimum({
    @required this.uid,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.photoUrl = "",
    this.level = 1,
    this.type = "worker",
    this.writeAccess = false,
  });
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

  final int level;
  final String type;
  final bool writeAccess;

  final List<GigMini> attemptedGigs;
  final List<GigMini> createdGigs;
  final List<GigMini> completedGigs;
  final List<GigMini> waitListGigs;
  final List<GigMini> allGigs;

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
    this.level = 1,
    this.type = "worker",
    this.writeAccess = false,
    this.allGigs,
    this.attemptedGigs,
    this.completedGigs,
    this.waitListGigs,
    this.createdGigs,
  });

  UserAccount.fromMap(Map<String, dynamic> data)
      : uid = data['uid'],
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
        level = data['level'],
        type = data['type'],
        writeAccess = data['writeAccess'],
        allGigs =
            List.from(data['allGigs'].map((index) => GigMini.fromMap(index))),
        attemptedGigs = List.from(
            data['attemptedGigs'].map((index) => GigMini.fromMap(index))),
        completedGigs = List.from(
            data['completedGigs'].map((index) => GigMini.fromMap(index))),
        waitListGigs = List.from(
            data['waitListGigs'].map((index) => GigMini.fromMap(index))),
        //TODO HAve to think about its use
        createdGigs = List.from(
            data['createdGigs'].map((index) => GigMini.fromMap(index)));

  Map<String, dynamic> toMap() {
    return {
      "uid": this.uid ?? uid,
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
      "maritalStatus": this.maritalStatus ?? "Not set",
      "educationLevel": this.educationLevel ?? "Not set",
      "employmentStatus": this.employmentStatus ?? "Not set",
      "householdIncome": this.householdIncome ?? "Not set",
      "level": this.level ?? 1,
      "type": this.type ?? "worker",
      "writeAccess": this.writeAccess ?? false,
      "allGigs": this.allGigs ?? [],
      "attemptedGigs": this.attemptedGigs ?? [],
      "completedGigs": this.completedGigs ?? [],
      "waitListGigs": this.waitListGigs ?? [],
      "createdGigs": this.createdGigs ?? [],
    };
  }
}
