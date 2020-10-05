import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String ImageTaskType = "ImageTask";
const String CheckBoxTaskType = "CheckBoxTask";
const String MultipleChoiceTaskType = "MultipleChoiceTask";
const String DropdownTaskType = "DropdownTask";
const String FreeTextTaskType = "FreeTextTask";

Timestamp defaultInitializedTimestamp =
    Timestamp.fromDate(DateTime(1000, 1, 1));
final String userUid = FirebaseAuth.instance.currentUser.uid;
final CollectionReference fireStoreUsersRef =
    FirebaseFirestore.instance.collection("Users");
final CollectionReference fireStoreGigsRef =
    FirebaseFirestore.instance.collection("Gigs");

const emailInputDecoration = InputDecoration(
  fillColor: Colors.white,
  hintText: "Email",
  filled: true,
  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
  prefixIcon: Icon(FontAwesomeIcons.solidEnvelope, color: Colors.greenAccent),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0)),
  errorStyle: TextStyle(
    color: Colors.deepPurpleAccent,
  ),
);

const passwordInputDecoration = InputDecoration(
  fillColor: Colors.white,
  hintText: "Password",
  filled: true,
  hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0),
  prefixIcon: Icon(
    FontAwesomeIcons.lock,
    color: Colors.redAccent,
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 2.0)),
  errorStyle: TextStyle(
    color: Colors.deepPurpleAccent,
  ),
);
