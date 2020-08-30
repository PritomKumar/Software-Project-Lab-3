import 'package:flutter/cupertino.dart';

class UserAccount{
  final String uid;
  final String photoUrl;
  final String name;
  final String email;
  UserAccount({@required this.uid,this.name, this.email,this.photoUrl});
}