import 'package:earneasy/models/task.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

class CheckBoxTaskScreen extends StatefulWidget {
  @override
  _CheckBoxTaskScreenState createState() => _CheckBoxTaskScreenState();
}

class _CheckBoxTaskScreenState extends State<CheckBoxTaskScreen> {
  CheckboxTask _checkboxTask;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Checkbox Task"),
        ),
        body: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.checkSquare,
                  size: 20.0,
                ),
                SizedBox(width: 10.0),
                Text("Checkbox"),
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
