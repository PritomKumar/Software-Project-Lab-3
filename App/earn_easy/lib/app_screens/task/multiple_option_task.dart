import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

class MultipleChoiceTaskScreen extends StatefulWidget {
  @override
  _MultipleChoiceTaskScreenState createState() => _MultipleChoiceTaskScreenState();
}

class _MultipleChoiceTaskScreenState extends State<MultipleChoiceTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Multiple choice Task"),
        ),
        body: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.dotCircle,
                  size: 20.0,
                ),
                SizedBox(width: 10.0),
                Text("Multiple choice"),
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
