import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/app_screens/notification/notification_page.dart';
import 'package:earneasy/app_screens/profile/profile_page.dart';
import 'package:earneasy/app_screens/setting/setting_page.dart';
import 'package:earneasy/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: 'gigs',
      routes: {
        'gigs' : (context) => Gigs(),
        'notification' : (context) => NotificationPage(),
        'profile' : (context) => Profile(),
        'setting' : (context) => Setting(),
      },

    );
  }
}

class Gigs extends StatefulWidget {
  @override
  _GigsState createState() => _GigsState();
}

class _GigsState extends State<Gigs> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Logout"),
              onPressed: () async {
                await _authService.signOut();
              },
            )
          ],
        ),
        body: Center(
          child: Container(
            child: Text('Home Screen'),
          ),
        ),
      ),
    );
  }
}
