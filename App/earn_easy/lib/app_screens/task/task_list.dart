import 'package:earneasy/app_screens/task/checkbox_task.dart';
import 'package:earneasy/app_screens/task/dropdown_task.dart';
import 'package:earneasy/app_screens/task/free_text_task.dart';
import 'package:earneasy/app_screens/task/multiple_choice_task.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'image_task.dart';

class TaskListPage extends StatefulWidget {
  final Gig gig;

  const TaskListPage({Key key, this.gig}) : super(key: key);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  Widget _getIconBasedOnTaskType(String taskType) {
    switch (taskType) {
      case ImageTaskType:
        return Icon(Icons.photo_library);
        break;
      case CheckBoxTaskType:
        return Icon(FontAwesomeIcons.checkSquare);
        break;
      case MultipleChoiceTaskType:
        return Icon(FontAwesomeIcons.dotCircle);
        break;
      case DropdownTaskType:
        return Icon(FontAwesomeIcons.chevronCircleDown);
        break;
      case FreeTextTaskType:
        return Icon(FontAwesomeIcons.alignLeft);
        break;
      default:
        return Icon(Icons.photo_library);
        break;
    }
  }

  List<bool> _allUserCompletedTask = List<bool>();

  void _findTasksThatAreCompletedOrNot(
      List<TaskSnippet> taskSnippetList) async {
    for (int i = 0; i < taskSnippetList.length; i++) {
      bool isComplete = await _checkIfTaskIsCompleted(taskSnippetList[i]);
      print("Task ${taskSnippetList[i].taskDescription} is $isComplete");
      _allUserCompletedTask.add(isComplete);
    }
  }

  Future<bool> _checkIfTaskIsCompleted(TaskSnippet _taskSnippet) async {
    try {
      return await fireStoreGigsRef
          .doc(widget.gig.gigId)
          .collection("UserResponse")
          .doc(userUid)
          .collection("Tasks")
          .doc(_taskSnippet.taskId)
          .get()
          .then((_value) => _value.data()["isCompleted"] ?? false);
    } catch (e) {
      print("Check if task of id ${_taskSnippet.taskId} has failed");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var taskList = widget.gig.taskSnippetList;
    _findTasksThatAreCompletedOrNot(taskList);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tasks",
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Tasks"),
          ),
          body: ListView.builder(
            itemCount: taskList.length ?? 10,
            itemBuilder: (context, index) => Column(
              children: <Widget>[
                ListTile(
                  leading: _getIconBasedOnTaskType(taskList[index].taskType),
                  trailing: null,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          taskList[index].require ? "* " : "",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Flexible(
                        child: Text(
                          taskList[index].taskDescription,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                  dense: false,
                  onTap: () async {
                    print("Inside Task list tapped  $index");

                    //<editor-fold desc="Different type of task to different page Navigation">
                    if (taskList[index].taskType == ImageTaskType) {
                      // TODO Have to send item based on type of task
                      // DocumentSnapshot  fullTask = await fireStoreGigsRef
                      //     .doc(widget.gig.gigId)
                      //     .collection("Tasks")
                      //     .doc(taskList[index].taskId).get();
                      //<editor-fold desc="Stream builder try">
                      // Stream<DocumentSnapshot> fullTaskStream = fireStoreGigsRef
                      //     .doc(widget.gig.gigId)
                      //     .collection("Tasks")
                      //     .doc(taskList[index].taskId)
                      //     .snapshots();
                      // print(fullTaskStream.toString());
                      // StreamBuilder<DocumentSnapshot>(
                      //     stream: fullTaskStream,
                      //     builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.active) {
                      //         final Map<String, dynamic> firebaseTask =
                      //             snapshot.data.data;
                      //         ImageTask selectedTask =
                      //             ImageTask.fromMap(snapshot.data.data);
                      //
                      //         print(selectedTask.toMap());
                      //         return Container();
                      //       } else {
                      //         return Container();
                      //       }
                      //     });
                      //</editor-fold>
                      var imageTask = DatabaseServiceTasks()
                          .selectedImageTaskData(widget.gig, taskList[index]);

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
                              widget.gig, taskList[index]);

                      print(checkBoxTask.toString());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StreamProvider<CheckboxTask>.value(
                                    value: checkBoxTask,
                                    child: CheckBoxTaskScreen(),
                                  )));
                    }
                    if (taskList[index].taskType == MultipleChoiceTaskType) {
                      var multipleChoiceTask = DatabaseServiceTasks()
                          .selectedMultipleChoiceTaskData(
                              widget.gig, taskList[index]);

                      print(multipleChoiceTask.toString());

                      var mul = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StreamProvider<MultipleChoiceTask>.value(
                                    value: multipleChoiceTask,
                                    child: MultipleChoiceTaskScreen(),
                                  )));
                      print("Multiple choice = ${mul.toMap()}");
                    }
                    if (taskList[index].taskType == DropdownTaskType) {
                      var dropdownTask = DatabaseServiceTasks()
                          .selectedDropdownTaskData(
                              widget.gig, taskList[index]);

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
                              widget.gig, taskList[index]);

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
                  },
                  // contentPadding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
                ),
                Divider(
                  indent: 20.0,
                  endIndent: 20.0,
                  color: Colors.lightBlueAccent,
                  thickness: 1.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
