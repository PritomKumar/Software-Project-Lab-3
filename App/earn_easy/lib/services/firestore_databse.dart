import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final CollectionReference userProfiles = Firestore.instance.collection("Users");
}