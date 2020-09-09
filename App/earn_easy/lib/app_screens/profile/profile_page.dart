import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_user_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  // TODO : Complete the UI
  @override
  _ProfileState createState() => _ProfileState();
}

//class _ProfileState extends State<Profile> {
//  final _formKey = GlobalKey<FormState>();
//  var emailController = TextEditingController();
//  var passwordController = TextEditingController();
//  var firstNameController = TextEditingController();
//  var lastNameController = TextEditingController();
//  bool isloading = false;
//
//  @override
//  Widget build(BuildContext context) {
//    var size = MediaQuery.of(context).size;
//
//    return StreamBuilder<UserAccount>(
//        stream: DatabaseService().userData,
//        builder: (context, snapshot) {
//
//          if (snapshot.hasData){
//            var user = snapshot.data;
//            firstNameController.text = user.name.substring(0, user.name.indexOf(" "));
//            lastNameController.text = user.name.substring(user.name.indexOf(" ") + 1);
//            emailController.text = user.email;
//               return MaterialApp(
//                  debugShowCheckedModeBanner: false,
//                  home: Scaffold(
//                    drawer: SideDrawer(),
//                    appBar: AppBar(
//                      title: Text('Profile'),
//                    ),
//                    body: Form(
//                      key: _formKey,
//                      child: Center(
//                        child: Container(
//                          padding: EdgeInsets.symmetric(
//                              vertical: 10.0, horizontal: 20.0),
//                          child: ListView(
//                            children: <Widget>[
//                              Row(
//                                children: <Widget>[
//                                  Text(
//                                    "First Name :",
//                                    style: TextStyle(fontSize: size.width / 25),
//                                  ),
//                                  SizedBox(
//                                    width: size.width / 40,
//                                  ),
//                                  Expanded(
//                                    child: TextFormField(
//                                      controller: firstNameController,
//                                      decoration: InputDecoration(
//                                          hintText: "First Name"),
//                                      validator: (value) {
//                                        return value.isEmpty
//                                            ? "Enter First Name"
//                                            : null;
//                                      },
//                                    ),
//                                  ),
//                                ],
//                              ),
//                              Row(
//                                children: <Widget>[
//                                  Text(
//                                    "Last Name :",
//                                    style: TextStyle(fontSize: size.width / 25),
//                                  ),
//                                  SizedBox(
//                                    width: size.width / 40,
//                                  ),
//                                  Expanded(
//                                    child: TextFormField(
//                                      controller: lastNameController,
//                                      decoration: InputDecoration(
//                                          hintText: "Last Name"),
//                                      validator: (value) {
//                                        return value.isEmpty
//                                            ? "Enter Last Name"
//                                            : null;
//                                      },
//                                    ),
//                                  ),
//                                ],
//                              ),
//                              Row(
//                                children: <Widget>[
//                                  Text(
//                                    "Email :",
//                                    style: TextStyle(fontSize: size.width / 25),
//                                  ),
//                                  SizedBox(
//                                    width: size.width / 40,
//                                  ),
//                                  Expanded(
//                                    child: TextFormField(
//                                      controller: emailController,
//                                      decoration: InputDecoration(
//                                          hintText: "Email"),
//                                      validator: (value) {
//                                        return value.isEmpty
//                                            ? "Enter Email"
//                                            : null;
//                                      },
//                                    ),
//                                  ),
//                                ],
//                              ),
//                              RaisedButton(
//                                color: Colors.pink[400],
//                                child: Text(
//                                  "Update",
//                                  style: TextStyle(color: Colors.white),
//                                ),
//                                onPressed: () async {
//                                  // TODO : Complete UserAccount
//                                  setState(() {
//                                    isloading = snapshot.hasData;
//                                  });
//                                  if(_formKey.currentState.validate()){
//                                    await DatabaseService().updateUserData(UserAccount(
//                                      name: (firstNameController.text + " " + lastNameController.text) ?? user.name,
//                                      email: emailController.text ?? user.email,
//                                      photoUrl:  user.photoUrl,
//                                      phoneNumber:  user.phoneNumber,
//                                      birthDay:  user.birthDay,
//                                      gender:  user.gender,
//                                      streetAddress:  user.streetAddress,
//                                      city:  user.city,
//                                      state:  user.state,
//                                      zipCode:  user.zipCode,
//                                      bio:  user.bio,
//                                      occupation:  user.occupation,
//                                      maritalStatus:  user.maritalStatus,
//                                      educationLevel:  user.educationLevel,
//                                      employmentStatus:  user.employmentStatus,
//                                      householdIncome:  user.householdIncome,
//                                      level:  user.level,
//                                      type:  user.type,
//                                      writeAccess:  user.writeAccess,
//
//                                    ));
//                                  }
//                                },
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                );}
//          else{
//            return Loading();
//          }
//
//        });
//  }
//}

