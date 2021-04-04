import 'package:earneasy/app_screens/task/task_list.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/models/task_option.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:earneasy/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DropdownTaskScreen extends StatefulWidget {
  final int index;

  const DropdownTaskScreen({Key key, this.index}) : super(key: key);

  @override
  _DropdownTaskScreenState createState() => _DropdownTaskScreenState();
}

class _DropdownTaskScreenState extends State<DropdownTaskScreen> {
  DropdownTask _dropdownTask;
  String _selectedItem;
  int _bottomNavigationBarIndex = 0;
  bool _bottomNavigationBarTapped = false;

  //bool _checkIfAnyOptionsHaveBeenSelected = false;

  _setOptionsAccordingToSelectedValue(String value) {
    for (int i = 0; i < _dropdownTask.optionList.length; i++) {
      if (value != _dropdownTask.optionList[i].option) {
        _dropdownTask.optionList[i].checked = false;
      } else {
        _dropdownTask.optionList[i].checked = true;
      }
    }
  }

  _getSelectedValueFromOptionList() {
    if (_selectedItem == null) {
      for (int i = 0; i < _dropdownTask.optionList.length; i++) {
        if (_dropdownTask.optionList[i].checked == true) {
          _selectedItem = _dropdownTask.optionList[i].option;
          break;
        }
      }
    }
  }

  bool _checkIfAnyOptionsHaveBeenSelected() {
    for (int i = 0; i < _dropdownTask.optionList.length; i++) {
      if (_dropdownTask.optionList[i].checked == true) {
        // _checkIfAnyOptionsHaveBeenSelected = true;
        return true;
      }
    }
    return false;
  }

  Future<bool> _onWillPop() async {
    var userResponse = await DatabaseServiceTasks()
        .getToUserTaskFromGigId(_dropdownTask.gigId);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskListPage(
            userResponse: userResponse,
          ),
        ));
    return true;
  }

  String _getResultFromTask(DropdownTask task) {
    String answer = "Response: ";
    bool check = false;
    for (int i = 0; i < task.optionList.length; i++) {
      if (task.optionList[i].checked) {
        answer += task.optionList[i].option + ", ";
        check = true;
      }
    }
    if (check) {
      answer = answer.substring(0, answer.length - 2) + ".";
    }
    return answer;
  }

  @override
  Widget build(BuildContext context) {
    _dropdownTask = Provider.of<DropdownTask>(context);
    var _userAccount = Provider.of<UserAccount>(context);
    var userType = _userAccount.type;
    int index = widget.index;
    String answer = _dropdownTask != null
        ? _getResultFromTask(_dropdownTask)
        : "Response: ";
    if (_dropdownTask != null) _getSelectedValueFromOptionList();
    return SafeArea(
      child: _dropdownTask != null
          ? Scaffold(
              appBar: AppBar(
                title: Text("Dropdown Task"),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _bottomNavigationBarIndex,
                backgroundColor: Colors.grey[200],
                selectedItemColor: Theme.of(context).primaryColorDark,
                unselectedItemColor: Theme.of(context).primaryColorDark,
                items: [
                  BottomNavigationBarItem(
                    icon: index == 0
                        ? SizedBox.shrink()
                        : Icon(Icons.arrow_back_ios),
                    label: index == 0 ? "" : "Previous",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.arrow_forward_ios_rounded),
                    label: "Next",
                  ),
                ],
                onTap: (value) async {
                  var userResponse = await DatabaseServiceTasks()
                      .getToUserTaskFromGigId(_dropdownTask.gigId);
                  var taskList = userResponse.taskSnippetList;
                  setState(() {
                    _bottomNavigationBarIndex = value;
                    _bottomNavigationBarTapped = true;
                    if (_bottomNavigationBarTapped) {
                      if (_bottomNavigationBarIndex == 0) {
                        // showSuccessToast("previous");
                        index = index - 1;
                        print("Inside Task list tapped  $index");
                        if (index < 0) {
                        } else {
                          Utils.previousAndNextNavigation(
                              userResponse, index, context);
                        }
                      } else if (_bottomNavigationBarIndex == 1) {
                        // showSuccessToast("Next");
                        index++;
                        print("Inside Task list tapped  $index");
                        if (taskList.length <= index) {
                          showSuccessToast("End of Task List");
                          _onWillPop();
                        } else {
                          Utils.previousAndNextNavigation(
                              userResponse, index, context);
                        }
                      } else {
                        print("default navigation -1");
                      }
                    }
                  });
                },
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
                              FontAwesomeIcons.chevronCircleDown,
                              size: 20.0,
                            ),
                            SizedBox(width: 10.0),
                            Text("Dropdown"),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Required",
                              textScaleFactor: 1.1,
                              style: TextStyle(
                                color: _dropdownTask.require
                                    ? Colors.deepPurpleAccent
                                    : Colors.black87,
                              ),
                            ),
                            Switch(
                              value: _dropdownTask.require,
                              onChanged: (value) {},
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
                      "${_dropdownTask.taskDescription}",
                      textScaleFactor: 1.5,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    userType == "worker"
                        ? DropdownButtonFormField(
                            elevation: 5,
                            decoration: InputDecoration(
                              hoverColor: Colors.red,
                              filled: true,
                              focusColor: Colors.green,
                              fillColor: Colors.grey[150],
                              contentPadding:
                                  EdgeInsets.only(left: 5.0, right: 5.0),
                            ),
                            icon: Icon(FontAwesomeIcons.angleDown),
                            iconEnabledColor: Colors.blueGrey,
                            iconDisabledColor: Colors.grey[350],
                            isExpanded: true,
                            hint: Text(
                              _selectedItem ?? "Choose a option",
                              textScaleFactor: 1.1,
                            ),
                            value: _selectedItem,
                            items: _dropdownTask.optionList
                                .map((TaskOption dropdownItem) {
                              if (_selectedItem == null) {
                                _selectedItem =
                                    _dropdownTask.optionList[0].option;
                              }
                              return DropdownMenuItem<String>(
                                value: dropdownItem.option,
                                child: Text(dropdownItem.option),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedItem = value;
                                _setOptionsAccordingToSelectedValue(
                                    _selectedItem);
                              });
                            })
                        : Text(
                            answer,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                    SizedBox(
                      height: 20.0,
                    ),
                    userType == "worker"
                        ? Align(
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
                                // print(_dropdownTask.toMap());
                                print("Selected Item = ${_selectedItem}");
                                if (_checkIfAnyOptionsHaveBeenSelected() ==
                                    false) {
                                  showWarningToast("Please select an option.");
                                } else {
                                  _dropdownTask.isCompleted = true;
                                  await DatabaseServiceTasks()
                                      .updateDropdownTask(_dropdownTask);
                                  // Navigator.pop(context, _dropdownTask);
                                  showSuccessToast(
                                      "Option ${_selectedItem} is successfully added");
                                }
                              },
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            )
          : Loading(),
    );
  }
}
