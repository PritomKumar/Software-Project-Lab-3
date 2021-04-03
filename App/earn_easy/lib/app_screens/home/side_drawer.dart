import 'package:earneasy/app_screens/map/google_map_gig.dart';
import 'package:earneasy/app_screens/notification/notification_page.dart';
import 'package:earneasy/app_screens/profile/profile_page.dart';
import 'package:earneasy/app_screens/setting/setting_page.dart';
import 'package:earneasy/app_screens/theme/theme_selector.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firebase_notification_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// import 'file:///F:/IIT%207th%20Semester/SPL3/Software-Project-Lab-3/App/earn_easy/lib/app_screens/map/google_map_gig.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserMinimum>(context);
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
                      context, MaterialPageRoute(builder: (context) => GoogleMaps()));
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
                onTap: () async {
                  var notificationList =
                      await DatabaseServiceNotification().getAllNotification();
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage(
                                notificationList: notificationList,
                              )));
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
              ListTile(
                leading: Icon(FontAwesomeIcons.themeco),
                title: Text("Themes"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ThemeSelector()));
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
