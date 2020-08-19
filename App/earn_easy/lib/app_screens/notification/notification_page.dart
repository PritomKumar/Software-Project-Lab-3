import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
    );
  }
}
