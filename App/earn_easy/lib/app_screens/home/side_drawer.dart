import 'package:earneasy/app_screens/home/home_dummy.dart';
import 'package:earneasy/app_screens/notification/notification_page.dart';
import 'package:earneasy/app_screens/profile/profile_page.dart';
import 'package:earneasy/app_screens/setting/setting_page.dart';
import 'package:earneasy/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAccount>(context);
    return Container(
      child: SafeArea(
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text(user.email),
                accountName: Text(
                  user.firstName + " " + user.lastName,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: user.photoUrl == ""
                      ? null
                      : NetworkImage(
                          user.photoUrl,
                        ),
                  child: user.photoUrl == ""
                      ? Text(
                          user.email[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                  backgroundColor: Colors.blue[600],
                  radius: 50.0,
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
