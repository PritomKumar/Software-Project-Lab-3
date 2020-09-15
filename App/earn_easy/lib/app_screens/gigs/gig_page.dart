import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GigPage extends StatelessWidget {
  final Gig gig;

  const GigPage({Key key, this.gig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserAccount>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: gig.title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(gig.title),
        ),
        body: Center(
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: ListView(
                children: <Widget>[
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
                          color: Colors.black,
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
                        Text(
                          gig.description.toString(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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
                        await fireStoreGigsRef.doc(gig.gigId).update({
                          'attemptedUsers': FieldValue.arrayUnion([user.uid])
                        });
                        await fireStoreUsersRef.doc(user.uid).update({
                          'attemptedGigs': FieldValue.arrayUnion([
                            {
                              'gigId': gig.gigId,
                              'title': gig.title,
                              'money': gig.money,
                            }
                          ]),
                          'waitListGigs': FieldValue.arrayUnion([gig.gigId]),
                          'allGigs': FieldValue.arrayUnion([gig.gigId]),
                        }).then((value) {
                          print("Added in user");
                        });
                      },
                    ),
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
