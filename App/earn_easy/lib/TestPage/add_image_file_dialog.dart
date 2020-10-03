import 'package:earneasy/models/task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_task.dart';

class AddImageTaskDialog extends StatefulWidget {
  @override
  _AddImageTaskDialogState createState() => _AddImageTaskDialogState();
}

class _AddImageTaskDialogState extends State<AddImageTaskDialog> {
  var _taskDescriptionController = TextEditingController();
  var _numberOfImageController = TextEditingController();
  double _numberOfTaskImage = 1.0;

  @override
  Widget build(BuildContext context) {
    _numberOfImageController.text = _numberOfTaskImage.round().toString();
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      title: Center(child: Text("Add Task")),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15.0),
          child: TextFormField(
            controller: _taskDescriptionController,
            decoration: InputDecoration(hintText: "Description"),
            autovalidate: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: true,
            validator: (value) {
              return value.isEmpty ? "Enter Description" : null;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            runAlignment: WrapAlignment.start,
            children: <Widget>[
              // SizedBox(
              //   width: 30.0,
              //   child: TextFormField(
              //     controller: numberofImageController,
              //     decoration: InputDecoration(hintText: "Image number"),
              //     autovalidate: true,
              //     textAlign: TextAlign.center,
              //     keyboardType: TextInputType.number,
              //     maxLines: null,
              //     onFieldSubmitted: (value) {
              //       setState(() {
              //         numberOfTaskImage =
              //             double.parse(numberofImageController.text);
              //       });
              //     },
              //     validator: (value) {
              //       return value.isEmpty ? "Enter number of image" : null;
              //     },
              //   ),
              // ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    child: Container(
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
                  Text(
                    "${_numberOfTaskImage.round()}",
                    textAlign: TextAlign.center,
                    textScaleFactor: 2.0,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
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
        ),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              elevation: 5.0,
              splashColor: Colors.blue[700],
              autofocus: true,
              color: Colors.blue,
              onPressed: () {
                ImageTask newTask = ImageTask(
                  type: "ImageTask",
                  numberOfImages: _numberOfTaskImage.round(),
                  submittedImageUrlList: null,
                  taskDescription: _taskDescriptionController.text,
                  // need submitted user
                );
                Navigator.pop(context, newTask);
              },
              child: Text(
                "Finish",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ],
      // child: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: ListView(
      //     children: <Widget>[
      //       Padding(
      //         padding: EdgeInsets.all(15.0),
      //         child: TextFormField(
      //           controller: taskDescriptionController,
      //           decoration: InputDecoration(hintText: "First Name"),
      //           validator: (value) {
      //             return value.isEmpty ? "Enter First Name" : null;
      //           },
      //         ),
      //       ),
      //       SizedBox(
      //         height: 1000,
      //       ),
      //       Padding(
      //         padding: EdgeInsets.all(15.0),
      //         child: Text(
      //           'Awesome',
      //           style: TextStyle(color: Colors.red),
      //         ),
      //       ),
      //       Padding(padding: EdgeInsets.only(top: 50.0)),
      //       FlatButton(
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //           child: Text(
      //             'Got It!',
      //             style: TextStyle(color: Colors.purple, fontSize: 18.0),
      //           )),
      //     ],
      //   ),
      // ),
    );
  }
}
