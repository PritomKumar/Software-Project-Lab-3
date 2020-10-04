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
      return fireStoreGigsRef.doc(gig.gigId).update(gig.toMap());
    } else {
      return null;
    }
  }

  Future createNewGig(Gig gig) {
    if (isLoggedIn()) {
      return fireStoreGigsRef.add(gig.toMap()).then((docRef) {
        docRef.update({
          "gigId": docRef.id,
        });
        print(docRef.id);
        fireStoreUsersRef.doc(gig.providerId).update({
          'createdGigs': FieldValue.arrayUnion([
            GigMini(gigId: gig.gigId, title: gig.title, money: gig.money)
                .toMap()
          ]),
        });
      });
    } else {
      return null;
    }
  }

  Future userAccountOfCurrentUser() async {
    var result =
        await fireStoreGigsRef.doc(FirebaseAuth.instance.currentUser.uid).get();
    print(result.data());
  }

  List<Gig> _allGigDataFromSnapshot(QuerySnapshot snapshot) {
    return isLoggedIn()
        ? List.from(snapshot.docs.map((index) => Gig.fromMap(index.data())))
        : null;
  }

  Gig _singleGigFromSnapshot(DocumentSnapshot snapshot) {
    return isLoggedIn() ? Gig.fromMap(snapshot.data()) : null;
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
    return isLoggedIn()
        ? fireStoreGigsRef.snapshots().map(_allGigDataFromSnapshot)
        : null;
  }

  Stream<Gig> get selectedGigData {
    return isLoggedIn()
        ? fireStoreGigsRef.doc().snapshots().map(_singleGigFromSnapshot)
        : null;
  }
}
