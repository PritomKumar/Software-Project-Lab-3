import 'package:earneasy/app_screens/authenticate/register.dart';
import 'package:earneasy/app_screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthenticateState();
  }
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    return showSignIn ? SignIn(toggleView : toggleView) : Register(toggleView : toggleView);
  }
}
