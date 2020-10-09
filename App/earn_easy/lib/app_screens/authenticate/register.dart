import 'package:earneasy/services/auth.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String error = "";

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.blue[100],
              appBar: AppBar(
                backgroundColor: Colors.blue[400],
                elevation: 0.0,
                title: Text("Registration Page"),
                actions: <Widget>[
                  FlatButton.icon(
                      onPressed: () {
                        widget.toggleView();
                      },
                      icon: Icon(Icons.person),
                      label: Text("Sign In")),
                ],
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: emailInputDecoration,
                        validator: (value) {
                          return value.isEmpty ? "Enter a email" : null;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: passwordInputDecoration.copyWith(
                            hintText: "Password",
                            suffixIcon: IconButton(
                              icon: hidePassword
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                    ),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            )),
                        validator: (value) {
                          return value.length < 6
                              ? "Enter a password  6 + chars long"
                              : null;
                        },
                        obscureText: hidePassword,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _authService.registerWithEmailAndPassword(
                                    emailController.text.trim(),
                                    passwordController.text.trim());
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = "Please supply a valid email";
                              });
                            } else {
                              setState(() {
                                loading = false;
                                Navigator.pop(context);
                              });
                            }
                          }
                        },
                      ),
                      Text(
                        error,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
