import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
 // TODO : Complete the UI
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return StreamBuilder<UserAccount>(
        stream: DatabaseService().userData,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            var user = snapshot.data;
            firstNameController.text = user.name.substring(0, user.name.indexOf(" "));
            lastNameController.text = user.name.substring(user.name.indexOf(" ") + 1);
            emailController.text = user.email;
               return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Scaffold(
                    drawer: SideDrawer(),
                    appBar: AppBar(
                      title: Text('Profile'),
                    ),
                    body: Form(
                      key: _formKey,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: ListView(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "First Name :",
                                    style: TextStyle(fontSize: size.width / 25),
                                  ),
                                  SizedBox(
                                    width: size.width / 40,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: firstNameController,
                                      decoration: InputDecoration(
                                          hintText: "First Name"),
                                      validator: (value) {
                                        return value.isEmpty
                                            ? "Enter First Name"
                                            : null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Last Name :",
                                    style: TextStyle(fontSize: size.width / 25),
                                  ),
                                  SizedBox(
                                    width: size.width / 40,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: lastNameController,
                                      decoration: InputDecoration(
                                          hintText: "Last Name"),
                                      validator: (value) {
                                        return value.isEmpty
                                            ? "Enter Last Name"
                                            : null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "Email :",
                                    style: TextStyle(fontSize: size.width / 25),
                                  ),
                                  SizedBox(
                                    width: size.width / 40,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          hintText: "Email"),
                                      validator: (value) {
                                        return value.isEmpty
                                            ? "Enter Email"
                                            : null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              RaisedButton(
                                color: Colors.pink[400],
                                child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  // TODO : Complete UserAccount (Major Important)
                                  if(_formKey.currentState.validate()){
                                    await DatabaseService().updateUserData(UserAccount(
                                      name: (firstNameController.text + " " + lastNameController.text) ?? user.name,
                                      email: emailController.text ?? user.email,
                                    ));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );}
          else{
            return Loading();
          }

        });
  }
}
