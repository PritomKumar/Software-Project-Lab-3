import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ImageTask extends StatefulWidget {
  final List<File> imageFileList;

  const ImageTask({Key key, this.imageFileList}) : super(key: key);

  @override
  _ImageTaskState createState() => _ImageTaskState();
}

class _ImageTaskState extends State<ImageTask>
    with AutomaticKeepAliveClientMixin {
  bool isItemAvailable = false;
  File _imageFile;
  List<File> _imageFileList = List<File>();

  //Select an image via gallery or camera
  Future<void> _pickFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile selected =
        await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      if (selected != null) {
        //_imageFileList.clear();
        _imageFile = File(selected.path) ?? _imageFile;
        _imageFileList.add(_imageFile);
      }
    });
  }

  Future<void> _pickFromGallery() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    setState(() {
      if (result != null) {
        //_imageFileList.clear();
        _imageFileList.addAll(result.paths.map((path) => File(path)).toList());
      }
    });
  }

  //Cropper
  Future<File> _cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
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

    return croppedFile ?? imageFile;
  }

  _clear() {
    setState(() {
      _imageFile = null;
    });
  }

  Future<void> _selectImageSource() async {
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          title: Text("Choose Option "),
          elevation: 5.0,
          children: <Widget>[
            SimpleDialogOption(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.photo_camera,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("Take a photo"),
                ],
              ),
              onPressed: () async {
                print("Camera");
                Navigator.pop(context);
                await _pickFromCamera();
                for (int i = 0; i < _imageFileList.length; i++) {
                  print("File name = ${_imageFileList[i].path}\n");
                }
              },
            ),
            SimpleDialogOption(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.photo_library,
                    size: 30.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text("Browse gallery"),
                ],
              ),
              onPressed: () async {
                print("Gallery");
                Navigator.pop(context);
                await _pickFromGallery();
                for (int i = 0; i < _imageFileList.length; i++) {
                  print("File name = ${_imageFileList[i].path}\n");
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void updateKeepAlive() {
    super.updateKeepAlive();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.image,
                  size: 20.0,
                ),
                SizedBox(width: 10.0),
                Text("Photo"),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Header",
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: GridView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                // +1 for the special case
                itemCount: _imageFileList.length + 1,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: (MediaQuery.of(context).orientation ==
                            Orientation.portrait)
                        ? 3
                        : 4),
                itemBuilder: (BuildContext context, int index) {
                  return index == _imageFileList.length
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          child: Card(
                            elevation: 5.0,
                            shadowColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            borderOnForeground: true,
                            child: IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.grey[600],
                              ),
                              iconSize: 50.0,
                              splashColor: Colors.green,
                              onPressed: () {
                                _selectImageSource();
                              },
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Stack(
                            fit: StackFit.expand,
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                child: Card(
                                  elevation: 5.0,
                                  shadowColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: GridTile(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.file(
                                        _imageFileList[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -20.0,
                                right: -20.0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _imageFileList.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: -20.0,
                                left: -20.0,
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.solidEdit,
                                    color: Colors.blueAccent,
                                  ),
                                  onPressed: () async{
                                     File croppedImage = await
                                        _cropImage(_imageFileList[index]);
                                    setState(() {
                                      _imageFileList[index] = croppedImage;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
