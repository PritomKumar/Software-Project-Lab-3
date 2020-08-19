import 'package:earneasy/app_screens/home/home_dummy.dart';
import 'package:earneasy/app_screens/notification/notification_page.dart';
import 'package:earneasy/app_screens/profile/profile_page.dart';
import 'package:earneasy/app_screens/setting/setting_page.dart';
import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Gigs()));
              },
            ),
            ListTile(
              title: Text("My Profile"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              title: Text("Notifications"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
              },
            ),
            ListTile(
              title: Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Setting()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
