import 'package:earneasy/models/gig.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GigPage extends StatelessWidget {
  final Gig gig;

  const GigPage({Key key, this.gig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> lol = List<String>();
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
                  Text(gig.money.toString()),
                  Text(gig.description),
                  Text(gig.startTime.toDate().toString()),
                  Text(gig.endTime.toDate().toString()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
