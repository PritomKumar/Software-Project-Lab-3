import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthenticateState();
  }

}

class _AuthenticateState extends State<Authenticate>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text("Authenticate Todo"),
      ),
    );
  }

}