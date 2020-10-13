import 'package:earneasy/models/task.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DropdownTaskScreen extends StatefulWidget {
  @override
  _DropdownTaskScreenState createState() => _DropdownTaskScreenState();
}

class _DropdownTaskScreenState extends State<DropdownTaskScreen> {
  DropdownTask _dropdownTask;
  @override
  Widget build(BuildContext context) {
    _dropdownTask = Provider.of<DropdownTask>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Dropdown Task"),
        ),
        body: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.chevronCircleDown,
                  size: 20.0,
                ),
                SizedBox(width: 10.0),
                Text("Dropdown"),
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
