import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService{

  final CollectionReference userProfiles = FirebaseFirestore.instance.collection("Users");

  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser!=null){
      return true;
    }
    else {
      return false;
    }
  }

  Future updateUserData(UserAccount userAccount){
    if(isLoggedIn()){
      userProfiles.doc(userAccount.uid).set({
        "name" : userAccount.name,
        "email" : userAccount.email,
        "photoUrl" : userAccount.photoUrl,
      });
    }
  }


}