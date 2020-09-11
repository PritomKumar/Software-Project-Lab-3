import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

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
    @required this.uid ,
    this.firstName= "",
    this.lastName= "",
    this.email= "",
    this.photoUrl= "",
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

  final List<String> attemptedGigs;
  final List<String> completedigs;
  final List<String> waitListGigs;
  final List<String> allGigs;

  UserAccount({
    @required this.uid ,
    this.firstName= "",
    this.lastName= "",
    this.email= "",
    this.photoUrl= "",
    this.phoneNumber= "",
    this.birthDay ,
    this.gender= "Not set",
    this.streetAddress= "",
    this.city = "Dhaka",
    this.state= "",
    this.zipCode= "",
    this.bio= "",
    this.occupation= "",
    this.maritalStatus= "Not set",
    this.educationLevel= "Not set",
    this.employmentStatus= "Not set",
    this.householdIncome= "Not set",
    this.level = 1,
    this.type = "worker",
    this.writeAccess = false,
    this.allGigs,
    this.attemptedGigs,
    this.completedigs,
    this.waitListGigs,
  });
}
