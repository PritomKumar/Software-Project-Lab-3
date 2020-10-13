import 'package:earneasy/models/task.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CheckBoxTaskScreen extends StatefulWidget {
  @override
  _CheckBoxTaskScreenState createState() => _CheckBoxTaskScreenState();
}

class _CheckBoxTaskScreenState extends State<CheckBoxTaskScreen> {
  CheckboxTask _checkboxTask;

  @override
  Widget build(BuildContext context) {
    _checkboxTask = Provider.of<CheckboxTask>(context);
    return SafeArea(
      child: _checkboxTask != null
          ? Scaffold(
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
                    "${_checkboxTask.taskDescription}",
                    textScaleFactor: 1.5,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          : Loading(),
    );
  }
}
