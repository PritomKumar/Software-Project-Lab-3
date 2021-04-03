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
    if (!_list.exists) {
      _noticationList = [];
    } else {
      var result = List.from(_list.data()['messages']);

      for (int i = 0; i < result.length; i++) {
        _noticationList.add(NotificationMessage.fromMap(result[i]));
        print("message $i");
        print(_noticationList[i].toMap());
      }
    }

    return _noticationList;
  }

  Future deleteNotification(List<NotificationMessage> notificationList) async {
    List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
    for (int i = 0; i < notificationList.length; i++) {
      result.add(notificationList[i].toMap());
      print("message $i");
      print(result);
    }
    await fireStoreNotificationRef.doc(uid).set({
      "messages": result,
    });
    return;
  }
}
