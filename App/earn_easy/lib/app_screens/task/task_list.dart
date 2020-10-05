import 'package:flutter/material.dart';

class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Tasks",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tasks"),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                trailing: null,
                title: Text(
                  "Hellasd asdas asd asdasd asdas sdfsdf dsf sdfsd sfd sdf sdf asdasd a asd as sdfds sdfsd fsdfjk shfjsdhf jksdhfjsdhf jksdhfjsdh fjsdhfjdsh jsdhfj shdfjsdhf jsdhfjsdh fsjdhf jskdhfsdjfh sdjfhsdjhf sdjfh jshdjf hsjdh jshfsdjhf sjdhfjskhfjsdhfj shfjsd hsj jsdkf jsdhf sjdhosdfsdf dsfsd sdf sfsdf sd",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                dense: false,
                onTap: () {},
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
