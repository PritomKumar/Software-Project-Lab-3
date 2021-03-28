import 'package:earneasy/app_screens/task/task_list.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_gig_databse.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/services/firestore_user_databse.dart';
import 'package:earneasy/shared/constants.dart';
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
    // List<String> attemptedUserListFromGig = widget.gig.attemptedUsers;
    var attempt = await fireStoreGigsRef.doc(widget.gig.gigId).get();
    var tempGig = Gig.fromMap(attempt.data());
    var attemptedUserListFromGig = tempGig.attemptedUsers;
    for (var attemptedUser in attemptedUserListFromGig) {
      if (attemptedUser == userUid) {
        print("User ${userUid} has accepted the gig ${widget.gig.gigId}");
        setState(() {
          checker = true;
        });
      }
    }
  }

  //#endregion

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserAccount>(context);
    print("User id = ${user.uid} ");
    Gig gig = widget.gig;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: gig.title,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(gig.title),
          ),
          body: Center(
            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: ListView(
                  children: <Widget>[
                    //#region UI elements
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
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.moneyBillWave,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Money: ",
                            style: TextStyle(
                              decorationColor: Colors.red,
                              color: Colors.green,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
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
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "Description: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Text(
                              gig.description.toString(),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w300,
                              ),
                              maxLines: 1000,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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
                              child: Text("Start Tasks"),
                              onPressed: () async {
                                // print("Start pressed");
                                var userResponse = await DatabaseServiceTasks()
                                    .getToUserTaskFromGigId(gig.gigId);
                                // print(userResponse.taskSnippetList.toString());

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskListPage(
                                        userResponse: userResponse,
                                      ),
                                    ));
                              },
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
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
                                await DatabaseServiceGigs()
                                    .updateAttemptedUserInGig(gig);
                                await DatabaseServiceUser()
                                    .updateAttemptedGigWaitListedGigAndAllGigsAtTheSameTime(
                                        gig);
                                await DatabaseServiceTasks()
                                    .createUserResponseForAttemptedUser(gig);
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
