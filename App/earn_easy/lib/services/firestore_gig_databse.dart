import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

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
      return fireStoreGigsRef.doc(gig.gigId).set(gig.toMap());
    } else {
      return null;
    }
  }

  //<editor-fold desc="Old version of createNewGig">
  // Future createNewGig(Gig gig, List<ImageTask> imageTaskList) async {
  //   if (isLoggedIn()) {
  //     return await fireStoreGigsRef.add(gig.toMap()).then((gigRef) {
  //       gigRef.update({
  //         "gigId": gigRef.id,
  //       });
  //       //Add Tasks
  //       if (imageTaskList != null) {
  //         for (var imageTask in imageTaskList) {
  //           gigRef.collection("Tasks").add(imageTask.toMap()).then((taskRef) {
  //             taskRef.update({
  //               "taskId": taskRef.id,
  //               "gigId": gigRef.id,
  //             });
  //             //Update TaskSnippet List in gig
  //             gigRef.update({
  //               'taskSnippetList': FieldValue.arrayUnion([
  //                 TaskSnippet(
  //                   taskId: taskRef.id,
  //                   taskDescription: imageTask.taskDescription,
  //                   taskType: imageTask.type,
  //                 ).toMap()
  //               ]),
  //             });
  //           });
  //         }
  //       }
  //       //Checking gig provider Id
  //       print("After gig create and gigId update");
  //       print("Provider id = ${gig.providerId}");
  //
  //       print(gigRef.id);
  //       fireStoreUsersRef.doc(gig.providerId).update({
  //         'createdGigs': FieldValue.arrayUnion([
  //           GigMini(
  //             gigId: gigRef.id,
  //             title: gig.title,
  //             money: gig.money,
  //           ).toMap()
  //         ]),
  //       }).then((value) {
  //         print("Add Gig to user created gig list ");
  //       });
  //     });
  //   } else {
  //     return null;
  //   }
  // }
  //</editor-fold>

  Future createNewGig(Gig gig, List<dynamic> taskList) async {
    if (isLoggedIn()) {
      return await fireStoreGigsRef.add(gig.toMap()).then((gigRef) {
        gigRef.update({
          "gigId": gigRef.id,
        });
        //Add Tasks
        if (taskList != null) {
          for (var newTask in taskList) {
            if (newTask != null) {
              gigRef.collection("Tasks").add(newTask.toMap()).then((taskRef) {
                taskRef.update({
                  "taskId": taskRef.id,
                  "gigId": gigRef.id,
                });
                //Update TaskSnippet List in gig
                gigRef.update({
                  'taskSnippetList': FieldValue.arrayUnion([
                    TaskSnippet(
                      taskId: taskRef.id,
                      taskDescription: newTask.taskDescription,
                      taskType: newTask.type,
                      require: newTask.require,
                    ).toMap()
                  ]),
                });
              });
            }
          }
        }
        //Checking gig provider Id
        print("After gig create and gigId update");
        print("Provider id = ${gig.providerId}");

        print(gigRef.id);
        fireStoreUsersRef.doc(gig.providerId).update({
          'createdGigs': FieldValue.arrayUnion([
            GigMini(
              gigId: gigRef.id,
              title: gig.title,
              money: gig.money,
              //location: gig.location,
              location:
                  GeoFirePoint(gig.location.latitude, gig.location.longitude),
            ).toMap()
          ]),
        }).then((value) {
          print("Add GigMini to user's created gig list ");
        });
      });
    } else {
      return null;
    }
  }

  Future updateAttemptedUserInGig(Gig gig) async {
    try {
      await fireStoreGigsRef.doc(gig.gigId).update({
        'attemptedUsers': FieldValue.arrayUnion([userUid])
      }).then((value) {
        print("Attempted user updated with $userUid");
      });
    } catch (e) {
      print("Attempted user update failed $e");
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

  Future<Gig> getGigFromGigID(String gigId) async {
    return await fireStoreGigsRef.doc(gigId).get().then((value) {
      return Gig.fromMap(value.data());
    });
  }

  //TODO : Check for true return statement
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
