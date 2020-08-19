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
      child: SafeArea(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text("example@gmail.com"),
                accountName: Text("Name"),
                currentAccountPicture: CircleAvatar(
                  child: Text(
                    "P",
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.blue[600],
                ),
                otherAccountsPictures: <Widget>[
                  CircleAvatar(
                    child: Text(
                      "P",
                    ),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
              ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Gigs()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text("My Profile"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.notifications_active),
                title: Text("Notifications"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Setting()));
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
