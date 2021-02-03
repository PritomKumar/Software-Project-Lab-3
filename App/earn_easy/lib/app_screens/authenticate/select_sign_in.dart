import 'package:earneasy/app_screens/authenticate/authenticate.dart';
import 'package:earneasy/services/auth.dart';
import 'package:earneasy/shared/ThemeChanger.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignInOptions extends StatefulWidget {
  @override
  _SignInOptionsState createState() => _SignInOptionsState();
}

class _SignInOptionsState extends State<SignInOptions> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return SafeArea(
      child: loading
          ? Loading()
          : MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: _themeChanger.getTheme(),
              home: Scaffold(
                body: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        gradient: LinearGradient(
                          colors: [Colors.blue[200], Colors.blue[500]],
                          begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 250.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.google,
                                color: Colors.redAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                              await _authService.signInWithGoogleAuth();
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                  "could not sign in to your google account";
                                });
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 250.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Sign in with Facebook",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {

                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 250.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.solidEnvelope,
                                color: Colors.greenAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Sign in with Email",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return AuthenticateWithEmail();
                                  },
                                ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}

