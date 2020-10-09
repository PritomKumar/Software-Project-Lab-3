import 'package:earneasy/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SurveyTask extends StatefulWidget {
  @override
  _SurveyTaskState createState() => _SurveyTaskState();
}

class _SurveyTaskState extends State<SurveyTask> {
  TextEditingController question = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedType = MultipleChoiceTaskType;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 5.0,
          backgroundColor: Colors.green,
          splashColor: Colors.redAccent,
          child: Icon(
            Icons.add_circle,
          ),
        ),
        body: Container(
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      children: <Widget>[
                        Container(
                          color: Colors.grey[100],
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            textCapitalization: TextCapitalization.characters,
                            maxLines: 10,
                            scrollPhysics: BouncingScrollPhysics(),
                            minLines: 1,
                            decoration: InputDecoration(hintText: VeryLongTextForTestingPurpose),
                          ),
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
                          value: selectedType,
                          items:
                              TaskTypeDropdownList.map((String dropdownItem) {
                            return DropdownMenuItem<String>(
                              value: dropdownItem,
                              child: Text(dropdownItem),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedType = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
