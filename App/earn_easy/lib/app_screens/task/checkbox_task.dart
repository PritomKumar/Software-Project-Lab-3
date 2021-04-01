import 'package:earneasy/app_screens/task/dropdown_task.dart';
import 'package:earneasy/app_screens/task/free_text_task.dart';
import 'package:earneasy/app_screens/task/image_task.dart';
import 'package:earneasy/app_screens/task/multiple_choice_task.dart';
import 'package:earneasy/app_screens/task/task_list.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:earneasy/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CheckBoxTaskScreen extends StatefulWidget {
  final int index;

  const CheckBoxTaskScreen({Key key, @required this.index}) : super(key: key);

  @override
  _CheckBoxTaskScreenState createState() => _CheckBoxTaskScreenState();
}

class _CheckBoxTaskScreenState extends State<CheckBoxTaskScreen> {
  CheckboxTask _checkboxTask;
  int _bottomNavigationBarIndex = 0;
  bool _bottomNavigationBarTapped = false;

  int _checkIfAnyOptionsHaveBeenSelected() {
    int counter = 0;
    for (int i = 0; i < _checkboxTask.optionList.length; i++) {
      if (_checkboxTask.optionList[i].checked == true) {
        counter++;
      }
    }
    return counter;
  }

  Future<bool> _onWillPop() async {
    var userResponse = await DatabaseServiceTasks()
        .getToUserTaskFromGigId(_checkboxTask.gigId);
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
    int index = widget.index;
    _checkboxTask = Provider.of<CheckboxTask>(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: _checkboxTask != null
            ? Scaffold(
                appBar: AppBar(
                  title: Text("Checkbox Task"),
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
                      label: index == 0 ? SizedBox.shrink() : "Previous",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                      label: "Next",
                    ),
                  ],
                  onTap: (value) async {
                    var userResponse = await DatabaseServiceTasks()
                        .getToUserTaskFromGigId(_checkboxTask.gigId);
                    var taskList = userResponse.taskSnippetList;
                    setState(() {
                      _bottomNavigationBarIndex = value;
                      _bottomNavigationBarTapped = true;
                      if (_bottomNavigationBarTapped) {
                        if (_bottomNavigationBarIndex == 0) {
                          // showSuccessToast("previous");
                          index--;
                          print("Inside Task list tapped  $index");
                          Utils.previousAndNextNavigation(
                              userResponse, index, context);
                          // //<editor-fold desc="Different type of task to different page Navigation">
                          // if (taskList[index].taskType == ImageTaskType) {
                          //   var imageTask = DatabaseServiceTasks()
                          //       .selectedImageTaskData(
                          //           userResponse.gigId, taskList[index]);
                          //
                          //   print(imageTask.toString());
                          //
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               StreamProvider<ImageTask>.value(
                          //                 value: imageTask,
                          //                 child: ImageTaskScreen(),
                          //               )));
                          // }
                          // if (taskList[index].taskType == CheckBoxTaskType) {
                          //   var checkBoxTask = DatabaseServiceTasks()
                          //       .selectedCheckboxTaskData(
                          //           userResponse.gigId, taskList[index]);
                          //
                          //   print(checkBoxTask.toString());
                          //
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               StreamProvider<CheckboxTask>.value(
                          //                 value: checkBoxTask,
                          //                 child:
                          //                     CheckBoxTaskScreen(index: index),
                          //               )));
                          // }
                          // if (taskList[index].taskType ==
                          //     MultipleChoiceTaskType) {
                          //   var multipleChoiceTask = DatabaseServiceTasks()
                          //       .selectedMultipleChoiceTaskData(
                          //           userResponse.gigId, taskList[index]);
                          //
                          //   print(multipleChoiceTask.toString());
                          //
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => StreamProvider<
                          //                   MultipleChoiceTask>.value(
                          //                 value: multipleChoiceTask,
                          //                 child: MultipleChoiceTaskScreen(),
                          //               )));
                          //   // print("Multiple choice = ${mul.toMap()}");
                          // }
                          // if (taskList[index].taskType == DropdownTaskType) {
                          //   var dropdownTask = DatabaseServiceTasks()
                          //       .selectedDropdownTaskData(
                          //           userResponse.gigId, taskList[index]);
                          //
                          //   print(dropdownTask.toString());
                          //
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               StreamProvider<DropdownTask>.value(
                          //                 value: dropdownTask,
                          //                 child: DropdownTaskScreen(),
                          //               )));
                          // }
                          // if (taskList[index].taskType == FreeTextTaskType) {
                          //   var freeTextTask = DatabaseServiceTasks()
                          //       .selectedFreeTextTaskData(
                          //           userResponse.gigId, taskList[index]);
                          //
                          //   print(freeTextTask.toString());
                          //
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               StreamProvider<FreeTextTask>.value(
                          //                 value: freeTextTask,
                          //                 child: FreeTextTaskScreen(),
                          //               )));
                          // }
                          // //</editor-fold>

                        } else if (_bottomNavigationBarIndex == 1) {
                          // showSuccessToast("Next");
                          index++;
                          print("Inside Task list tapped  $index");

                          //<editor-fold desc="Different type of task to different page Navigation">
                          if (taskList[index].taskType == ImageTaskType) {
                            var imageTask = DatabaseServiceTasks()
                                .selectedImageTaskData(
                                    userResponse.gigId, taskList[index]);

                            print(imageTask.toString());

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StreamProvider<ImageTask>.value(
                                          value: imageTask,
                                          child: ImageTaskScreen(),
                                        )));
                          }
                          if (taskList[index].taskType == CheckBoxTaskType) {
                            var checkBoxTask = DatabaseServiceTasks()
                                .selectedCheckboxTaskData(
                                    userResponse.gigId, taskList[index]);

                            print(checkBoxTask.toString());

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StreamProvider<CheckboxTask>.value(
                                          value: checkBoxTask,
                                          child:
                                              CheckBoxTaskScreen(index: index),
                                        )));
                          }
                          if (taskList[index].taskType ==
                              MultipleChoiceTaskType) {
                            var multipleChoiceTask = DatabaseServiceTasks()
                                .selectedMultipleChoiceTaskData(
                                    userResponse.gigId, taskList[index]);

                            print(multipleChoiceTask.toString());

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StreamProvider<
                                            MultipleChoiceTask>.value(
                                          value: multipleChoiceTask,
                                          child: MultipleChoiceTaskScreen(),
                                        )));
                            // print("Multiple choice = ${mul.toMap()}");
                          }
                          if (taskList[index].taskType == DropdownTaskType) {
                            var dropdownTask = DatabaseServiceTasks()
                                .selectedDropdownTaskData(
                                    userResponse.gigId, taskList[index]);

                            print(dropdownTask.toString());

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StreamProvider<DropdownTask>.value(
                                          value: dropdownTask,
                                          child: DropdownTaskScreen(),
                                        )));
                          }
                          if (taskList[index].taskType == FreeTextTaskType) {
                            var freeTextTask = DatabaseServiceTasks()
                                .selectedFreeTextTaskData(
                                    userResponse.gigId, taskList[index]);

                            print(freeTextTask.toString());

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StreamProvider<FreeTextTask>.value(
                                          value: freeTextTask,
                                          child: FreeTextTaskScreen(),
                                        )));
                          }
                          //</editor-fold>
                        } else {
                          showSuccessToast("default");
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
                                FontAwesomeIcons.checkSquare,
                                size: 20.0,
                              ),
                              SizedBox(width: 10.0),
                              Text("Checkbox"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Required",
                                textScaleFactor: 1.1,
                                style: TextStyle(
                                  color: _checkboxTask.require
                                      ? Colors.deepPurpleAccent
                                      : Colors.black87,
                                ),
                              ),
                              Switch(
                                value: _checkboxTask.require,
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
      ),
    );
  }
}
