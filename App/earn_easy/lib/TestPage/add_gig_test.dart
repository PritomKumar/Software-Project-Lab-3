import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/task.dart';
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

class GigAddTest extends StatefulWidget {
  final LatLng location = LatLng(40.7128, 74.0060);

  //const GigAdd({Key key, this.location}) : super(key: key);

  @override
  _GigAddState createState() => _GigAddState(location);
}

class _GigAddState extends State<GigAddTest> {
  final LatLng location;
  final _formKey = GlobalKey<FormState>();
  bool alreadyAddedGig = false;
  var moneyController = TextEditingController();
  var taskDescriptionController = TextEditingController();
  var titleController = TextEditingController();
  List<ImageTask> taskList = List<ImageTask>();
  var descriptionController = TextEditingController();
  DateTime startDate = defalultInitializedTimestamp.toDate();
  DateTime endDate = defalultInitializedTimestamp.toDate();

  //bool isloading = false;
  bool isloading = true;

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
    SimpleDialog errorDialog = SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      title: Center(child: Text("Add Task")),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15.0),
          child: TextFormField(
            controller: taskDescriptionController,
            decoration: InputDecoration(hintText: "First Name"),
            validator: (value) {
              return value.isEmpty ? "Enter First Name" : null;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Awesome',
            style: TextStyle(color: Colors.red),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 50.0)),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Got It!',
              style: TextStyle(color: Colors.purple, fontSize: 18.0),
            )),
      ],
      // child: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: ListView(
      //     children: <Widget>[
      //       Padding(
      //         padding: EdgeInsets.all(15.0),
      //         child: TextFormField(
      //           controller: taskDescriptionController,
      //           decoration: InputDecoration(hintText: "First Name"),
      //           validator: (value) {
      //             return value.isEmpty ? "Enter First Name" : null;
      //           },
      //         ),
      //       ),
      //       SizedBox(
      //         height: 1000,
      //       ),
      //       Padding(
      //         padding: EdgeInsets.all(15.0),
      //         child: Text(
      //           'Awesome',
      //           style: TextStyle(color: Colors.red),
      //         ),
      //       ),
      //       Padding(padding: EdgeInsets.only(top: 50.0)),
      //       FlatButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text(
      //             'Got It!',
      //             style: TextStyle(color: Colors.purple, fontSize: 18.0),
      //           )),
      //     ],
      //   ),
      // ),
    );
    var size = MediaQuery.of(context).size;
    //user = Provider.of<UserAccount>(context);
    // setState(() {
    //   if (user != null) {
    //     isloading = true;
    //   }
    // });

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
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.end,
                        children: <Widget>[
                          RaisedButton.icon(
                            color: Colors.lightGreen,
                            splashColor: Colors.red,
                            elevation: 5.0,
                            autofocus: true,
                            icon: Icon(Icons.add_circle),
                            label: Text("Add Task"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      errorDialog);
                            },
                          ),
                        ],
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
                            if (!alreadyAddedGig) {
                              GeoPoint geoLocation = GeoPoint(
                                  location.latitude, location.longitude);
                              await DatabaseServiceGigs()
                                  .createNewGig(Gig(
                                money: int.parse(
                                        moneyController.text.toString()) ??
                                    0,
                                title: titleController.text ?? "",
                                description: descriptionController.text ?? "",
                                location: geoLocation,
                                //providerId: user.uid,
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
// class _GigAddState extends State<GigAddTest> {
//   final LatLng location;
//   final _formKey = GlobalKey<FormState>();
//   bool alreadyAddedGig = false;
//   var moneyController = TextEditingController();
//   var titleController = TextEditingController();
//   var descriptionController = TextEditingController();
//   DateTime startDate = defalultInitializedTimestamp.toDate();
//   DateTime endDate = defalultInitializedTimestamp.toDate();
//   bool isloading = false;
//
//   static final typeOfGigArray = [
//     "Not set",
//     "Image",
//     "Survey",
//     "Image and Survey",
//     "Other"
//   ];
//   String typeOfGig = typeOfGigArray[0];
//
//   _GigAddState(this.location);
//
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     user = Provider.of<UserAccount>(context);
//     setState(() {
//       if (user != null) {
//         isloading = true;
//       }
//     });
//
//     if (isloading) {
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text('Add Gig'),
//           ),
//           body: StyledToast(
//             textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
//             backgroundColor: Color(0x99000000),
//             borderRadius: BorderRadius.circular(5.0),
//             textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
//             toastPositions: StyledToastPosition.bottom,
//             toastAnimation: StyledToastAnimation.fade,
//             reverseAnimation: StyledToastAnimation.fade,
//             curve: Curves.fastOutSlowIn,
//             reverseCurve: Curves.fastLinearToSlowEaseIn,
//             duration: Duration(seconds: 4),
//             animDuration: Duration(seconds: 1),
//             dismissOtherOnShow: true,
//             movingOnWindowChange: true,
//             locale: Localizations.localeOf(context),
//             child: Form(
//               key: _formKey,
//               child: Center(
//                 child: Container(
//                   padding:
//                   EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   child: ListView(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             "Money :",
//                             style: TextStyle(fontSize: size.width / 25),
//                           ),
//                           SizedBox(
//                             width: size.width / 40,
//                           ),
//                           Expanded(
//                             child: TextFormField(
//                               keyboardType: TextInputType.number,
//                               controller: moneyController,
//                               decoration: InputDecoration(hintText: "Money"),
//                               validator: (value) {
//                                 return value.isEmpty ? "Enter Money" : null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             "Title :",
//                             style: TextStyle(fontSize: size.width / 25),
//                           ),
//                           SizedBox(
//                             width: size.width / 40,
//                           ),
//                           Expanded(
//                             child: TextFormField(
//                               controller: titleController,
//                               decoration:
//                               InputDecoration(hintText: "Gig Title"),
//                               validator: (value) {
//                                 return value.isEmpty
//                                     ? "Enter your gig title"
//                                     : null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             "Description :",
//                             style: TextStyle(fontSize: size.width / 25),
//                           ),
//                           SizedBox(
//                             width: size.width / 40,
//                           ),
//                           Expanded(
//                             child: TextFormField(
//                               controller: descriptionController,
//                               decoration:
//                               InputDecoration(hintText: "Gig description"),
//                               validator: (value) {
//                                 return value.isEmpty
//                                     ? "Enter gig description"
//                                     : null;
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             "Start Date :",
//                             style: TextStyle(fontSize: size.width / 25),
//                           ),
//                           SizedBox(
//                             width: size.width / 40,
//                           ),
//                           InkWell(
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 10.0, horizontal: 5.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Text(
//                                     startDate ==
//                                         defalultInitializedTimestamp
//                                             .toDate()
//                                         ? "MM/DD/YYYY"
//                                         : startDate.day
//                                         .toString()
//                                         .padLeft(2, '0') +
//                                         "/" +
//                                         startDate.month
//                                             .toString()
//                                             .padLeft(2, '0') +
//                                         "/" +
//                                         startDate.year.toString(),
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w300,
//                                         color: Colors.black),
//                                   ),
//                                   SizedBox(width: 10.0),
//                                   Icon(FontAwesomeIcons.calendarCheck),
//                                 ],
//                               ),
//                             ),
//                             onTap: () async {
//                               var clickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: startDate ==
//                                     defalultInitializedTimestamp.toDate()
//                                     ? DateTime.now()
//                                     : startDate,
//                                 firstDate: DateTime.now(),
//                                 lastDate: DateTime(2050, 1, 1),
//                                 helpText: "MM/DD/YYYY",
//                               );
//                               if (clickedDate != null &&
//                                   clickedDate != startDate)
//                                 setState(() {
//                                   startDate = clickedDate;
//                                   print(startDate.toString());
//                                 });
//                             },
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             "End Date :",
//                             style: TextStyle(fontSize: size.width / 25),
//                           ),
//                           SizedBox(
//                             width: size.width / 40,
//                           ),
//                           InkWell(
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 10.0, horizontal: 5.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Text(
//                                     endDate ==
//                                         defalultInitializedTimestamp
//                                             .toDate()
//                                         ? "MM/DD/YYYY"
//                                         : endDate.day
//                                         .toString()
//                                         .padLeft(2, '0') +
//                                         "/" +
//                                         endDate.month
//                                             .toString()
//                                             .padLeft(2, '0') +
//                                         "/" +
//                                         endDate.year.toString(),
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w300,
//                                         color: Colors.black),
//                                   ),
//                                   SizedBox(width: 10.0),
//                                   Icon(FontAwesomeIcons.calendarTimes),
//                                 ],
//                               ),
//                             ),
//                             onTap: () async {
//                               var clickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: endDate ==
//                                     defalultInitializedTimestamp.toDate()
//                                     ? DateTime.now()
//                                     : endDate,
//                                 firstDate: DateTime.now(),
//                                 lastDate: DateTime(2050, 1, 1),
//                                 helpText: "MM/DD/YYYY",
//                               );
//                               if (clickedDate != null && clickedDate != endDate)
//                                 setState(() {
//                                   endDate = clickedDate;
//                                   print(endDate.toString());
//                                 });
//                             },
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 10.0, horizontal: 0.0),
//                         child: Row(
//                           children: <Widget>[
//                             Text(
//                               "Type of Gig :",
//                               style: TextStyle(fontSize: size.width / 25),
//                             ),
//                             SizedBox(
//                               width: size.width / 40,
//                             ),
//                             Expanded(
//                               child: DropdownButtonFormField(
//                                 elevation: 5,
//                                 decoration: InputDecoration(
//                                   hoverColor: Colors.red,
//                                   filled: true,
//                                   focusColor: Colors.green,
//                                   fillColor: Colors.grey[150],
//                                   contentPadding:
//                                   EdgeInsets.only(left: 5.0, right: 5.0),
//                                 ),
//                                 icon: Icon(FontAwesomeIcons.angleDown),
//                                 iconEnabledColor: Colors.blueGrey,
//                                 iconDisabledColor: Colors.grey[350],
//                                 isExpanded: true,
//                                 value: typeOfGig,
//                                 items:
//                                 typeOfGigArray.map((String dropdownItem) {
//                                   return DropdownMenuItem<String>(
//                                     value: dropdownItem,
//                                     child: Text(dropdownItem),
//                                   );
//                                 }).toList(),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     typeOfGig = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       RaisedButton(
//                         color: Colors.pink[400],
//                         child: Text(
//                           "Create Gig",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: () async {
//                           if (_formKey.currentState.validate()) {
//                             bool checkAdded = false;
//                             if (!alreadyAddedGig) {
//                               GeoPoint geoLocation = GeoPoint(
//                                   location.latitude, location.longitude);
//                               await DatabaseServiceGigs()
//                                   .createNewGig(Gig(
//                                 money: int.parse(
//                                     moneyController.text.toString()) ??
//                                     0,
//                                 title: titleController.text ?? "",
//                                 description: descriptionController.text ?? "",
//                                 location: geoLocation,
//                                 providerId: user.uid,
//                                 startTime: Timestamp.fromDate(startDate),
//                                 endTime: Timestamp.fromDate(endDate),
//                                 type: typeOfGig,
//                               ))
//                                   .then((value) {
//                                 setState(() {
//                                   alreadyAddedGig = true;
//                                   checkAdded = true;
//                                 });
//                               });
//                               if (!checkAdded) {
//                                 showToast("Request Failed");
//                               } else {
//                                 showToast("Your Gig is added sucessfully");
//                               }
//                             } else {
//                               showToast("Your Gig is already added");
//                             }
//                           }
//                         },
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     } else {
//       return Loading();
//     }
//   }
// }
