import 'package:earneasy/models/task.dart';
import 'package:earneasy/models/task_option.dart';
import 'package:earneasy/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DropdownTaskScreen extends StatefulWidget {
  @override
  _DropdownTaskScreenState createState() => _DropdownTaskScreenState();
}

class _DropdownTaskScreenState extends State<DropdownTaskScreen> {
  DropdownTask _dropdownTask;
  String _selectedItem = "a";

  @override
  Widget build(BuildContext context) {
    _dropdownTask = Provider.of<DropdownTask>(context);
    return SafeArea(
      child: _dropdownTask != null
          ? Scaffold(
              appBar: AppBar(
                title: Text("Dropdown Task"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.chevronCircleDown,
                          size: 20.0,
                        ),
                        SizedBox(width: 10.0),
                        Text("Dropdown"),
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
                    DropdownButtonFormField(
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
                        value: _selectedItem,
                        items: _dropdownTask.optionList
                            .map((TaskOption dropdownItem) {
                          return DropdownMenuItem<String>(
                            value: dropdownItem.option,
                            child: Text(dropdownItem.option),
                            onTap: () {
                              dropdownItem.checked = dropdownItem.option == _selectedItem;
                            },
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedItem = value;
                          });
                        }),
                    SizedBox(height: 20.0,),
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
