import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServiceNotification {
  final CollectionReference fireStoreNotificationRef =
      FirebaseFirestore.instance.collection("notification");
  final String uid = FirebaseAuth.instance.currentUser.uid;

  bool isLoggedIn() {
    if (uid != null) {
      return true;
    } else {
      return false;
    }
  }

  List<NotificationMessage> _noticationList = <NotificationMessage>[];

  Future<List<NotificationMessage>> getAllNotification() async {
    var _list = await fireStoreNotificationRef.doc(uid).get().then((value) {
      return value;
    });
    var result = List.from(_list.data()['messages']);

    for (int i = 0; i < result.length; i++) {
      _noticationList.add(NotificationMessage.fromMap(result[i]));
      print("message $i");
      print(_noticationList[i].toMap());
    }

    return _noticationList;
  }
}
