import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/TestPage/add_image_file_dialog.dart';
import 'package:earneasy/app_screens/map/google_map_gig.dart';
import 'package:earneasy/app_screens/task/task_card.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_gig_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:earneasy/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class GigAddPage extends StatefulWidget {
  final LatLng location;

  const GigAddPage({Key key, this.location}) : super(key: key);

  @override
  _GigAddPageState createState() => _GigAddPageState(location);
}

class _GigAddPageState extends State<GigAddPage> {
  final LatLng location;
  final _formKey = GlobalKey<FormState>();
  bool alreadyAddedGig = false;
  var moneyController = TextEditingController();
  var titleController = TextEditingController();

  List<dynamic> taskList = List<dynamic>();
  var descriptionController = TextEditingController();
  DateTime startDate = defaultInitializedTimestamp.toDate();
  DateTime endDate = defaultInitializedTimestamp.toDate();
  TimeOfDay startTime;
  TimeOfDay endTime;

  bool isLoading = false;

  static final typeOfGigArray = [
    "Not set",
    "Image",
    "Survey",
    "Image and Survey",
    "Other"
  ];
  String typeOfGig = typeOfGigArray[0];

  _GigAddPageState(this.location);

  void _showAddImageTaskDialog() async {
    ImageTask selectedTask = await showDialog<ImageTask>(
      context: context,
      builder: (context) => AddImageTaskDialog(),
    );

    if (selectedTask != null) {
      setState(() {
        taskList.add(selectedTask);
      });
    }
  }

  void _showAddTaskDialog() async {
    dynamic selectedTask = await showDialog<dynamic>(
      context: context,
      builder: (context) => TaskCard(),
    );

    if (selectedTask != null) {
      setState(() {
        taskList.add(selectedTask);
      });
    }
  }

