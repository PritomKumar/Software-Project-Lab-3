import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/shared/constants.dart';
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

  @override
  Widget build(BuildContext context) {
    var taskList = widget.gig.taskSnippetList;
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
                  title: Text(
                    // ,
                    taskList[index].taskDescription,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  dense: false,
                  onTap: () async {
                    print("Inside Task list tapped  $index");
                    //TODO do this for other type of tasks
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
                      var fullTask = DatabaseServiceTasks()
                          .selectedImageTaskData(widget.gig, taskList[index]);

                      print(fullTask.toString());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StreamProvider<ImageTask>.value(
                                    value: fullTask,
                                    child: ImageTaskScreen(),
                                  )));
                    }
                    if (taskList[index].taskType == CheckBoxTaskType) {
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
                      var fullTask = fireStoreGigsRef
                          .doc(widget.gig.gigId)
                          .collection("Tasks")
                          .doc(taskList[index].taskId)
                          .snapshots()
                          .map((taskFromDocument) =>
                              ImageTask.fromMap(taskFromDocument.data()));

                      print(fullTask.toString());

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StreamProvider<ImageTask>.value(
                                    value: fullTask,
                                    child: ImageTaskScreen(),
                                  )));
                    }
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
