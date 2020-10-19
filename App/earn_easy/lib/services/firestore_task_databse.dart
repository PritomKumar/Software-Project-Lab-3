import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/location_service.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future _createTaskListInUserResponse(Gig gig) async {
    try {
      QuerySnapshot querySnapshot =
          await fireStoreGigsRef.doc(gig.gigId).collection("Tasks").get();
      var docTaskList = querySnapshot.docs;

      var userResponseTasksGigCollectionRef = fireStoreGigsRef
          .doc(gig.gigId)
          .collection("UserResponse")
          .doc(userUid)
          .collection("Tasks");

      for (int i = 0; i < querySnapshot.docs.length; i++) {
        userResponseTasksGigCollectionRef
            .doc(querySnapshot.docs[i].id)
            .set(querySnapshot.docs[i].data())
            .then((_) {
          print("Add data of task ${querySnapshot.docs[i].id} successful");
        });
      }
    } catch (e) {
      print("Create TaskList in user response failed $e");
    }
  }

  Future createUserResponseForAttemptedUser(Gig gig) async {
    try {
      await fireStoreGigsRef
          .doc(gig.gigId)
          .collection("UserResponse")
          .doc(userUid)
          .set(UserResponse(
        userId: userUid,
            taskSnippetList: gig.taskSnippetList,
            completedTaskCount: 0,
            distance: LocationService()
                .calculateDistanceGigAndUserCurrentLocation(gig.location),
          ).toMap())
          .then((_) {
        print("Create UserResponse for AttemptedUser $userUid is a success");
      });

      await _createTaskListInUserResponse(gig);
    } catch (e) {
      print("Create UserResponse for AttemptedUser failed $e");
    }
  }

  //<editor-fold desc="Single task getter">
  ImageTask _singleImageTaskFromSnapshot(DocumentSnapshot snapshot) {
    return isLoggedIn() ? ImageTask.fromMap(snapshot.data()) : null;
  }

  CheckboxTask _singleCheckboxTaskFromSnapshot(DocumentSnapshot snapshot) {
    return isLoggedIn() ? CheckboxTask.fromMap(snapshot.data()) : null;
  }

  MultipleChoiceTask _singleMultipleChoiceTaskFromSnapshot(
      DocumentSnapshot snapshot) {
    return isLoggedIn() ? MultipleChoiceTask.fromMap(snapshot.data()) : null;
  }

  DropdownTask _singleDropdownTaskFromSnapshot(DocumentSnapshot snapshot) {
    return isLoggedIn() ? DropdownTask.fromMap(snapshot.data()) : null;
  }

  FreeTextTask _singleFreeTextTaskFromSnapshot(DocumentSnapshot snapshot) {
    return isLoggedIn() ? FreeTextTask.fromMap(snapshot.data()) : null;
  }

  //</editor-fold>

  //<editor-fold desc="Stream<Task> getter">
  Stream<ImageTask> selectedImageTaskData(Gig gig, TaskSnippet taskSnippet) {
    if (isLoggedIn()) {
      try {
        return fireStoreGigsRef
            .doc(gig.gigId)
            .collection("UserResponse")
            .doc(userUid)
            .collection("Tasks")
            .doc(taskSnippet.taskId)
            .snapshots()
            .map((taskFromDocument) =>
                ImageTask.fromMap(taskFromDocument.data()));
      } catch (e) {
        print("Image task finding exception = ${e.toString()}");
        return null;
      }
    } else {
      return null;
    }
  }

  Stream<CheckboxTask> selectedCheckboxTaskData(
      Gig gig, TaskSnippet taskSnippet) {
    return isLoggedIn()
        ? fireStoreGigsRef
            .doc(gig.gigId)
            .collection("UserResponse")
            .doc(userUid)
            .collection("Tasks")
            .doc(taskSnippet.taskId)
            .snapshots()
            .map((taskFromDocument) =>
                CheckboxTask.fromMap(taskFromDocument.data()))
        : null;
  }

  Stream<MultipleChoiceTask> selectedMultipleChoiceTaskData(
      Gig gig, TaskSnippet taskSnippet) {
    return isLoggedIn()
        ? fireStoreGigsRef
            .doc(gig.gigId)
            .collection("UserResponse")
            .doc(userUid)
            .collection("Tasks")
            .doc(taskSnippet.taskId)
            .snapshots()
            .map((taskFromDocument) =>
                MultipleChoiceTask.fromMap(taskFromDocument.data()))
        : null;
  }

  Stream<DropdownTask> selectedDropdownTaskData(
      Gig gig, TaskSnippet taskSnippet) {
    return isLoggedIn()
        ? fireStoreGigsRef
            .doc(gig.gigId)
            .collection("UserResponse")
            .doc(userUid)
            .collection("Tasks")
            .doc(taskSnippet.taskId)
            .snapshots()
            .map((taskFromDocument) =>
                DropdownTask.fromMap(taskFromDocument.data()))
        : null;
  }

  Stream<FreeTextTask> selectedFreeTextTaskData(
      Gig gig, TaskSnippet taskSnippet) {
    return isLoggedIn()
        ? fireStoreGigsRef
            .doc(gig.gigId)
            .collection("UserResponse")
            .doc(userUid)
            .collection("Tasks")
            .doc(taskSnippet.taskId)
            .snapshots()
            .map((taskFromDocument) =>
                FreeTextTask.fromMap(taskFromDocument.data()))
        : null;
  }

