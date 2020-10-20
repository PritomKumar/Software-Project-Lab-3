import 'package:earneasy/models/task.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FreeTextTaskScreen extends StatefulWidget {
  @override
  _FreeTextTaskScreenState createState() => _FreeTextTaskScreenState();
}

class _FreeTextTaskScreenState extends State<FreeTextTaskScreen> {
  FreeTextTask _freeTextTask;
  TextEditingController _freeTextEditingController = TextEditingController();

  @override
  void dispose() {
    _freeTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _freeTextTask = Provider.of<FreeTextTask>(context);
    if (_freeTextTask != null)
      _freeTextEditingController.text = _freeTextTask.userResponse;
    return SafeArea(
      child: _freeTextTask != null
          ? Scaffold(
              appBar: AppBar(
                title: Text("Free Text Task"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
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
                      "${_freeTextTask.taskDescription}",
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 200.0,
                      child: Card(
                          color: Colors.grey[100],
                          elevation: 2.0,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              maxLines: null,
                              autofocus: true,
                              controller: _freeTextEditingController,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Enter your answer here"),
                            ),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton.icon(
                        elevation: 5.0,
                        color: Colors.white,
                        label: Text(
                          "Finish Task",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: Icon(
                          Icons.cloud_upload,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () async {
                          _freeTextTask.userResponse =
                              _freeTextEditingController.text;
                          await DatabaseServiceTasks()
                              .updateFreeTextTask(_freeTextTask);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Loading(),
    );
  }
}
