import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final CollectionReference userProfiles =
      FirebaseFirestore.instance.collection("Users");
  final String uid = FirebaseAuth.instance.currentUser.uid;

  bool isLoggedIn() {
    if (uid != null) {
      return true;
    } else {
      return false;
    }
  }

  Future updateUserData(UserAccount userAccount) {
    if (isLoggedIn()) {
      userProfiles.doc(uid).set({
        "firstName": userAccount.firstName ?? "",
        "lastName": userAccount.lastName ?? "",
        "email": userAccount.email ?? "",
        "photoUrl": userAccount.photoUrl ?? "",
        "phoneNumber": userAccount.phoneNumber ?? "",
        "birthDay": userAccount.birthDay ?? DateTime(1000, 1, 1),
        "gender": userAccount.gender ?? "",
        "streetAddress": userAccount.streetAddress ?? "",
        "city": userAccount.city ?? "",
        "state": userAccount.state ?? "",
        "zipCode": userAccount.zipCode ?? "",
        "bio": userAccount.bio ?? "",
        "occupation": userAccount.occupation ?? "",
        "maritalStatus": userAccount.maritalStatus ?? "",
        "educationLevel": userAccount.educationLevel ?? "",
        "employmentStatus": userAccount.employmentStatus ?? "",
        "householdIncome": userAccount.householdIncome ?? "",
        "level": userAccount.level ?? 1,
        "type": userAccount.type ?? "worker",
        "writeAccess": userAccount.writeAccess ?? false,
      });
    } else {
      return null;
    }
  }

  Future userAccountOfCurrentUser() async {
    var result =
        await userProfiles.doc(FirebaseAuth.instance.currentUser.uid).get();
    print(result.data());
  }

  UserAccount _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return isLoggedIn()
        ? UserAccount(
            uid: uid,
            firstName: snapshot.data()['firstName'] ,
            lastName: snapshot.data()['lastName'] ,
            email: snapshot.data()['email'] ,
            photoUrl: snapshot.data()['photoUrl'] ,
            phoneNumber: snapshot.data()['phoneNumber'] ,
            birthDay: snapshot.data()['birthDay'] ,
            gender: snapshot.data()['gender'] ,
            streetAddress: snapshot.data()['streetAddress'] ,
            city: snapshot.data()['city'] ,
            state: snapshot.data()['state'] ,
            zipCode: snapshot.data()['zipCode'],
            bio: snapshot.data()['bio'],
            occupation: snapshot.data()['occupation'] ,
            maritalStatus: snapshot.data()['maritalStatus'] ,
            educationLevel: snapshot.data()['educationLevel'] ,
            employmentStatus: snapshot.data()['employmentStatus'],
            householdIncome: snapshot.data()['householdIncome'] ,
            level: snapshot.data()['level'] ,
            type: snapshot.data()['type'] ,
            writeAccess: snapshot.data()['writeAccess'] ,
          )
        : null;
  }

  Stream<UserAccount> get userData {
    return isLoggedIn()
        ? userProfiles.doc(uid).snapshots().map(_userDataFromSnapshot)
        : null;
  }
}
