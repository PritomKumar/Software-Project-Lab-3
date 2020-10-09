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
  double _numberOfTaskImage = 1.0;

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
                            maxLines: 10,
                            scrollPhysics: BouncingScrollPhysics(),
                            minLines: 1,
                            decoration: InputDecoration(
                                hintText: VeryLongTextForTestingPurpose),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: DropdownButtonFormField(
                            elevation: 5,
                            isExpanded: false,
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
                        ),
                        if (selectedType == ImageTaskType)
                          Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      //padding: EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        "Minimum number of image : ",
                                        textScaleFactor: 1.05,
                                        maxLines: null,
                                        //overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    // padding: EdgeInsets.only(top: 20.0),
                                    child: Text(
                                      "${_numberOfTaskImage.round()}",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 2.0,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Slider(
                                value: _numberOfTaskImage,
                                min: 1.0,
                                max: 50.0,
                                onChanged: (value) {
                                  setState(() {
                                    _numberOfTaskImage = value;
                                  });
                                },
                                label: "$_numberOfTaskImage",
                              ),
                            ],
                          ),
                        if (selectedType == MultipleChoiceTaskType)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.circle,
                                color: Colors.grey[700],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  maxLines: 10,
                                  scrollPhysics: BouncingScrollPhysics(),
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    hintText: "Option",
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {

                                },
                                icon: Icon(Icons.clear),
                              ),
                            ],
                          )
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
