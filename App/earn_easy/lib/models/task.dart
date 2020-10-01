import 'package:flutter/cupertino.dart';

class ImageTask {
  final String type;
  final String submittedUser;
  final String taskDescription;
  final int numberOfImages;
  final List<String> submittedImageUrlList;

  ImageTask({
    @required this.type,
    this.submittedUser,
    @required this.taskDescription,
    @required this.numberOfImages,
    @required this.submittedImageUrlList,
  });
}
