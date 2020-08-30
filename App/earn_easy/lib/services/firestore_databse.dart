import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  final CollectionReference userProfiles =
      FirebaseFirestore.instance.collection("Users");
  final String uid = FirebaseAuth.instance.currentUser.uid;

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future updateUserData(UserAccount userAccount) {
    if (isLoggedIn()) {
      userProfiles.doc(uid).set({
        "name": userAccount.name ?? "",
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
            name: snapshot.data()['name'] ?? "",
            email: snapshot.data()['email'] ?? "",
            photoUrl: snapshot.data()['photoUrl'] ?? "",
          )
        : null;
  }

  Stream<UserAccount> get userData {
    return isLoggedIn()
        ? userProfiles.doc(uid).snapshots().map(_userDataFromSnapshot)
        : null;
  }
}
