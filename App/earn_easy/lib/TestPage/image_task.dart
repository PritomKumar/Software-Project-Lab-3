import 'dart:io';

import 'package:earneasy/TestPage/upload_task.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

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
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<StorageUploadTask> _tasks = <StorageUploadTask>[];

  //Select an image via gallery or camera
  Future<void> _pickFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile selected =
        await imagePicker.getImage(source: ImageSource.camera);
    var compressedImage =
        await compressImageFromImageFile(File(selected.path) ?? _imageFile);
    setState(() {
      if (selected != null) {
        //_imageFileList.clear();
        _imageFile = File(selected.path) ?? _imageFile;
        _imageFileList.add(compressedImage);
      }
    });
  }

  Future<void> _pickFromGallery() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    var compressedImageList = result.paths.map((path) => File(path)).toList();
    for (int i = 0; i < compressedImageList.length; i++) {
      print(compressedImageList[i].path + "\n");
    }
    for (int i = 0; i < compressedImageList.length; i++) {
      compressedImageList[i] =
          await compressImageFromImageFile(compressedImageList[i]);
    }
    setState(() {
      if (compressedImageList != null) {
        //_imageFileList.clear();
        _imageFileList.addAll(compressedImageList);
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

  Future<void> uploadToFirebase() async {
    for (int i = 0; i < _imageFileList.length; i++) {
      await upload(basename(_imageFileList[i].path), _imageFileList[i].path);
    }
    //_paths.forEach((fileName, filePath) => {upload(fileName, filePath)});
  }

  Future<void> upload(fileName, filePath) async {
    String path =
        "images/ $fileName ${DateTime.now().microsecondsSinceEpoch.toString()}.png";
    final StorageReference storageRef =
        FirebaseStorage(storageBucket: "gs://earneasy-5e92c.appspot.com")
            .ref()
            .child(path);
    final StorageUploadTask uploadTask = storageRef.putFile(
      File(filePath),
    );
    setState(() {
      _tasks.add(uploadTask);
    });
  }

  int _compressQualityMatrix(int length) {
    // Less than 1 MB
    if (length < 100000 && length > 0) {
      return 80;
    }
    // between 1-2 MB
    else if (length < 200000 && length >= 100000) {
      return 70;
    }
    // between 2-3 MB
    else if (length < 300000 && length >= 200000) {
      return 65;
    }
    // between 3-4 MB
    else if (length < 400000 && length >= 300000) {
      return 60;
    }
    // between 4-5 MB
    else if (length < 500000 && length >= 400000) {
      return 55;
    }
    // between 5-6 MB
    else if (length < 600000 && length >= 500000) {
      return 50;
    }
    // between 6-7 MB
    else if (length < 700000 && length >= 600000) {
      return 45;
    }
    // between 7-8 MB
    else if (length < 800000 && length >= 700000) {
      return 40;
    }
    // between 8-9 MB
    else if (length < 900000 && length >= 800000) {
      return 35;
    }
    // between 9-10 MB
    else if (length < 1000000 && length >= 900000) {
      return 30;
    }
    // Greater than 10 MB
    else {
      return 25;
    }
  }

  CompressFormat getFormatBasedOnFile(String extension) {
    switch (extension.toLowerCase()) {
      case "png":
        return CompressFormat.png;
        break;
      case "heic":
        return CompressFormat.heic;
        break;
      case "webp":
        return CompressFormat.webp;
        break;
      default:
        return CompressFormat.jpeg;
        break;
    }
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    int compressionQuality = _compressQualityMatrix(file.lengthSync());
    // String extension = basename(file.path).split('.').last;
    // print(extension);
    // var result2 = await FlutterImageCompress.compressAssetImage(
    //   file.absolute.path,
    //   quality: compressionQuality,
    //   minHeight: 1080,
    //   minWidth: 1080,
    //   format: CompressFormat.png,
    // );
    // final u8list = Uint8List.fromList(result2);
    // ImageProvider im = MemoryImage(u8list);
    print(file.path);
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: compressionQuality,
      minHeight: 1080,
      minWidth: 1080,
      //format: getFormatBasedOnFile(extension),
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  File createFile(String path) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }

    return file;
  }

  Future<File> compressImageFromImageFile(File imgFile) async {
    // final img = AssetImage("assets/images/compress.jpg");
    // print("pre compress");
    // final config = ImageConfiguration();
    //
    // AssetBundleImageKey key = await img.obtainKey(config);
    // final ByteData data = await key.bundle.load(key.name);
    // final dir = await path_provider.getTemporaryDirectory();
    //
    // File file = createFile("${dir.absolute.path}/test.png");
    // file.writeAsBytesSync(data.buffer.asUint8List());
    //
    // final targetPath = dir.absolute.path + "/temp.jpg";
    // final image = await testCompressAndGetFile(file, targetPath);
    final dir = await path_provider.getTemporaryDirectory();
    final filePath = imgFile.absolute.path;
    print(filePath);

    final outPath = dir.absolute.path +
        "/${DateTime.now().millisecondsSinceEpoch.toString()} ${basename(filePath)}.jpg";
    print("After file");
    final image = await testCompressAndGetFile(imgFile, outPath);
    print("After Test");
    //_imageFileList.add(image);
    //await upload(basename(image.path), image.path);

    return image;
    // final dir2 = await path_provider.getExternalStorageDirectory();
    // final dir3 = await path_provider.getApplicationDocumentsDirectory();
    // // copy the file to a new path
    // if(image !=null)  {
    //   print(image.lengthSync());
    //   await image.copy('${dir2.absolute.path}/image.png');
    // }

    //provider = FileImage(imgFile);
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
    final List<Widget> uploadFileTileList = <Widget>[];
    _tasks.forEach((StorageUploadTask task) {
      final Widget tile = UploadTaskListTile(
        task: task,
        onDismissed: () => setState(() => _tasks.remove(task)),
        onDownload: () => null,
      );
      uploadFileTileList.add(tile);
    });

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
                                  onPressed: () async {
                                    File croppedImage =
                                        await _cropImage(_imageFileList[index]);
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
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton.icon(
                label: Text("Upload To FireBase"),
                icon: Icon(Icons.cloud_upload),
                onPressed: () async {
                  //compressImageFromImageFile();
                  await uploadToFirebase();
                },
              ),
            ),
            ...uploadFileTileList,
          ],
        ),
      ),
    );
  }
}
