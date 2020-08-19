import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: Container(
            child: Text('Profile'),
          ),
        ),
      ),
    );
  }
}