//</editor-fold>

  //<editor-fold desc="Update all type of task">
  Future updateImageTask(ImageTask _imageTask) async {
    try {
      await fireStoreGigsRef
          .doc(_imageTask.gigId)
          .collection("UserResponse")
          .doc(userUid)
          .collection("Tasks")
          .doc(_imageTask.taskId)
          .set(_imageTask.toMap())
          .then((_) => print(
              "ImageTask update of task id ${_imageTask.taskId} successful"));
    } catch (e) {
      print("ImageTask update of task id ${_imageTask.taskId} failed");
    }
  }

  Future updateCheckboxTask(CheckboxTask _checkboxTask) async {
    try {
      await fireStoreGigsRef
          .doc(_checkboxTask.gigId)
          .collection("UserResponse")
          .doc(userUid)
          .collection("Tasks")
          .doc(_checkboxTask.taskId)
          .set(_checkboxTask.toMap())
          .then((_) => print(
              "CheckboxTask update of task id ${_checkboxTask.taskId} successful"));
    } catch (e) {
      print("CheckboxTask update of task id ${_checkboxTask.taskId} failed");
    }
  }

  Future updateMultipleChoiceTask(
      MultipleChoiceTask _multipleChoiceTask) async {
    try {
      await fireStoreGigsRef
          .doc(_multipleChoiceTask.gigId)
          .collection("UserResponse")
          .doc(userUid)
          .collection("Tasks")
          .doc(_multipleChoiceTask.taskId)
          .set(_multipleChoiceTask.toMap())
          .then((_) => print(
              "MultipleChoiceTask update of task id ${_multipleChoiceTask.taskId} successful"));
    } catch (e) {
      print(
          "MultipleChoiceTask update of task id ${_multipleChoiceTask.taskId} failed");
    }
  }

  Future updateDropdownTask(DropdownTask _dropdownTask) async {
    try {
      await fireStoreGigsRef
          .doc(_dropdownTask.gigId)
          .collection("UserResponse")
          .doc(userUid)
          .collection("Tasks")
          .doc(_dropdownTask.taskId)
          .set(_dropdownTask.toMap())
          .then((_) => print(
              "DropdownTask update of task id ${_dropdownTask.taskId} successful"));
    } catch (e) {
      print("DropdownTask update of task id ${_dropdownTask.taskId} failed");
    }
  }

  Future updateFreeTextTask(FreeTextTask _freeTextTask) async {
    try {
      await fireStoreGigsRef
          .doc(_freeTextTask.gigId)
          .collection("UserResponse")
          .doc(userUid)
          .collection("Tasks")
          .doc(_freeTextTask.taskId)
          .set(_freeTextTask.toMap())
          .then((_) => print(
              "FreeTextTask update of task id ${_freeTextTask.taskId} successful"));
    } catch (e) {
      print("FreeTextTask update of task id ${_freeTextTask.taskId} failed");
    }
  }
//</editor-fold>

}
