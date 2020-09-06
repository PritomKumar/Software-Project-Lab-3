import 'package:earneasy/models/gig.dart';
import 'package:flutter/material.dart';

class GigPage extends StatelessWidget {
  final Gig gig;

  const GigPage({Key key, this.gig}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: gig.title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(gig.title),
        ),
        body: Center(
          child: Container(
            child: Align(
              alignment: Alignment.center,
              child: ListView(children: <Widget>[
                  Text(gig.money.toString()),
                  Text(gig.description),
                  Text(gig.startTime.toDate().toString()),
                  Text(gig.endTime.toDate().toString()),
              ],),
            ),
          ),
        ),
      ),
    );
  }
}

