import 'package:earneasy/app_screens/authenticate/authenticate.dart';
import 'package:earneasy/app_screens/authenticate/sign_in.dart';
import 'package:earneasy/services/auth.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';

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
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Choose Sign in option"),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.orange[400],
                            child: Text(
                              "Google Sign In",
                              style: TextStyle(color: Colors.white),
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
                          RaisedButton(
                            color: Colors.blue[400],
                            child: Text(
                              "Sign In with Email",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return Authenticate();
                              },));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
