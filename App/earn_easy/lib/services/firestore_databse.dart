import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

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
    else{
      return null;
    }
  }

  Future userAccountOfCurrentUser() async {
    var result = await userProfiles.doc(FirebaseAuth.instance.currentUser.uid).get();
    print(result.data());
  }

//  Future<UserAccount> userAccountOfCurrentUser() async {
//    var result = await userProfiles.doc(FirebaseAuth.instance.currentUser.uid).get();
//    print(result.data());
//    return UserAccount(
//      uid: result.id,
//      name: result.data()["name"],
//      email: result.data()["email"],
//      photoUrl: result.data()["photoUrl"],
//    );
//  }

}