import 'dart:io';

import 'package:earneasy/models/gig.dart';
import 'package:earneasy/services/dialog_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  //Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
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
          if (_imageFile != null) ...[
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
  final FirebaseStorage _firebaseStorage =
  FirebaseStorage(storageBucket: "gs://earneasy-5e92c.appspot.com");

  StorageUploadTask _uploadTask;

  Future<String> getImageDownloadUrlFromFirebaseStorage() async {
    var url = await (await _uploadTask.onComplete).ref.getDownloadURL();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Add More?"),
        content: Text("Add More Images?"),
        actions: <Widget>[
          FlatButton(
            child: Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("YES"),
            onPressed: () {
              setState(() {
                _uploadTask = null;
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
    return url.toString();
  }

  Future<void> _startUpload() async {
    String filePath =
        "images/${DateTime.now().millisecondsSinceEpoch.toString()}.png";
    setState(() {
      _uploadTask = _firebaseStorage.ref().child(filePath).putFile(widget.file);
    });
    String url = await getImageDownloadUrlFromFirebaseStorage();
    print(url);
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progressPercent =
          event != null ? event.bytesTransferred / event.totalByteCount : 0;

          return Column(
            children: <Widget>[
              if (_uploadTask.isComplete) Text("Upload Done"),
              if (_uploadTask.isPaused)
                FlatButton(
                  child: Icon(Icons.play_arrow),
                  onPressed: _uploadTask.resume,
                ),
              if (_uploadTask.isInProgress)
                FlatButton(
                  child: Icon(Icons.pause),
                  onPressed: _uploadTask.pause,
                ),
              LinearProgressIndicator(
                value: progressPercent,
              ),
              Text("${(progressPercent * 100).toStringAsFixed(2)} % "),
            ],
          );
        },
      );
    } else {
      return FlatButton.icon(
        label: Text("Upload To FireBase"),
        icon: Icon(Icons.cloud_upload),
        onPressed: () async {
          await _startUpload();
        },
      );
    }
  }
}