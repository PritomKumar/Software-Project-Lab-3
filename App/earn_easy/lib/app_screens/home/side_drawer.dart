import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListTile(
          title: Text("Home"),
          onTap: () => Navigator.pushReplacementNamed(
            context,
            'gigs',
          ),
        ),
      ),
    );
  }
}
