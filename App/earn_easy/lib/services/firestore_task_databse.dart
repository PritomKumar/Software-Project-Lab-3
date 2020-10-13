import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class DatabaseServiceTasks {
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

  Future createNewGig(Gig gig, List<ImageTask> imageTaskList) async {
    if (isLoggedIn()) {
      return await fireStoreGigsRef.add(gig.toMap()).then((gigRef) {
        gigRef.update({
          "gigId": gigRef.id,
        });
        //Add Tasks
        if (imageTaskList != null) {
          for (var imageTask in imageTaskList) {
            gigRef.collection("Tasks").add(imageTask.toMap()).then((taskRef) {
              taskRef.update({
                "taskId": taskRef.id,
                "gigId": gigRef.id,
              });
              //Update TaskSnippet List in gig
              gigRef.update({
                'taskSnippetList': FieldValue.arrayUnion([
                  TaskSnippet(
                    taskId: taskRef.id,
                    taskDescription: imageTask.taskDescription,
                    taskType: imageTask.type,
                  ).toMap()
                ]),
              });
            });
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
            ).toMap()
          ]),
        }).then((value) {
          print("Add Gig to user created gig list ");
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

  ImageTask _singleImageTaskFromSnapshot(DocumentSnapshot snapshot) {
    return isLoggedIn() ? ImageTask.fromMap(snapshot.data()) : null;
  }

  Stream<List<Gig>> get allGigData {
    return isLoggedIn()
        ? fireStoreGigsRef.snapshots().map(_allGigDataFromSnapshot)
        : null;
  }

  Stream<ImageTask> selectedImageTaskData(Gig gig,TaskSnippet taskSnippet) {
    return isLoggedIn()
        ? fireStoreGigsRef
        .doc(gig.gigId)
        .collection("Tasks")
        .doc(taskSnippet.taskId)
        .snapshots().map((taskFromDocument) =>
        ImageTask.fromMap(taskFromDocument.data()))
        : null;
  }
}
