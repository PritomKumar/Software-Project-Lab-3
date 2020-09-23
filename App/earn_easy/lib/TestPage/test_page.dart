import 'dart:io';

import 'package:earneasy/models/gig.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class TestBox extends StatefulWidget {
  final List<GigMini> gigs = List<GigMini>();

  @override
  _TestBoxState createState() => _TestBoxState();
}

class _TestBoxState extends State<TestBox> {
  bool isExpanded = false;
  static const List<String> sortOptionsArray = ["Distance", "Money", "Title"];
  String sortOption = sortOptionsArray[0];
  String sortResult = "";
  final gigs = [
    GigMini(
      title: "First",
      money: 100,
      gigId: "fsdfuhfsjkdfhu",
    ),
    GigMini(
      title: "Second",
      money: 200,
      gigId: "fsdfuhfsjkdfhu",
    ),
    GigMini(
      title: "Third",
      money: 300,
      gigId: "fsdfuhfsjkdfhu",
    ),
    GigMini(
      title: "Fourth",
      money: 400,
      gigId: "fsdfuhfsjkdfhu",
    )
  ];

  @override
  Widget build(BuildContext context) {
    //sort function
    //gigs.sort((a, b) => b.money.compareTo(a.money));
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Card(
            elevation: 15.0,
            shadowColor: Colors.green,
            color: Colors.blue,
            child: SizedBox(
              child: ExpansionTile(
                onExpansionChanged: (bool value) {
                  setState(() {
                    isExpanded = value;
                  });
                },
                title: Text("Title"),
                backgroundColor: Colors.white,
                subtitle: Text("Subtitle "),
                trailing: SizedBox(
                  width: 120.0,
                  child: PopupMenuButton(
                    elevation: 5.0,
                    enabled: isExpanded,
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          sortResult == "" ? "Sort By" : sortOption,
                          textScaleFactor: 1.15,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.sort,
                          size: 30.0,
                        ),
                      ],
                    ),
                    itemBuilder: (context) {
                      return sortOptionsArray.map((String choice) {
                        return PopupMenuItem(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                    onSelected: (value) {
                      setState(() {
                        sortOption = value;
                        sortResult = value;
                        print(sortOption);
                        switch (sortOption) {
                          case "Distance":
                            gigs.sort((a, b) => b.money.compareTo(a.money));
                            break;
                          case "Money":
                            gigs.sort((a, b) => b.money.compareTo(a.money));
                            break;
                          case "Title":
                            gigs.sort((a, b) => a.title.compareTo(b.title));
                            break;
                          default:
                            gigs.sort((a, b) => b.money.compareTo(a.money));
                            break;
                        }
                      });
                    },
                  ),
                ),
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: ListView.builder(
                      itemCount: gigs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(gigs[index].title),
                          subtitle: Text("TODO"),
                          trailing: Text(
                            gigs[index].money.toString(),
                            textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: true,
                              applyHeightToLastDescent: true,
                            ),
                            textScaleFactor: 1.5,
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            print(gigs[index].toMap());
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  //Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    ImagePicker imagePicker;
    PickedFile selected = await imagePicker.getImage(source: source);
    setState(() {
      if (selected != null) {
        _imageFile = File(selected.path) ?? _imageFile;
      }
    });
  }

  //Cropper
  Future<void> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop It',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    setState(() {
      _imageFile = croppedFile ?? _imageFile;
    });
  }

  _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () {
                _pickImage(ImageSource.camera);
              },
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () {
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          if(_imageFile!=null) ...[
            Image.file(_imageFile),
            Row(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),

            Uploader(file: _imageFile),
          ]
        ],
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;

  const Uploader({Key key, this.file}) : super(key: key);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

