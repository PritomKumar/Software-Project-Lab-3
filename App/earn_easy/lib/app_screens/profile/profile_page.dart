import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/app_screens/home/side_drawer.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_user_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
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
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _bioController = TextEditingController();
  final _occupationController = TextEditingController();

  static final _genderArray = ["Not set", "Male", "Female", "Other"];
  String _gender = "";
  static final _maritalStatusArray = [
    "Not set",
    "Single",
    "Married",
    "Widowed",
    "Divorced",
    "Separated",
    "Other"
  ];
  String _maritalStatus = "";
  static final _educationLevelArray = [
    "Not set",
    "Less than high school diploma",
    "High school degree or equivalent",
    "Some college, no degree",
    "Current college student",
    "Associate degree",
    "Bachelor's degree",
    "Master's degree",
    "Professional degree",
    "Doctorate",
    "Post-Doctorate",
    "Other"
  ];
  String _educationLevel = "";
  static final _employmentStatusArray = [
    "Not set",
    "Employed full time",
    "Employed part time",
    "Self-employed",
    "Military",
    "Student",
    "Retired",
    "Homemaker",
    "Unemployed",
    "Other"
  ];
  String _employmentStatus = "";
  static final _householdIncomeArray = [
    "Not set",
    "Less than 20,000 bdt",
    "20,000 to 39,999 bdt",
    "40,000 to 59,999 bdt",
    "60,000 to 79,999 bdt",
    "80,000 to 99,999 bdt",
    "Over 100,000 bdt"
  ];
  String _householdIncome = "";
  static final _userTypeArray = ["worker", "provider"];
  String _userType = "";

  DateTime _birthDate;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _phoneNumberController.dispose();
    _bioController.dispose();
    _occupationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var user = Provider.of<UserAccount>(context);

    _initializeControllers() {
      // if (firstNameController.text == "") {
      //   firstNameController.text = user.firstName;
      // } else if (firstNameController.text == user.firstName) {
      //   firstNameController.text = user.firstName;
      // } else {
      //   firstNameController.text = firstNameController.text;
      // }

      _firstNameController.text = _firstNameController.text == ""
          ? user.firstName
          : _firstNameController.text;
      _lastNameController.text = _lastNameController.text == ""
          ? user.lastName
          : _lastNameController.text;
      _emailController.text =
          _emailController.text == "" ? user.email : _emailController.text;
      _birthDate = _birthDate == null ? user.birthDay.toDate() : _birthDate;
      _streetController.text = _streetController.text == ""
          ? user.streetAddress
          : _streetController.text;
      _cityController.text =
          _cityController.text == "" ? user.city : _cityController.text;
      _stateController.text = _stateController.text == ""
          ? user.streetAddress
          : _stateController.text;
      _zipCodeController.text = _zipCodeController.text == ""
          ? user.zipCode
          : _zipCodeController.text;
      _phoneNumberController.text = _phoneNumberController.text == ""
          ? user.phoneNumber
          : _phoneNumberController.text;
      _bioController.text =
          _bioController.text == "" ? user.bio : _bioController.text;
      _occupationController.text = _occupationController.text == ""
          ? user.occupation
          : _occupationController.text;

      _gender = _gender == "" ? user.gender : _gender;
      _maritalStatus =
          _maritalStatus == "" ? user.maritalStatus : _maritalStatus;
      _educationLevel =
          _educationLevel == "" ? user.educationLevel : _educationLevel;
      _employmentStatus =
          _employmentStatus == "" ? user.employmentStatus : _employmentStatus;
      _householdIncome =
          _householdIncome == "" ? user.householdIncome : _householdIncome;
      _userType = _userType == "" ? user.type : _userType;
    }

    setState(() {
      if (user != null) {
        _isLoading = true;
      }
    });

    Widget profileDropDownItem(
        {String selectedItem, List<String> itemList, String type}) {
      return DropdownButtonFormField(
        elevation: 5,
        decoration: InputDecoration(
          hoverColor: Colors.red,
          filled: true,
          focusColor: Colors.green,
          fillColor: Colors.grey[150],
          contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
        ),
        icon: Icon(FontAwesomeIcons.angleDown),
        iconEnabledColor: Colors.blueGrey,
        iconDisabledColor: Colors.grey[350],
        isExpanded: true,
        value: selectedItem,
        items: itemList.map((String dropdownItem) {
          return DropdownMenuItem<String>(
            value: dropdownItem,
            child: Text(dropdownItem),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedItem = value;
            switch (type) {
              case "gender":
                this._gender = value;
                break;
              case "marital":
                this._maritalStatus = value;
                break;
              case "education":
                this._educationLevel = value;
                break;
              case "employment":
                this._employmentStatus = value;
                break;
              case "income":
                this._householdIncome = value;
                break;
              case "type":
                this._userType = value;
                break;
            }
          });
        },
      );
    }

    if (_isLoading) {
      _initializeControllers();

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            drawer: SideDrawer(),
            appBar: AppBar(
              title: Text('Profile'),
            ),
            body: Form(
              key: _formKey,
              child: Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "User Type :",
                              style: TextStyle(fontSize: size.width / 25),
                            ),
                            SizedBox(
                              width: size.width / 40,
                            ),
                            Expanded(
                              child: profileDropDownItem(
                                  selectedItem: _userType,
                                  itemList: _userTypeArray,
                                  type: "type"),
                            ),
                          ],
                        ),
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
                              controller: _firstNameController,
                              decoration:
                              InputDecoration(hintText: "First Name"),
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
                              controller: _lastNameController,
                              decoration:
                              InputDecoration(hintText: "Last Name"),
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
                              controller: _emailController,
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
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    _birthDate ==
                                        defaultInitializedTimestamp.toDate()
                                        ? "MM/DD/YYYY"
                                        : _birthDate.day
                                        .toString()
                                        .padLeft(2, '0') +
                                        "/" +
                                        _birthDate.month
                                            .toString()
                                            .padLeft(2, '0') +
                                        "/" +
                                        _birthDate.year.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 10.0),
                                  Icon(Icons.calendar_today),
                                ],
                              ),
                            ),
                            onTap: () async {
                              var clickedDate = await showDatePicker(
                                context: context,
                                initialDate: _birthDate ==
                                    defaultInitializedTimestamp.toDate()
                                    ? DateTime.now()
                                    : _birthDate,
                                firstDate: DateTime(1850, 1, 1),
                                lastDate: DateTime.now(),
                                helpText: "MM/DD/YYYY",
                              );
                              if (clickedDate != null &&
                                  clickedDate != _birthDate)
                                setState(() {
                                  _birthDate = clickedDate;
                                  print(_birthDate.toString());
                                });
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Gender :",
                              style: TextStyle(fontSize: size.width / 25),
                            ),
                            SizedBox(
                              width: size.width / 40,
                            ),
                            Expanded(
                              child: profileDropDownItem(
                                  selectedItem: _gender,
                                  itemList: _genderArray,
                                  type: "gender"),
                            ),
                          ],
                        ),
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
                              keyboardType: TextInputType.multiline,
                              controller: _streetController,
                              decoration:
                              InputDecoration(hintText: "Street address"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "City :",
                            style: TextStyle(fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: _cityController,
                              decoration: InputDecoration(hintText: "City"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "State :",
                            style: TextStyle(fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: _stateController,
                              decoration: InputDecoration(hintText: "State"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Zip Code :",
                            style: TextStyle(fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: _zipCodeController,
                              decoration: InputDecoration(hintText: "Zip code"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Phone :",
                            style: TextStyle(fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _phoneNumberController,
                              decoration:
                              InputDecoration(hintText: "Phone number"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Bio :",
                            style: TextStyle(fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: _bioController,
                              decoration: InputDecoration(hintText: "Bio"),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Occupation :",
                            style: TextStyle(fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              controller: _occupationController,
                              decoration:
                              InputDecoration(hintText: "Occupation"),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Marital Status :",
                              style: TextStyle(fontSize: size.width / 25),
                            ),
                            SizedBox(
                              width: size.width / 40,
                            ),
                            Expanded(
                              child: profileDropDownItem(
                                  selectedItem: _maritalStatus,
                                  itemList: _maritalStatusArray,
                                  type: "marital"),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Education Level :",
                              style: TextStyle(fontSize: size.width / 25),
                            ),
                            SizedBox(
                              width: size.width / 40,
                            ),
                            Expanded(
                              child: profileDropDownItem(
                                  selectedItem: _educationLevel,
                                  itemList: _educationLevelArray,
                                  type: "education"),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Employment Status :",
                              style: TextStyle(fontSize: size.width / 25),
                            ),
                            SizedBox(
                              width: size.width / 40,
                            ),
                            Expanded(
                              child: profileDropDownItem(
                                  selectedItem: _employmentStatus,
                                  itemList: _employmentStatusArray,
                                  type: "employment"),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 0.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Household Income :",
                              style: TextStyle(fontSize: size.width / 25),
                            ),
                            SizedBox(
                              width: size.width / 40,
                            ),
                            Expanded(
                              child: profileDropDownItem(
                                  selectedItem: _householdIncome,
                                  itemList: _householdIncomeArray,
                                  type: "income"),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print(_birthDate.toString());
                            await DatabaseServiceUser()
                                .updateUserData(UserAccount(
                              uid: user.uid,
                              firstName: this._firstNameController.text ??
                                  user.firstName,
                              lastName: this._lastNameController.text ??
                                  user.lastName,
                              email: this._emailController.text ?? user.email,
                              photoUrl: user.photoUrl,
                              phoneNumber: user.phoneNumber,
                              birthDay: Timestamp.fromDate(_birthDate) ??
                                  user.birthDay,
                              gender: this._gender ?? user.gender,
                              streetAddress: this._streetController.text ??
                                  user.streetAddress,
                              city: this._cityController.text ?? user.city,
                              state: this._stateController.text ?? user.state,
                              bio: this._bioController.text ?? user.bio,
                              occupation: this._occupationController.text ??
                                  user.occupation,
                              maritalStatus:
                              this._maritalStatus ?? user.maritalStatus,
                              educationLevel:
                              this._educationLevel ?? user.educationLevel,
                              employmentStatus: this._employmentStatus ??
                                  user.employmentStatus,
                              householdIncome:
                              this._householdIncome ?? user.householdIncome,
                              level: user.level,
                              type: this._userType ?? user.type,
                              writeAccess: user.writeAccess,
                              allGigs: user.allGigs,
                              attemptedGigs: user.attemptedGigs,
                              completedGigs: user.completedGigs,
                              createdGigs: user.createdGigs,
                              waitListGigs: user.waitListGigs,
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
        ),
      );
    } else {
      return Loading();
    }
  }
}
