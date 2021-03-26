import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: SafeArea(
        child: Scaffold(
          drawer: SideDrawer(),
          appBar: AppBar(
            title: Text('Notification'),
          ),
          body: Center(
            child: Container(
              child: Text('Notification'),
            ),
          ),
        ),
      ),
    );
  }
}
//
// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:earneasy/app_screens/home/side_drawer.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';
//
// class NotificationPage extends StatefulWidget {
//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }
//
//
// class _NotificationPageState extends State<NotificationPage> {
//   final Firestore _db = Firestore.instance;
//   final FirebaseMessaging _fcm = FirebaseMessaging();
//
//   StreamSubscription iosSubscription;
//
//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isIOS) {
//       iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
//         print(data);
//         _saveDeviceToken();
//       });
//
//       _fcm.requestNotificationPermissions(IosNotificationSettings());
//     } else {
//       _saveDeviceToken();
//     }
//
//     _fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print("onMessage: $message");
//         // final snackbar = SnackBar(
//         //   content: Text(message['notification']['title']),
//         //   action: SnackBarAction(
//         //     label: 'Go',
//         //     onPressed: () => null,
//         //   ),
//         // );
//
//         // Scaffold.of(context).showSnackBar(snackbar);
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             content: ListTile(
//               title: Text(message['notification']['title']),
//               subtitle: Text(message['notification']['body']),
//             ),
//             actions: <Widget>[
//               FlatButton(
//                 color: Colors.amber,
//                 child: Text('Ok'),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//             ],
//           ),
//         );
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print("onLaunch: $message");
//         // TODO optional
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print("onResume: $message");
//         // TODO optional
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     if (iosSubscription != null) iosSubscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // _handleMessages(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepOrange,
//         title: Text('FCM Push Notifications'),
//       ),
//     );
//   }
//
//   /// Get the token, save it to the database for current user
//   _saveDeviceToken() async {
//     // Get the current user
//     String uid = 'jeffd23';
//     // FirebaseUser user = await _auth.currentUser();
//
//     // Get the token for this device
//     String fcmToken = await _fcm.getToken();
//
//     // Save it to Firestore
//     if (fcmToken != null) {
//       var tokens = _db
//           .collection('users')
//           .document(uid)
//           .collection('tokens')
//           .document(fcmToken);
//
//       await tokens.setData({
//         'token': fcmToken,
//         'createdAt': FieldValue.serverTimestamp(), // optional
//         'platform': Platform.operatingSystem // optional
//       });
//     }
//   }
//
//   /// Subscribe the user to a topic
//   _subscribeToTopic() async {
//     // Subscribe the user to a topic
//     _fcm.subscribeToTopic('puppies');
//   }
// }
