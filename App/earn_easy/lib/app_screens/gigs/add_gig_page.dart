import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_gig_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GigAdd extends StatefulWidget {
  final LatLng location;

  const GigAdd({Key key, this.location}) : super(key: key);

  @override
  _GigAddState createState() => _GigAddState(location);
}

class _GigAddState extends State<GigAdd> {
  final LatLng location;
  final _formKey = GlobalKey<FormState>();
  bool alreadyAddedGig = false;
  var moneyController = TextEditingController();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  DateTime startDate = defalultInitializedTimestamp.toDate();
  DateTime endDate = defalultInitializedTimestamp.toDate();
  bool isloading = false;

  static final typeOfGigArray = [
    "Not set",
    "Image",
    "Survey",
    "Image and Survey",
    "Other"
  ];
  String typeOfGig = typeOfGigArray[0];

  _GigAddState(this.location);

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
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Add Gig'),
          ),
          body: StyledToast(
            textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
            backgroundColor: Color(0x99000000),
            borderRadius: BorderRadius.circular(5.0),
            textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
            toastPositions: StyledToastPosition.bottom,
            toastAnimation: StyledToastAnimation.fade,
            reverseAnimation: StyledToastAnimation.fade,
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(seconds: 4),
            animDuration: Duration(seconds: 1),
            dismissOtherOnShow: true,
            movingOnWindowChange: true,
            locale: Localizations.localeOf(context),
            child: Form(
              key: _formKey,
              child: Center(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Money :",
                            style: TextStyle(fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: moneyController,
                              decoration: InputDecoration(hintText: "Money"),
                              validator: (value) {
                                return value.isEmpty ? "Enter Money" : null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Title :",
                            style: TextStyle(fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: titleController,
                              decoration:
                                  InputDecoration(hintText: "Gig Title"),
                              validator: (value) {
                                return value.isEmpty
                                    ? "Enter your gig title"
                                    : null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Description :",
                            style: TextStyle(fontSize: size.width / 25),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: descriptionController,
                              decoration:
                                  InputDecoration(hintText: "Gig description"),
                              validator: (value) {
                                return value.isEmpty
                                    ? "Enter gig description"
                                    : null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Start Date :",
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
                                    startDate ==
                                            defalultInitializedTimestamp
                                                .toDate()
                                        ? "MM/DD/YYYY"
                                        : startDate.day
                                                .toString()
                                                .padLeft(2, '0') +
                                            "/" +
                                            startDate.month
                                                .toString()
                                                .padLeft(2, '0') +
                                            "/" +
                                            startDate.year.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 10.0),
                                  Icon(FontAwesomeIcons.calendarCheck),
                                ],
                              ),
                            ),
                            onTap: () async {
                              var clickedDate = await showDatePicker(
                                context: context,
                                initialDate: startDate ==
                                        defalultInitializedTimestamp.toDate()
                                    ? DateTime.now()
                                    : startDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050, 1, 1),
                                helpText: "MM/DD/YYYY",
                              );
                              if (clickedDate != null &&
                                  clickedDate != startDate)
                                setState(() {
                                  startDate = clickedDate;
                                  print(startDate.toString());
                                });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "End Date :",
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
                                    endDate ==
                                            defalultInitializedTimestamp
                                                .toDate()
                                        ? "MM/DD/YYYY"
                                        : endDate.day
                                                .toString()
                                                .padLeft(2, '0') +
                                            "/" +
                                            endDate.month
                                                .toString()
                                                .padLeft(2, '0') +
                                            "/" +
                                            endDate.year.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black),
                                  ),
                                  SizedBox(width: 10.0),
                                  Icon(FontAwesomeIcons.calendarTimes),
                                ],
                              ),
                            ),
                            onTap: () async {
                              var clickedDate = await showDatePicker(
                                context: context,
                                initialDate: endDate ==
                                        defalultInitializedTimestamp.toDate()
                                    ? DateTime.now()
                                    : endDate,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2050, 1, 1),
                                helpText: "MM/DD/YYYY",
                              );
                              if (clickedDate != null && clickedDate != endDate)
                                setState(() {
                                  endDate = clickedDate;
                                  print(endDate.toString());
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
                              "Type of Gig :",
                              style: TextStyle(fontSize: size.width / 25),
                            ),
                            SizedBox(
                              width: size.width / 40,
                            ),
                            Expanded(
                              child: DropdownButtonFormField(
                                elevation: 5,
                                decoration: InputDecoration(
                                  hoverColor: Colors.red,
                                  filled: true,
                                  focusColor: Colors.green,
                                  fillColor: Colors.grey[150],
                                  contentPadding:
                                      EdgeInsets.only(left: 5.0, right: 5.0),
                                ),
                                icon: Icon(FontAwesomeIcons.angleDown),
                                iconEnabledColor: Colors.blueGrey,
                                iconDisabledColor: Colors.grey[350],
                                isExpanded: true,
                                value: typeOfGig,
                                items:
                                    typeOfGigArray.map((String dropdownItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropdownItem,
                                    child: Text(dropdownItem),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    typeOfGig = value;
                                    print(typeOfGig);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          "Create Gig",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            bool checkAdded = false;
                            print("Inside" + typeOfGig);
                            if (!alreadyAddedGig) {
                              GeoPoint geoLocation = GeoPoint(
                                  location.latitude, location.longitude);
                              var createdGig = await DatabaseServiceGigs()
                                  .createNewGig(Gig(
                                money: int.parse(
                                        moneyController.text.toString()) ??
                                    0,
                                title: titleController.text ?? "",
                                description: descriptionController.text ?? "",
                                location: geoLocation,
                                providerId: user.uid,
                                startTime: Timestamp.fromDate(startDate),
                                endTime: Timestamp.fromDate(endDate),
                                type: typeOfGig,
                              ))
                                  .then((value) {
                                setState(() {
                                  alreadyAddedGig = true;
                                  checkAdded = true;
                                });
                              });
                              if (createdGig != null) {
                                await fireStoreUsersRef.doc(user.uid).update({
                                  'createdGigs':
                                  FieldValue.arrayUnion([createdGig.id]),
                                });
                              }
                              if (!checkAdded) {
                                showToast("Request Failed");
                              } else {
                                showToast("Your Gig is added sucessfully");
                              }
                            } else {
                              showToast("Your Gig is already added");
                            }
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
