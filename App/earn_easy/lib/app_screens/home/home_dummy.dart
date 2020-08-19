import 'package:earneasy/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      routes: {
        'home' : (context) => Home(),
        'notification' : (context) => Home(),
        'profile' : (context) => Home(),
        'setting' : (context) => Home(),
      },
      home: Scaffold(

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