//class _ProfileState extends State<Profile> {
//  final _formKey = GlobalKey<FormState>();
//  var emailController = TextEditingController();
//  var passwordController = TextEditingController();
//  var firstNameController = TextEditingController();
//  var lastNameController = TextEditingController();
//  bool isloading = false;
//
//  @override
//  Widget build(BuildContext context) {
//    var size = MediaQuery.of(context).size;
//    var user = Provider.of<UserAccount>(context);
//    setState(() {
//      if (user != null) {
//        isloading = true;
//      }
//    });
//
//    if (isloading) {
//      firstNameController.text = user.firstName;
//      lastNameController.text = user.lastName;
//      emailController.text = user.email;
//
//      return MaterialApp(
//        debugShowCheckedModeBanner: false,
//        home: Scaffold(
//          drawer: SideDrawer(),
//          appBar: AppBar(
//            title: Text('Profile'),
//          ),
//          body: Form(
//            key: _formKey,
//            child: Center(
//              child: Container(
//                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                child: ListView(
//                  children: <Widget>[
//                    Row(
//                      children: <Widget>[
//                        Text(
//                          "First Name :",
//                          style: TextStyle(fontSize: size.width / 25),
//                        ),
//                        SizedBox(
//                          width: size.width / 40,
//                        ),
//                        Expanded(
//                          child: TextFormField(
//                            controller: firstNameController,
//                            decoration: InputDecoration(hintText: "First Name"),
//                            validator: (value) {
//                              return value.isEmpty ? "Enter First Name" : null;
//                            },
//                          ),
//                        ),
//                      ],
//                    ),
//                    Row(
//                      children: <Widget>[
//                        Text(
//                          "Last Name :",
//                          style: TextStyle(fontSize: size.width / 25),
//                        ),
//                        SizedBox(
//                          width: size.width / 40,
//                        ),
//                        Expanded(
//                          child: TextFormField(
//                            controller: lastNameController,
//                            decoration: InputDecoration(hintText: "Last Name"),
//                            validator: (value) {
//                              return value.isEmpty ? "Enter Last Name" : null;
//                            },
//                          ),
//                        ),
//                      ],
//                    ),
//                    Row(
//                      children: <Widget>[
//                        Text(
//                          "Email :",
//                          style: TextStyle(fontSize: size.width / 25),
//                        ),
//                        SizedBox(
//                          width: size.width / 40,
//                        ),
//                        Expanded(
//                          child: TextFormField(
//                            controller: emailController,
//                            decoration: InputDecoration(hintText: "Email"),
//                            validator: (value) {
//                              return value.isEmpty ? "Enter Email" : null;
//                            },
//                          ),
//                        ),
//                      ],
//                    ),
//                    RaisedButton(
//                      color: Colors.pink[400],
//                      child: Text(
//                        "Update",
//                        style: TextStyle(color: Colors.white),
//                      ),
//                      onPressed: () async {
//                        // TODO : Complete UserAccount
//
//                        if (_formKey.currentState.validate()) {
//                          await DatabaseService().updateUserData(UserAccount(
//                            firstName:
//                                firstNameController.text ?? user.firstName,
//                            lastName: lastNameController.text ?? user.lastName,
//                            email: emailController.text ?? user.email,
//                            photoUrl: user.photoUrl,
//                            phoneNumber: user.phoneNumber,
//                            birthDay: user.birthDay,
//                            gender: user.gender,
//                            streetAddress: user.streetAddress,
//                            city: user.city,
//                            state: user.state,
//                            zipCode: user.zipCode,
//                            bio: user.bio,
//                            occupation: user.occupation,
//                            maritalStatus: user.maritalStatus,
//                            educationLevel: user.educationLevel,
//                            employmentStatus: user.employmentStatus,
//                            householdIncome: user.householdIncome,
//                            level: user.level,
//                            type: user.type,
//                            writeAccess: user.writeAccess,
//                          ));
//                        }
//                      },
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ),
//        ),
//      );
//    } else {
//      return Loading();
//    }
//  }
//}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController(text: "");
  final lastNameController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final bioController = TextEditingController();
  final occupationController = TextEditingController();
  DateTime birthdate;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserAccount>(context);

    setState(() {
      if (user != null) {
        isloading = true;
      }
    });

    if (isloading) {
      // if (firstNameController.text == "") {
      //   firstNameController.text = user.firstName;
      // } else if (firstNameController.text == user.firstName) {
      //   firstNameController.text = user.firstName;
      // } else {
      //   firstNameController.text = firstNameController.text;
      // }

      firstNameController.text = firstNameController.text == ""
          ? user.firstName
          : firstNameController.text;
      lastNameController.text = lastNameController.text == ""
          ? user.lastName
          : lastNameController.text;
      emailController.text =
          emailController.text == "" ? user.email : emailController.text;
      birthdate = birthdate == null ? user.birthDay.toDate() : birthdate;
      streetController.text = streetController.text == ""
          ? user.streetAddress
          : streetController.text;
      cityController.text =
          cityController.text == "" ? user.city : cityController.text;
      stateController.text = stateController.text == ""
          ? user.streetAddress
          : stateController.text;
      zipCodeController.text =
          zipCodeController.text == "" ? user.zipCode : zipCodeController.text;
      phoneNumberController.text = phoneNumberController.text == ""
          ? user.phoneNumber
          : phoneNumberController.text;
      bioController.text =
          bioController.text == "" ? user.bio : bioController.text;
      occupationController.text = occupationController.text == ""
          ? user.occupation
          : occupationController.text;

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
                            controller: lastNameController,
                            decoration: InputDecoration(hintText: "Last Name"),
                            validator: (value) {
                              return value.isEmpty ? "Enter Last Name" : null;
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
                            decoration: InputDecoration(hintText: "Email"),
                            validator: (value) {
                              return value.isEmpty ? "Enter Email" : null;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Date of Birth :",
                          style: TextStyle(fontSize: size.width / 25),
                        ),
                        SizedBox(
                          width: size.width / 40,
                        ),
                        InkWell(
                          child: Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        birthdate == DateTime(1000, 1, 1)
                                            ? "MM/DD/YYYY"
                                            : birthdate.day
                                                    .toString()
                                                    .padLeft(2, '0') +
                                                "/" +
                                                birthdate.month
                                                    .toString()
                                                    .padLeft(2, '0') +
                                                "/" +
                                                birthdate.year.toString()),
                                  ),
                                  SizedBox(width: 10.0),
                                  Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                          ),
                          onTap: () async {
                            var clickedDate = await showDatePicker(
                              context: context,
                              initialDate: birthdate == DateTime(1000, 1, 1)
                                  ? DateTime.now()
                                  : birthdate,
                              firstDate: DateTime(1850, 1, 1),
                              lastDate: DateTime.now(),
                              helpText: "MM/DD/YYYY",
                            );
                            if (clickedDate != null && clickedDate != birthdate)
                              setState(() {
                                birthdate = clickedDate;
                                print(birthdate.toString());
                              });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Street :",
                          style: TextStyle(fontSize: size.width / 25),
                        ),
                        SizedBox(
                          width: size.width / 40,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: emailController,
                            decoration:
                                InputDecoration(hintText: "Street address"),
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
                        // TODO : Complete UserAccount

                        if (_formKey.currentState.validate()) {
                          print(birthdate.toString());
                          await DatabaseServiceUser()
                              .updateUserData(UserAccount(
                            firstName:
                                firstNameController.text ?? user.firstName,
                            lastName: lastNameController.text ?? user.lastName,
                            email: emailController.text ?? user.email,
                            photoUrl: user.photoUrl,
                            phoneNumber: user.phoneNumber,
                            birthDay:
                                Timestamp.fromDate(birthdate) ?? user.birthDay,
                            gender: user.gender,
                            streetAddress: user.streetAddress,
                            city: user.city,
                            state: user.state,
                            zipCode: user.zipCode,
                            bio: user.bio,
                            occupation: user.occupation,
                            maritalStatus: user.maritalStatus,
                            educationLevel: user.educationLevel,
                            employmentStatus: user.employmentStatus,
                            householdIncome: user.householdIncome,
                            level: user.level,
                            type: user.type,
                            writeAccess: user.writeAccess,
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
      );
    } else {
      return Loading();
    }
  }
}
