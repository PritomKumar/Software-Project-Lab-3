import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServiceUser {
  final CollectionReference fireStoreUsersRef =
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
      return fireStoreUsersRef
          .doc(uid)
          .set(userAccount.toMap());
    } else {
      return null;
    }
  }

  Future userAccountOfCurrentUser() async {
    var result = await fireStoreUsersRef
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    print(result.data());
  }

  UserAccount _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return isLoggedIn() ? UserAccount.fromMap(snapshot.data()) : null;
  }

  Future updateAttemptedGigWaitListedGigAndAllGigsAtTheSameTime(Gig gig) async {
    try {
      await fireStoreUsersRef.doc(userUid).update({
        'attemptedGigs': FieldValue.arrayUnion([
          GigMini(
            gigId: gig.gigId,
            title: gig.title,
            money: gig.money,
            location: gig.location,
          ).toMap()
        ]),
        'waitListGigs': FieldValue.arrayUnion([
          GigMini(
            gigId: gig.gigId,
            title: gig.title,
            money: gig.money,
            location: gig.location,
          ).toMap()
        ]),
        'allGigs': FieldValue.arrayUnion([
          GigMini(
            gigId: gig.gigId,
            title: gig.title,
            money: gig.money,
            location: gig.location,
          ).toMap()
        ]),
      }).then((value) {
        print("attemptedGigs, waitListGigs and allGigs updated in user");
      });
    } catch (e) {
      print("attemptedGigs, waitListGigs and allGigs updated  failed $e");
    }
  }

  //<editor-fold desc="Old Version">

  // Future updateUserData(UserAccount userAccount) {
  //   if (isLoggedIn()) {
  //     return fireStoreUsersRef.doc(uid).set({
  //       "uid": userAccount.uid ?? uid,
  //       "firstName": userAccount.firstName ?? "",
  //       "lastName": userAccount.lastName ?? "",
  //       "email": userAccount.email ?? "",
  //       "photoUrl": userAccount.photoUrl ?? "",
  //       "phoneNumber": userAccount.phoneNumber ?? "",
  //       "birthDay": userAccount.birthDay ?? defalultInitializedTimestamp,
  //       "gender": userAccount.gender ?? "Not set",
  //       "streetAddress": userAccount.streetAddress ?? "",
  //       "city": userAccount.city ?? "",
  //       "state": userAccount.state ?? "",
  //       "zipCode": userAccount.zipCode ?? "",
  //       "bio": userAccount.bio ?? "",
  //       "occupation": userAccount.occupation ?? "",
  //       "maritalStatus": userAccount.maritalStatus ?? "Not set",
  //       "educationLevel": userAccount.educationLevel ?? "Not set",
  //       "employmentStatus": userAccount.employmentStatus ?? "Not set",
  //       "householdIncome": userAccount.householdIncome ?? "Not set",
  //       "level": userAccount.level ?? 1,
  //       "type": userAccount.type ?? "worker",
  //       "writeAccess": userAccount.writeAccess ?? false,
  //       "allGigs": userAccount.allGigs ?? [],
  //       "attemptedGigs": userAccount.attemptedGigs ?? [],
  //       "completedGigs": userAccount.completedGigs ?? [],
  //       "waitListGigs": userAccount.waitListGigs ?? [],
  //       "createdGigs": userAccount.createdGigs ?? [],
  //     });
  //   } else {
  //     return null;
  //   }
  // }
  // UserAccount _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return isLoggedIn()
  //       ? UserAccount(
  //           uid: this.uid,
  //           firstName: snapshot.data()['firstName'],
  //           lastName: snapshot.data()['lastName'],
  //           email: snapshot.data()['email'],
  //           photoUrl: snapshot.data()['photoUrl'],
  //           phoneNumber: snapshot.data()['phoneNumber'],
  //           birthDay: snapshot.data()['birthDay'],
  //           gender: snapshot.data()['gender'],
  //           streetAddress: snapshot.data()['streetAddress'],
  //           city: snapshot.data()['city'],
  //           state: snapshot.data()['state'],
  //           zipCode: snapshot.data()['zipCode'],
  //           bio: snapshot.data()['bio'],
  //           occupation: snapshot.data()['occupation'],
  //           maritalStatus: snapshot.data()['maritalStatus'],
  //           educationLevel: snapshot.data()['educationLevel'],
  //           employmentStatus: snapshot.data()['employmentStatus'],
  //           householdIncome: snapshot.data()['householdIncome'],
  //           level: snapshot.data()['level'],
  //           type: snapshot.data()['type'],
  //           writeAccess: snapshot.data()['writeAccess'],
  //           allGigs: List.from(snapshot
  //               .data()['allGigs']
  //               .map((index) => GigMini.fromMap(index))),
  //           attemptedGigs: List.from(snapshot
  //               .data()['attemptedGigs']
  //               .map((index) => GigMini.fromMap(index))),
  //           completedGigs: List.from(snapshot
  //               .data()['completedGigs']
  //               .map((index) => GigMini.fromMap(index))),
  //           waitListGigs: List.from(snapshot
  //               .data()['waitListGigs']
  //               .map((index) => GigMini.fromMap(index))),
  //           //TODO HAve to think about its use
  //           createdGigs: List.from(snapshot
  //               .data()['createdGigs']
  //               .map((index) => GigMini.fromMap(index))),
  //         )
  //       : null;
  // }
  //</editor-fold>

  Future<bool> checkIfDataExists() async {
    print("Before logged in");
    if (isLoggedIn()) {
      print("After logged in");
      bool dataExist = false;
      await fireStoreUsersRef.doc(uid).get().then((onValue) {
        print("After logged in");
        if (onValue.exists) {
          dataExist = true;
        } else {
          dataExist = false;
        }
      });
      return dataExist;
    } else {
      return false;
    }
  }

  Stream<UserAccount> get userData {
    return isLoggedIn()
        ? fireStoreUsersRef.doc(uid).snapshots().map(_userDataFromSnapshot)
        : null;
  }

//  Stream<UserAccount> get userData {
//    print("Before logged in");
//    if (isLoggedIn()) {
//      print("After logged in");
//      dynamic snapshot;
//      userProfiles.doc(uid).get().then((onValue) {
//        print("After logged in");
//        if (onValue.exists) {
//          snapshot = userProfiles.doc(uid).snapshots();
//        } else {
//          snapshot = null;
//        }
//      });
//      if (snapshot != null) {
//        print("After snapshot not null");
//        print(snapshot);
//        return userProfiles.doc(uid).snapshots().map(_userDataFromSnapshot);
//      } else {
//        print("After snapshot is null");
//        print(snapshot);
//        return null;
//      }
//    } else {
//      return null;
//    }
//  }
}
