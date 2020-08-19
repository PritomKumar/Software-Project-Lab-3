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
              onTap: () => Navigator.pushReplacementNamed(
                context,
                'gigs',
              ),
            ),
            ListTile(
              title: Text("My Profile"),
              onTap: () => Navigator.pushNamed(
                context,
                'profile',
              ),
            ),
            ListTile(
              title: Text("Notifications"),
              onTap: () => Navigator.pushNamed(
                context,
                'notification',
              ),
            ),
            ListTile(
              title: Text("Settings"),
              onTap: () => Navigator.pushNamed(
                context,
                'setting',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
