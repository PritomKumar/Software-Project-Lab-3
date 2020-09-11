import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DatabaseServiceGigs {
  final CollectionReference fireStoreGigsRef =
      FirebaseFirestore.instance.collection("Gigs");
  final String uid = FirebaseAuth.instance.currentUser.uid;

  bool isLoggedIn() {
    if (uid != null) {
      return true;
    } else {
      return false;
    }
  }

  Future updateGigData(Gig gig) {
    if (isLoggedIn()) {
      return fireStoreGigsRef.doc(gig.gigId).set({
        "gigId": gig.gigId ?? "",
        "money": gig.money ?? 0,
        "location": gig.location ?? null,
        "title": gig.title ?? "",
        "description": gig.description ?? "",
        "startTime": gig.startTime ?? defalultInitializedTimestamp,
        "endTime": gig.endTime ?? defalultInitializedTimestamp,
        "providerId": gig.providerId ?? "",
        "type": gig.type ?? "Not set",
        "access": gig.access ?? "public",
      });
    } else {
      return null;
    }
  }

  Future createNewGig(Gig gig) {
    if (isLoggedIn()) {
      return fireStoreGigsRef.add({
        "gigId": gig.gigId ?? "",
        "money": gig.money ?? 0,
        "location": gig.location ?? null,
        "title": gig.title ?? "",
        "description": gig.description ?? "",
        "startTime": gig.startTime ?? defalultInitializedTimestamp,
        "endTime": gig.endTime ?? defalultInitializedTimestamp,
        "providerId": gig.providerId ?? "",
        "type": gig.type ?? "Not set",
        "access": gig.access ?? "public",
      }).then((docRef) {
        docRef.update({
          "gigId" : docRef.id,
        });
        print(docRef.id);
        fireStoreUsersRef.doc(gig.providerId).update({
          'createdGigs':
          FieldValue.arrayUnion([docRef.id]),
        });
      });
    } else {
      return null;
    }
  }

  Future userAccountOfCurrentUser() async {
    var result = await fireStoreGigsRef.doc(FirebaseAuth.instance.currentUser.uid).get();
    print(result.data());
  }

  List<Gig> _allGigDataFromSnapshot(QuerySnapshot snapshot) {
    return isLoggedIn()
        ? snapshot.docs.map((doc) {
            return Gig(
              gigId: doc.data()['gigId'],
              money: doc.data()['money'],
              location: doc.data()['location'],
              title: doc.data()['title'],
              description: doc.data()['description'],
              startTime: doc.data()['startTime'],
              endTime: doc.data()['endTime'],
              providerId: doc.data()['providerId'],
              type: doc.data()['type'],
            );
          }).toList()
        : null;
  }

  Gig _singleGigFromSnapshot(DocumentSnapshot snapshot) {
    return isLoggedIn()
        ? Gig(
            gigId: snapshot.data()['gigId'],
            money: snapshot.data()['money'],
            location: snapshot.data()['location'],
            title: snapshot.data()['title'],
            description: snapshot.data()['description'],
            startTime: snapshot.data()['startTime'],
            endTime: snapshot.data()['endTime'],
            providerId: snapshot.data()['providerId'],
            type: snapshot.data()['type'],
          )
        : null;
  }

  //TODO : Chenck for true return statement
  Future<bool> checkIfDataExists() async {
    print("Before logged in");
    if (isLoggedIn()) {
      print("After logged in");
      bool dataExist = false;
      await fireStoreGigsRef.doc(uid).get().then((onValue) {
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

  Stream<List<Gig>> get allGigData {
    return isLoggedIn() ? fireStoreGigsRef.snapshots().map(_allGigDataFromSnapshot) : null;
  }

  Stream<Gig> get selectedGigData {
    return isLoggedIn()
        ? fireStoreGigsRef.doc().snapshots().map(_singleGigFromSnapshot)
        : null;
  }
}