  @override
  void dispose() {
    moneyController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GoogleMaps(),
        ));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //var user = Provider.of<UserMinimum>(context);
    var user = Provider.of<UserAccount>(context);
    setState(() {
      if (user != null) {
        print("Gig Add user Uid = ${user.uid}");
        isLoading = true;
      }
    });

    for (var task in taskList) {
      print(
          "${task.taskDescription},  ${task.type} and size = ${taskList.length}");
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: isLoading
              ? Scaffold(
                  appBar: AppBar(
                    title: Text('Add Gig'),
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
                                    decoration:
                                        InputDecoration(hintText: "Money"),
                                    validator: (value) {
                                      return value.isEmpty
                                          ? "Enter Money"
                                          : null;
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
                                    decoration: InputDecoration(
                                        hintText: "Gig description"),
                                    validator: (value) {
                                      return value.isEmpty
                                          ? "Enter gig description"
                                          : null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            //region Start Date and End Date
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          startDate ==
                                                  defaultInitializedTimestamp
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
                                              defaultInitializedTimestamp
                                                  .toDate()
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
                                SizedBox(
                                  width: size.width / 40,
                                ),
                                InkWell(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          startTime == null
                                              ? "HH : MM"
                                              : startTime.hour
                                                      .toString()
                                                      .padLeft(2, '0') +
                                                  " : " +
                                                  startTime.minute
                                                      .toString()
                                                      .padLeft(2, '0'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black),
                                        ),
                                        SizedBox(width: 10.0),
                                        Icon(FontAwesomeIcons.clock),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    var clickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: startTime ?? TimeOfDay.now(),
                                    );
                                    if (clickedTime != null)
                                      setState(() {
                                        startTime = clickedTime;
                                        print(clickedTime.toString());
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          endDate ==
                                                  defaultInitializedTimestamp
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
                                              defaultInitializedTimestamp
                                                  .toDate()
                                          ? DateTime.now()
                                          : endDate,
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2050, 1, 1),
                                      helpText: "MM/DD/YYYY",
                                    );
                                    if (clickedDate != null &&
                                        clickedDate != endDate)
                                      setState(() {
                                        endDate = clickedDate;
                                        print(endDate.toString());
                                      });
                                  },
                                ),
                                SizedBox(
                                  width: size.width / 40,
                                ),
                                InkWell(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          endTime == null
                                              ? "HH : MM"
                                              : endTime.hour
                                                      .toString()
                                                      .padLeft(2, '0') +
                                                  " : " +
                                                  endTime.minute
                                                      .toString()
                                                      .padLeft(2, '0'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black),
                                        ),
                                        SizedBox(width: 10.0),
                                        Icon(FontAwesomeIcons.clock),
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    var clickedTime = await showTimePicker(
                                      context: context,
                                      initialTime: endTime ?? TimeOfDay.now(),
                                    );
                                    if (clickedTime != null)
                                      setState(() {
                                        endTime = clickedTime;
                                        print(clickedTime.toString());
                                      });
                                  },
                                ),
                              ],
                            ),
                            //endregion Start Date and End Date
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
                                        contentPadding: EdgeInsets.only(
                                            left: 5.0, right: 5.0),
                                      ),
                                      icon: Icon(FontAwesomeIcons.angleDown),
                                      iconEnabledColor: Colors.blueGrey,
                                      iconDisabledColor: Colors.grey[350],
                                      isExpanded: true,
                                      value: typeOfGig,
                                      items: typeOfGigArray
                                          .map((String dropdownItem) {
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
                            if (taskList.length > 0)
                              Card(
                                elevation: 5.0,
                                color: Colors.lightGreenAccent,
                                shadowColor: Colors.blue[200],
                                child: ExpansionTile(
                                  initiallyExpanded: false,
                                  title: Text(
                                    "Tasks",
                                    textScaleFactor: 1.35,
                                    style: TextStyle(
                                        //color: Colors.red,
                                        ),
                                  ),
                                  backgroundColor: Colors.white,
                                  trailing: Icon(
                                    Icons.arrow_downward,
                                    color: Colors.black,
                                  ),
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      child: ListView.builder(
                                        itemCount: taskList.length,
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            ListTile(
                                          enabled: true,
                                          dense: true,
                                          leading: Icon(
                                            Icons.photo_library,
                                            color: Colors.blue,
                                          ),
                                          title: Text(
                                            "${taskList[index].taskDescription}",
                                            //VeryLongTextForTestingPurpose,
                                            textScaleFactor: 1.5,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "Task #${index + 1}",
                                            textScaleFactor: 1.1,
                                          ),
                                          trailing: IconButton(
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Colors.black87,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                taskList.removeAt(index);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.end,
                              children: <Widget>[
                                //<editor-fold desc="Add Image Task">
                                // RaisedButton.icon(
                                //   color: Colors.lightGreenAccent,
                                //   splashColor: Colors.red,
                                //   elevation: 5.0,
                                //   autofocus: true,
                                //   icon: Icon(Icons.add_circle),
                                //   label: Text("Add Image Task"),
                                //   shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(15.0)),
                                //   onPressed: _showAddImageTaskDialog,
                                // ),
                                //</editor-fold>
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: RaisedButton.icon(
                                    color: Colors.lightGreenAccent,
                                    splashColor: Colors.red,
                                    elevation: 5.0,
                                    autofocus: true,
                                    icon: Icon(Icons.add_circle),
                                    label: Text("Add Task"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    onPressed: _showAddTaskDialog,
                                  ),
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
                                        .createNewGig(
                                            Gig(
                                              money: int.parse(moneyController
                                                      .text
                                                      .toString()) ??
                                                  0,
                                              title: titleController.text ?? "",
                                              description:
                                                  descriptionController.text ??
                                                      "",
                                              location: geoLocation,
                                              providerId: user.uid,
                                              startTime: Timestamp.fromDate(Utils
                                                  .combineDateTimeWithTimeOfDay(
                                                dateTime: startDate,
                                                timeOfDay: startTime,
                                              )),
                                              endTime: Timestamp.fromDate(Utils
                                                  .combineDateTimeWithTimeOfDay(
                                                dateTime: endDate,
                                                timeOfDay: endTime,
                                              )),
                                              type: typeOfGig,
                                            ),
                                            taskList)
                                        .then((value) {
                                      setState(() {
                                        alreadyAddedGig = true;
                                        checkAdded = true;
                                      });
                                    });
                                    if (!checkAdded) {
                                      Fluttertoast.showToast(
                                          msg: "Request Failed");
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Your Gig is added successfully");
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Your Gig is already added");
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Loading(),
        ));
  }
}
