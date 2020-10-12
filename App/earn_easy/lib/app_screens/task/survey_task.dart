import 'package:earneasy/app_screens/task/task_card.dart';
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
  String _selectedType = MultipleChoiceTaskType;
  double _numberOfTaskImage = 1.0;
  List<String> _multipleOptionList = List<String>();
  TextEditingController _instructionController = TextEditingController();
  List<TextEditingController> _multipleOptionControllerList =
      List<TextEditingController>();
  bool _isRequired = false;
  List<Widget> cardTest = List<Widget>();
  List<GlobalKey<TaskCardState>> _myKeyList = List<GlobalKey<TaskCardState>>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              GlobalKey<TaskCardState> _newKey = GlobalKey<TaskCardState>();
              _myKeyList.add(_newKey);
              cardTest.add(TaskCard(
                key: _myKeyList[cardTest.length],
                deleteTask: () {
                  setState(() {
                    print("Delete task Pressed");
                    cardTest.removeWhere((element) => element.key == _newKey);
                    _myKeyList.remove(_newKey);
                  });
                },
              ));
            });
          },
          elevation: 5.0,
          backgroundColor: Colors.green,
          splashColor: Colors.redAccent,
          child: Icon(
            Icons.add_circle,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(5.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                //<editor-fold desc="Test Card">
                Card(
                  elevation: 10.0,
                  shadowColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      children: <Widget>[
                        Container(
                          color: Colors.grey[100],
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: _instructionController,
                            maxLines: null,
                            scrollPhysics: BouncingScrollPhysics(),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: VeryLongTextForTestingPurpose),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
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
                            value: _selectedType,
                            items:
                                TaskTypeDropdownList.map((String dropdownItem) {
                              return DropdownMenuItem<String>(
                                value: dropdownItem,
                                child: Row(
                                  children: <Widget>[
                                    if (dropdownItem == ImageTaskType)
                                      Icon(Icons.photo_library),
                                    if (dropdownItem == MultipleChoiceTaskType)
                                      Icon(FontAwesomeIcons.dotCircle),
                                    if (dropdownItem == CheckBoxTaskType)
                                      Icon(FontAwesomeIcons.checkSquare),
                                    if (dropdownItem == DropdownTaskType)
                                      Icon(FontAwesomeIcons.chevronCircleDown),
                                    if (dropdownItem == FreeTextTaskType)
                                      Icon(FontAwesomeIcons.alignLeft),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(dropdownItem),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedType = value;
                              });
                            },
                          ),
                        ),
                        if (_selectedType == ImageTaskType)
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
                        if (_selectedType == MultipleChoiceTaskType)
                          Column(
                            children: <Widget>[
                              ListView.builder(
                                itemCount: _multipleOptionList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Row(
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
                                          controller:
                                              _multipleOptionControllerList[
                                                  index],
                                          scrollPhysics:
                                              BouncingScrollPhysics(),
                                          decoration: InputDecoration(
                                            hintText: "Option ${index + 1}",
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _multipleOptionList.removeAt(index);
                                            _multipleOptionControllerList
                                                .removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ],
                                  );
                                },
                              ),
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

                                  //<editor-fold desc="Expanded Try with add button">
                                  // Expanded(
                                  //   child: TextFormField(
                                  //     textAlign: TextAlign.start,
                                  //     maxLines: 10,
                                  //     readOnly: true,
                                  //     onTap: () {
                                  //
                                  //     },
                                  //     scrollPhysics: BouncingScrollPhysics(),
                                  //     minLines: 1,
                                  //     decoration: InputDecoration(
                                  //       hintText: "Add Option",
                                  //     ),
                                  //   ),
                                  // ),
                                  //</editor-fold>

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(
                                      top: 5.0,
                                    ),
                                    child: FlatButton(
                                      autofocus: true,
                                      splashColor: Colors.grey[500],
                                      child: Text(
                                        "Add Option",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                        textScaleFactor: 1.2,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _multipleOptionList.add("");
                                          _multipleOptionControllerList
                                              .add(TextEditingController());
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (_selectedType == CheckBoxTaskType)
                          Column(
                            children: <Widget>[
                              ListView.builder(
                                itemCount: _multipleOptionList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        FontAwesomeIcons.square,
                                        color: Colors.grey[700],
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          textAlign: TextAlign.start,
                                          controller:
                                              _multipleOptionControllerList[
                                                  index],
                                          scrollPhysics:
                                              BouncingScrollPhysics(),
                                          decoration: InputDecoration(
                                            hintText: "Option ${index + 1}",
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _multipleOptionList.removeAt(index);
                                            _multipleOptionControllerList
                                                .removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.square,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),

                                  //<editor-fold desc="Expanded Try with add button">
                                  // Expanded(
                                  //   child: TextFormField(
                                  //     textAlign: TextAlign.start,
                                  //     maxLines: 10,
                                  //     readOnly: true,
                                  //     onTap: () {
                                  //
                                  //     },
                                  //     scrollPhysics: BouncingScrollPhysics(),
                                  //     minLines: 1,
                                  //     decoration: InputDecoration(
                                  //       hintText: "Add Option",
                                  //     ),
                                  //   ),
                                  // ),
                                  //</editor-fold>

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(
                                      top: 5.0,
                                    ),
                                    child: FlatButton(
                                      autofocus: true,
                                      splashColor: Colors.grey[500],
                                      child: Text(
                                        "Add Option",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                        textScaleFactor: 1.2,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _multipleOptionList.add("");
                                          _multipleOptionControllerList
                                              .add(TextEditingController());
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (_selectedType == DropdownTaskType)
                          Column(
                            children: <Widget>[
                              ListView.builder(
                                itemCount: _multipleOptionList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${index + 1}.",
                                        textScaleFactor: 1.2,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          textAlign: TextAlign.start,
                                          controller:
                                              _multipleOptionControllerList[
                                                  index],
                                          scrollPhysics:
                                              BouncingScrollPhysics(),
                                          decoration: InputDecoration(
                                            hintText: "Option ${index + 1}",
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _multipleOptionList.removeAt(index);
                                            _multipleOptionControllerList
                                                .removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${_multipleOptionList.length + 1}.",
                                    textScaleFactor: 1.2,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),

                                  //<editor-fold desc="Expanded Try with add button">
                                  // Expanded(
                                  //   child: TextFormField(
                                  //     textAlign: TextAlign.start,
                                  //     maxLines: 10,
                                  //     readOnly: true,
                                  //     onTap: () {
                                  //
                                  //     },
                                  //     scrollPhysics: BouncingScrollPhysics(),
                                  //     minLines: 1,
                                  //     decoration: InputDecoration(
                                  //       hintText: "Add Option",
                                  //     ),
                                  //   ),
                                  // ),
                                  //</editor-fold>

                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(
                                      top: 5.0,
                                    ),
                                    child: FlatButton(
                                      autofocus: true,
                                      splashColor: Colors.grey[500],
                                      child: Text(
                                        "Add Option",
                                        style:
                                            TextStyle(color: Colors.grey[700]),
                                        textScaleFactor: 1.2,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _multipleOptionList.add("");
                                          _multipleOptionControllerList
                                              .add(TextEditingController());
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        if (_selectedType == FreeTextTaskType)
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              readOnly: true,
                              scrollPhysics: BouncingScrollPhysics(),
                              decoration: InputDecoration(
                                hintText: "Answer the question.",
                              ),
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.solidTrashAlt,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              "Required",
                              textScaleFactor: 1.1,
                            ),
                            Switch(
                              value: _isRequired,
                              onChanged: (value) {
                                setState(() {
                                  _isRequired = value;
                                  print(_isRequired);
                                });
                              },
                              activeTrackColor: Colors.deepPurple[200],
                              focusColor: Colors.red,
                              activeColor: Colors.deepPurple,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //</editor-fold>
                ...cardTest,
                RaisedButton(
                  child: Text(
                    "Finish",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    textScaleFactor: 1.2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5.0,
                  color: Colors.yellow[800],
                  splashColor: Colors.blue[700],
                  onPressed: () {
                    for (int i = 0; i < _myKeyList.length; i++) {
                      print ("Global key at index $i ${_myKeyList[i].currentState.toString()}");
                    //   var testResult = _myKeyList[i].currentState.returnTask();
                    //   if(testResult!=null){
                    //     print(testResult.toMap().toString());
                    //   }


                    }
                    print("\n\n");
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
