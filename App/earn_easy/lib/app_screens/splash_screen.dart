import 'dart:async';

import 'file:///F:/IIT%207th%20Semester/SPL3/Software-Project-Lab-3/App/earn_easy/lib/app_screens/home/login_screen.dart';
import 'package:earneasy/app_screens/search_screen_loader.dart';
import 'package:earneasy/app_screens/wrapper.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 1),
      () {
        debugPrint("TODO splash screen done");
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Wrapper();
          },
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: theme.primaryColorLight,
              gradient: LinearGradient(
                colors: [Colors.blue[100], Colors.blue[500]],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.monetization_on,
                          color: Colors.greenAccent,
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "earnEasy",
                        textDirection: TextDirection.ltr,
                        style: theme.textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: Colors.blue[200],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "A Mobile Crowd Sourcing Platform",
                      textDirection: TextDirection.ltr,
                      style: theme.textTheme.subtitle1,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
