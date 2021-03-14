import 'package:earneasy/models/task.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MultipleChoiceTaskScreen extends StatefulWidget {
  @override
  _MultipleChoiceTaskScreenState createState() =>
      _MultipleChoiceTaskScreenState();
}

class _MultipleChoiceTaskScreenState extends State<MultipleChoiceTaskScreen> {
  MultipleChoiceTask _multipleChoiceTask;
  int _groupValue;

  _getGroupValueFromOptionList() {
    if (_groupValue == null) {
      for (int i = 0; i < _multipleChoiceTask.optionList.length; i++) {
        if (_multipleChoiceTask.optionList[i].checked == true) {
          _groupValue = i;
          break;
        }
      }
    }
  }

  _setOtherOptionsToFalse(int index) {
    for (int i = 0; i < _multipleChoiceTask.optionList.length; i++) {
      if (i != index) {
        _multipleChoiceTask.optionList[i].checked = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _multipleChoiceTask = Provider.of<MultipleChoiceTask>(context);

    return SafeArea(
      child: _multipleChoiceTask != null
          ? Scaffold(
              appBar: AppBar(
                title: Text("Multiple choice Task"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.dotCircle,
                              size: 20.0,
                            ),
                            SizedBox(width: 10.0),
                            Text("Multiple choice"),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Required",
                              textScaleFactor: 1.1,
                              style: TextStyle(
                                color: _multipleChoiceTask.require
                                    ? Colors.deepPurpleAccent
                                    : Colors.black87,
                              ),
                            ),
                            Switch(
                              value: _multipleChoiceTask.require,
                              onChanged: (value) {
                                // setState(() {
                                //   _multipleChoiceTask.require = value;
                                //   print(_multipleChoiceTask.require);
                                // });
                              },
                              activeTrackColor: Colors.deepPurple[200],
                              focusColor: Colors.red,
                              activeColor: Colors.deepPurple,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${_multipleChoiceTask.taskDescription}",
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ListView.builder(
                      itemCount: _multipleChoiceTask.optionList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        _getGroupValueFromOptionList();
                        return RadioListTile(
                          title: Text(
                            _multipleChoiceTask.optionList[index].option,
                            textScaleFactor: 1.2,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.deepPurple,
                          selected: _groupValue == index,
                          value: index,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                              print("Value $_groupValue");
                              _multipleChoiceTask.optionList[index].checked =
                                  _groupValue == index;
                              _setOtherOptionsToFalse(index);
                            });
                          },
                        );
                      },
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
                          print("Group value =  $_groupValue");
                          if (_groupValue == null) {
                            showWarningToast("Please select a option.");
                          } else {
                            _multipleChoiceTask.isCompleted = true;
                            await DatabaseServiceTasks()
                                .updateMultipleChoiceTask(_multipleChoiceTask);
                            showSuccessToast(
                                "Your choice is successfully added");
                            // Navigator.pop(context, _multipleChoiceTask);
                          }
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
