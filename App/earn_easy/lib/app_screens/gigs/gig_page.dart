import 'package:earneasy/app_screens/map/google_map_gig.dart';
import 'package:earneasy/app_screens/task/task_list.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_gig_databse.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/services/firestore_user_databse.dart';
import 'package:earneasy/services/location_service.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/description_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GigPage extends StatefulWidget {
  final Gig gig;

  const GigPage({Key key, this.gig}) : super(key: key);

  @override
  _GigPageState createState() => _GigPageState();
}

class _GigPageState extends State<GigPage> {
  bool checker = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfUserIsInAttemptedUsers();
  }

  //#region Methods
  _checkIfUserIsInAttemptedUsers() async {
    var attempt = await fireStoreGigsRef.doc(widget.gig.gigId).get();
    var tempGig = Gig.fromMap(attempt.data());
    // var attemptedUserListFromGig = tempGig.attemptedUsers;
    // for (var attemptedUser in attemptedUserListFromGig) {
    //   if (attemptedUser.uid == userUid) {
    //     print("User ${userUid} has accepted the gig ${widget.gig.gigId}");
    //     setState(() {
    //       checker = true;
    //     });
    //   }
    // }
    var assignedUserUid = tempGig.assignedUser.uid;
    if(assignedUserUid == userUid){
      setState(() {
        checker = true;
      });
    }
  }

  //#endregion

  Future<bool> _onWillPop() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GoogleMaps()));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserAccount>(context);
    print("User id = ${user.uid} ");
    Gig gig = widget.gig;
    double distance = LocationService()
        .calculateDistanceGigAndUserCurrentLocation(widget.gig.location);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context),
      title: gig.title,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // title: Text(gig.title),
            title: Text("Available Tasks"),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context, false),
            ),
          ),
          body: Center(
            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: ListView(
                  children: <Widget>[
                    //#region UI elements
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 5.0),
                      child: Text(
                        widget.gig.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[300],
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.calendarCheck,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Starts: ",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                gig.startTime
                                        .toDate()
                                        .day
                                        .toString()
                                        .padLeft(2, '0') +
                                    "/" +
                                    gig.startTime
                                        .toDate()
                                        .month
                                        .toString()
                                        .padLeft(2, '0') +
                                    "/" +
                                    gig.startTime.toDate().year.toString(),
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.calendarTimes,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "Ends: ",
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                gig.endTime
                                        .toDate()
                                        .day
                                        .toString()
                                        .padLeft(2, '0') +
                                    "/" +
                                    gig.endTime
                                        .toDate()
                                        .month
                                        .toString()
                                        .padLeft(2, '0') +
                                    "/" +
                                    gig.endTime.toDate().year.toString(),
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.dollarSign,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Money: ",
                            style: TextStyle(
                              decorationColor: Colors.red,
                              color: Colors.black87,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            gig.money.toString(),
                            style: TextStyle(
                              decorationColor: Colors.red,
                              color: Colors.green,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            " bdt",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.running,
                            color: Colors.deepPurple,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Distance: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            distance >= 1.0
                                ? distance.toStringAsFixed(2)
                                : (distance * 1000).round().toString(),
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            distance >= 1.0 ? "kilo meters" : "meters",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.envelopeOpenText,
                            color: Colors.blueGrey,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Description: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: DescriptionTextWidget(
                          text: widget.gig.description, isBold: false),
                    ),
                    //#endregion
                    checker
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            width: double.infinity,
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.lightGreenAccent,
                                onPrimary: Colors.white,
                                side: BorderSide(color: Colors.green, width: 1),
                              ),
                              child: Text(
                                "Start Tasks",
                                style: TextStyle(color: Colors.black87),
                              ),
                              onPressed: () async {
                                // print("Start pressed");

                                //TODo : Logic if the user is accepted then createUserResponseForAttemptedUser
                                await DatabaseServiceTasks()
                                    .createUserResponseForAttemptedUser(gig);

                                var userResponse = await DatabaseServiceTasks()
                                    .getToUserTaskFromGigId(gig.gigId);
                                // print(userResponse.taskSnippetList.toString());

                                if (userResponse.taskSnippetList.length > 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TaskListPage(
                                          userResponse: userResponse,
                                        ),
                                      ));
                                } else {
                                  showNeutralToast("No sub task in this task");
                                }
                              },
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 5.0,
                            ),
                            width: double.infinity,
                            alignment: Alignment.bottomCenter,
                            child: RaisedButton(
                              color: Colors.red,
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () async {
                                var attemptedUser = UserMinimum(
                                  uid: user.uid,
                                  firstName: user.firstName,
                                  lastName: user.lastName,
                                  email: user.email,
                                  photoUrl: user.photoUrl,
                                  token: user.token,
                                  level: user.level,
                                  numberOfCurrentGigs: user.currentGigs.length,
                                  distance: LocationService()
                                      .calculateDistanceGigAndUserCurrentLocation(
                                          gig.location),
                                  type: user.type,
                                  writeAccess: user.writeAccess,
                                );
                                await DatabaseServiceGigs()
                                    .updateAttemptedUserInGig(
                                        gig, attemptedUser);
                                await DatabaseServiceUser()
                                    .updateAttemptedGigWaitListedGigAndAllGigsAtTheSameTime(
                                    gig);
                                await _checkIfUserIsInAttemptedUsers();
                                setState(() {});
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
