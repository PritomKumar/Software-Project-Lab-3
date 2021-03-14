import 'package:earneasy/models/task.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CheckBoxTaskScreen extends StatefulWidget {
  @override
  _CheckBoxTaskScreenState createState() => _CheckBoxTaskScreenState();
}

class _CheckBoxTaskScreenState extends State<CheckBoxTaskScreen> {
  CheckboxTask _checkboxTask;

  int _checkIfAnyOptionsHaveBeenSelected() {
    int counter = 0;
    for (int i = 0; i < _checkboxTask.optionList.length; i++) {
      if (_checkboxTask.optionList[i].checked == true) {
        counter++;
      }
    }
    return counter;
  }

  @override
  Widget build(BuildContext context) {
    _checkboxTask = Provider.of<CheckboxTask>(context);
    return SafeArea(
      child: _checkboxTask != null
          ? Scaffold(
              appBar: AppBar(
                title: Text("Checkbox Task"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
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
                    SizedBox(
                      height: 20.0,
                    ),
                    ListView.builder(
                      itemCount: _checkboxTask.optionList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: Text(
                            _checkboxTask.optionList[index].option,
                            textScaleFactor: 1.2,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.deepPurple,
                          checkColor: Colors.white,
                          selected: _checkboxTask.optionList[index].checked,
                          value: _checkboxTask.optionList[index].checked,
                          onChanged: (bool value) {
                            setState(() {
                              _checkboxTask.optionList[index].checked = value;
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
                          int numberOfOptionsSelected =
                              _checkIfAnyOptionsHaveBeenSelected();
                          if (numberOfOptionsSelected <= 0) {
                            showWarningToast("Please select an option.");
                          } else {
                            _checkboxTask.isCompleted = true;
                            await DatabaseServiceTasks()
                                .updateCheckboxTask(_checkboxTask);
                            // Navigator.pop(context, _dropdownTask);
                            showSuccessToast(numberOfOptionsSelected > 1
                                ? "Your selected options are successfully added."
                                : "Your selected option is successfully added.");
                          }
                          //Navigator.pop(context,_checkboxTask);
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
