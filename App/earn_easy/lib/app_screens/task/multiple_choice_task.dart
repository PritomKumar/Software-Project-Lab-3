import 'package:earneasy/models/task.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MultipleChoiceTaskScreen extends StatefulWidget {
  @override
  _MultipleChoiceTaskScreenState createState() =>
      _MultipleChoiceTaskScreenState();
}

class _MultipleChoiceTaskScreenState extends State<MultipleChoiceTaskScreen> {
  MultipleChoiceTask _multipleChoiceTask;
  int _groupValue ;
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.dotCircle,
                          size: 20.0,
                        ),
                        SizedBox(width: 10.0),
                        Text("Multiple choice"),
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
                        return RadioListTile(
                          title: Text(
                            _multipleChoiceTask.optionList[index].option,
                            textScaleFactor: 1.2,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.deepPurple,
                          selected: _groupValue == index,
                          value:index,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                              print("Value $_groupValue");
                              _multipleChoiceTask.optionList[index].checked = _groupValue == index;
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
                          //compressImageFromImageFile();
                          //await uploadToFirebase();
                          await DatabaseServiceTasks().updateMultipleChoiceTask(_multipleChoiceTask);
                          Navigator.pop(context,_multipleChoiceTask);
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