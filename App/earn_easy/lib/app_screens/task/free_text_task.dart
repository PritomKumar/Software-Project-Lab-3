import 'package:earneasy/models/task.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FreeTextTaskScreen extends StatefulWidget {
  @override
  _FreeTextTaskScreenState createState() => _FreeTextTaskScreenState();
}

class _FreeTextTaskScreenState extends State<FreeTextTaskScreen> {
  FreeTextTask _freeTextTask;
  @override
  Widget build(BuildContext context) {
    _freeTextTask = Provider.of<FreeTextTask>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Free Text Task"),
        ),
        body: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.alignLeft,
                  size: 20.0,
                ),
                SizedBox(width: 10.0),
                Text("Free Text"),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              //"${_imageTask.taskDescription}",
              "Header",
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
