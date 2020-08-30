import 'package:flutter/cupertino.dart';

class User{
  final String uid;
  final String photoUrl;
  final String name;
  final String email;
  User({@required this.uid,this.name, this.email,this.photoUrl});
}