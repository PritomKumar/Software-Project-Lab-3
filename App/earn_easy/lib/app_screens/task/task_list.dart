import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earneasy/models/gig.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:flutter/material.dart';

class TaskListPage extends StatefulWidget {
  final Gig gig;

  const TaskListPage({Key key, this.gig}) : super(key: key);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    var taskList = widget.gig.taskSnippetList;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tasks",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tasks"),
        ),
        body: ListView.builder(
          itemCount: taskList.length ?? 10,
          itemBuilder: (context, index) => Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                trailing: null,
                title: Text(
                  // "Hellasd asdas asd asdasd asdas sdfsdf dsf sdfsd sfd sdf sdf asdasd a asd as sdfds sdfsd fsdfjk shfjsdhf jksdhfjsdhf jksdhfjsdh fjsdhfjdsh jsdhfj shdfjsdhf jsdhfjsdh fsjdhf jskdhfsdjfh sdjfhsdjhf sdjfh jshdjf hsjdh jshfsdjhf sjdhfjskhfjsdhfj shfjsd hsj jsdkf jsdhf sjdhosdfsdf dsfsd sdf sfsdf sd",
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
                  // TODO Have to send item based on type of task
                  // DocumentSnapshot  fullTask = await fireStoreGigsRef
                  //     .doc(widget.gig.gigId)
                  //     .collection("Tasks")
                  //     .doc(taskList[index].taskId).get();

                  // var fullTask = await fireStoreGigsRef
                  //     .doc(widget.gig.gigId)
                  //     .collection("Tasks")
                  //     .doc(taskList[index].taskId)
                  //     .snapshots()
                  //     .map((taskFromDocument) =>
                  //         ImageTask.fromMap(taskFromDocument.data()));


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
    );
  }
}