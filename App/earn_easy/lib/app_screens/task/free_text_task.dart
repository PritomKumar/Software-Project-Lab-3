import 'package:earneasy/app_screens/task/task_list.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:earneasy/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FreeTextTaskScreen extends StatefulWidget {
  final int index;

  const FreeTextTaskScreen({Key key, this.index}) : super(key: key);

  @override
  _FreeTextTaskScreenState createState() => _FreeTextTaskScreenState();
}

class _FreeTextTaskScreenState extends State<FreeTextTaskScreen> {
  FreeTextTask _freeTextTask;
  TextEditingController _freeTextEditingController = TextEditingController();
  int _bottomNavigationBarIndex = 0;
  bool _bottomNavigationBarTapped = false;

  @override
  void dispose() {
    _freeTextEditingController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    var userResponse = await DatabaseServiceTasks()
        .getToUserTaskFromGigId(_freeTextTask.gigId);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskListPage(
            userResponse: userResponse,
          ),
        ));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _freeTextTask = Provider.of<FreeTextTask>(context);
    int index = widget.index;
    var _userAccount = Provider.of<UserAccount>(context);
    var userType = _userAccount.type;
    if (_freeTextTask != null)
      _freeTextEditingController.text = _freeTextTask.userResponse;
    return SafeArea(
      child: _freeTextTask != null
          ? Scaffold(
              appBar: AppBar(
                title: Text("Free Text Task"),
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
                      .getToUserTaskFromGigId(_freeTextTask.gigId);
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
                              FontAwesomeIcons.alignLeft,
                              size: 20.0,
                            ),
                            SizedBox(width: 10.0),
                            Text("Free Text"),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Required",
                              textScaleFactor: 1.1,
                              style: TextStyle(
                                color: _freeTextTask.require
                                    ? Colors.deepPurpleAccent
                                    : Colors.black87,
                              ),
                            ),
                            Switch(
                              value: _freeTextTask.require,
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
                                _freeTextTask.userResponse =
                                    _freeTextEditingController.text;
                                if (_freeTextEditingController.text == "") {
                                  showWarningToast(
                                      "Please write a response to the question.");
                                } else {
                                  _freeTextTask.isCompleted = true;
                                  await DatabaseServiceTasks()
                                      .updateFreeTextTask(_freeTextTask);
                                  showSuccessToast(
                                      "Your response is successfully stored.");
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
