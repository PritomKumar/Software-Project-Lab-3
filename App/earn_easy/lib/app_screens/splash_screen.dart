import 'dart:async';

import 'package:earneasy/app_screens/login_screen.dart';
import 'package:earneasy/app_screens/search_screen_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      Duration(seconds: 3),
      () {
        debugPrint("TODO splash screen done");
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
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
                colors: [Colors.red,Colors.orange],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
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
                      backgroundColor: Colors.redAccent,
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
