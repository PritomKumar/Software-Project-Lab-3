import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
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
    var user = Provider.of<UserAccount>(context);
    firstNameController.text = user.name;
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
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                          decoration: InputDecoration(hintText: "First Name"),
                          validator: (value) {
                            return value.isEmpty ? "Enter First Name" : null;
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
                          controller: firstNameController,
                          decoration: InputDecoration(hintText: "First Name"),
                          validator: (value) {
                            return value.isEmpty ? "Enter First Name" : null;
                          },
                        ),
                      ),
                    ],
                  ),
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
                          decoration: InputDecoration(hintText: "First Name"),
                          validator: (value) {
                            return value.isEmpty ? "Enter First Name" : null;
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
                    onPressed: () async{

                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
