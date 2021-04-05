import 'package:earneasy/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WarningMessageTask extends StatefulWidget {
  final List<bool> allUserCompletedTask;
  final List<TaskSnippet> taskSnippetList;

  const WarningMessageTask(
      {Key key, this.allUserCompletedTask, this.taskSnippetList})
      : super(key: key);

  @override
  WarningMessageTaskState createState() => WarningMessageTaskState();
}

class WarningMessageTaskState extends State<WarningMessageTask> {
  //</editor-fold>

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 20.0),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
            elevation: 10.0,
            title: Text(
              "Error",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.redAccent,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 0.0,
                ),
                height: MediaQuery.of(context).size.height - 250,
                width: double.maxFinite,
                padding: EdgeInsets.all(10.0),
                child: ListView.builder(
                    itemCount: widget.taskSnippetList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (!widget.allUserCompletedTask[index]) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Question " +
                                  (index + 1).toString() +
                                  " " +
                                  widget.taskSnippetList[index].taskDescription,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Remark: You have not completed this task!",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                color: widget.taskSnippetList[index].require
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return null;
                      }
                    }),
              ),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    elevation: 5.0,
                    splashColor: Colors.grey[700],
                    autofocus: true,
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                  RaisedButton(
                    elevation: 5.0,
                    splashColor: Colors.blue[700],
                    autofocus: true,
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ]),
      ],
    );
  }
}
