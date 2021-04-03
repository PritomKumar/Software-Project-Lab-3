import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/models/notification.dart';
import 'package:earneasy/services/firebase_notification_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  final List<NotificationMessage> notificationList;

  const NotificationPage({Key key, this.notificationList}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  List<Message> _messagesList = <Message>[];
  final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  _getToken() {
    _firebaseMessaging.getToken().then((token) {
      print("Device token = $token");
    });
  }

  _getPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  _configureFirebaseListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      // _setMessage(message);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => NotificationPage()));
      print(
          "On Message notification = ${notification.title}  and android = ${android.channelId}");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // _setMessage(message);

      navigatorKey.currentState.push(MaterialPageRoute(
          builder: (_) => NotificationPage(
                notificationList: widget.notificationList,
              )));
      print('A new onMessageOpenedApp event was published! ${message.data}');
    });
    // FirebaseMessaging.onBackgroundMessage((RemoteMessage message) {
    //   _setMessage(message);
    //   print(' onBackgroundMessage ${message.data}');
    //
    //   return Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => NotificationPage()));
    // });
  }

  _setMessage(RemoteMessage message) {
    final notification = message.notification;
    final data = message.data;
    final String title = notification.title;
    final String body = notification.body;
    final String mMessage = data.toString();
    setState(() {
      Message m = Message(title: title, body: body, message: mMessage);
      _messagesList.add(m);
    });
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
    _getToken();
    _configureFirebaseListeners();
  }

  Future<bool> _onWillPop() async {
    await DatabaseServiceNotification()
        .deleteNotification(widget.notificationList);
    Navigator.pop(context);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      home: SafeArea(
        child: Scaffold(
          drawer: SideDrawer(),
          appBar: AppBar(
            title: Text("Notification"),
          ),
          body: widget.notificationList.length == 0
              ? Container(
                  alignment: Alignment.center,
                  child: Text(
                    "No Notification!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.notificationList == null
                      ? 0
                      : widget.notificationList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var reverseIndex =
                        widget.notificationList.length - index - 1;
                    // print("reverseIndex = $reverseIndex");
                    return Dismissible(
                      // Show a red background as the item is swiped away.
                      background: Container(color: Colors.grey[200]),
                      key: UniqueKey(),
                      confirmDismiss: (direction) async {
                        await DatabaseServiceNotification()
                            .deleteNotification(widget.notificationList);
                        return true;
                      },
                      onDismissed: (direction) async {
                        // added this block

                        setState(() {
                          var deletedItem =
                              widget.notificationList.removeAt(reverseIndex);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("${deletedItem.title} dismissed"),
                            action: SnackBarAction(
                                label: "UNDO",
                                onPressed: () => setState(
                                      () => widget.notificationList
                                          .insert(reverseIndex, deletedItem),
                                    ) // this is what you needed
                                ),
                          ));
                        });
                      },

                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        elevation: 5.0,
                        shadowColor: Colors.black54,
                        child: ListTile(
                          title: Text(
                            widget.notificationList[reverseIndex].title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),
                          subtitle: Text(
                            widget.notificationList[reverseIndex].body,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

class Message {
  final String title;
  final String body;
  final String message;

  Message({
    @required this.title,
    @required this.body,
    @required this.message,
  });

  Message.fromMap(Map<String, dynamic> data)
      : this.title = data["notification"]['title'],
        this.body = data["notification"]["body"],
        this.message = data["data"]["message"];

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'body': this.body,
      'message': this.message,
    };
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
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
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

//
// import 'dart:async';
// import 'dart:convert';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import 'message.dart';
// import 'message_list.dart';
// import 'permissions.dart';
// import 'token_monitor.dart';
//
// /// Entry point for the example application.
// class MessagingExampleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Messaging Example App',
//       theme: ThemeData.dark(),
//       routes: {
//         '/': (context) => Application(),
//         '/message': (context) => MessageView(),
//       },
//     );
//   }
// }
//
// // Crude counter to make messages unique
// int _messageCount = 0;
//
// /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
// String constructFCMPayload(String token) {
//   _messageCount++;
//   return jsonEncode({
//     'token': token,
//     'data': {
//       'via': 'FlutterFire Cloud Messaging!!!',
//       'count': _messageCount.toString(),
//     },
//     'notification': {
//       'title': 'Hello FlutterFire!',
//       'body': 'This notification (#$_messageCount) was created via FCM!',
//     },
//   });
// }
//
// /// Renders the example application.
// class Application extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _Application();
// }
//
// class _Application extends State<Application> {
//   String _token;
//
//   @override
//   void initState() {
//     super.initState();
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage message) {
//       if (message != null) {
//         Navigator.pushNamed(context, '/message',
//             arguments: MessageArguments(message, true));
//       }
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification notification = message.notification;
//       AndroidNotification android = message.notification?.android;
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title,
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 channel.description,
//                 // TODO add a proper drawable resource to android, for now using
//                 //      one that already exists in example app.
//                 icon: 'launch_background',
//               ),
//             ));
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       Navigator.pushNamed(context, '/message',
//           arguments: MessageArguments(message, true));
//     });
//   }
//
//   Future<void> sendPushMessage() async {
//     if (_token == null) {
//       print('Unable to send FCM message, no token exists.');
//       return;
//     }
//
//     try {
//       await http.post(
//         Uri.parse('https://api.rnfirebase.io/messaging/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: constructFCMPayload(_token),
//       );
//       print('FCM request for device sent!');
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> onActionSelected(String value) async {
//     switch (value) {
//       case 'subscribe':
//         {
//           print(
//               'FlutterFire Messaging Example: Subscribing to topic "fcm_test".');
//           await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
//           print(
//               'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.');
//         }
//         break;
//       case 'unsubscribe':
//         {
//           print(
//               'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".');
//           await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
//           print(
//               'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.');
//         }
//         break;
//       case 'get_apns_token':
//         {
//           if (defaultTargetPlatform == TargetPlatform.iOS ||
//               defaultTargetPlatform == TargetPlatform.macOS) {
//             print('FlutterFire Messaging Example: Getting APNs token...');
//             String token = await FirebaseMessaging.instance.getAPNSToken();
//             print('FlutterFire Messaging Example: Got APNs token: $token');
//           } else {
//             print(
//                 'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
//           }
//         }
//         break;
//       default:
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cloud Messaging'),
//         actions: <Widget>[
//           PopupMenuButton(
//             onSelected: onActionSelected,
//             itemBuilder: (BuildContext context) {
//               return [
//                 const PopupMenuItem(
//                   value: 'subscribe',
//                   child: Text('Subscribe to topic'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'unsubscribe',
//                   child: Text('Unsubscribe to topic'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'get_apns_token',
//                   child: Text('Get APNs token (Apple only)'),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: Builder(
//         builder: (context) => FloatingActionButton(
//           onPressed: sendPushMessage,
//           backgroundColor: Colors.white,
//           child: const Icon(Icons.send),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           MetaCard('Permissions', Permissions()),
//           MetaCard('FCM Token', TokenMonitor((token) {
//             _token = token;
//             return token == null
//                 ? const CircularProgressIndicator()
//                 : Text(token, style: const TextStyle(fontSize: 12));
//           })),
//           MetaCard('Message Stream', MessageList()),
//         ]),
//       ),
//     );
//   }
// }
//
// /// UI Widget for displaying metadata.
// class MetaCard extends StatelessWidget {
//   final String _title;
//   final Widget _children;
//
//   // ignore: public_member_api_docs
//   MetaCard(this._title, this._children);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: double.infinity,
//         margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
//         child: Card(
//             child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(children: [
//                   Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       child:
//                       Text(_title, style: const TextStyle(fontSize: 18))),
//                   _children,
//                 ]))));
//   }
// }
