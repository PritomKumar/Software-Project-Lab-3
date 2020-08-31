import 'package:flutter/cupertino.dart';

class UserAccount {
  final String uid;
  final String photoUrl;
  final String name;
  final String email;
  final String phoneNumber;
  final DateTime birthDay;
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

  UserAccount({
    @required this.uid ,
    this.name= "",
    this.email= "",
    this.photoUrl= "",
    this.phoneNumber= "",
    this.birthDay ,
    this.gender= "",
    this.streetAddress= "",
    this.city = "Dhaka",
    this.state= "",
    this.zipCode= "",
    this.bio= "",
    this.occupation= "",
    this.maritalStatus= "",
    this.educationLevel= "",
    this.employmentStatus= "",
    this.householdIncome= "",
    this.level = 1,
    this.type = "worker",
    this.writeAccess = false,
  });
}
