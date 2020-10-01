import 'package:flutter/cupertino.dart';

class ImageTask {
  final String type;
  final String submittedUser;
  final String taskHeader;
  final String taskDescription;
  final List<String> submittedImageUrlList;

  ImageTask({
    @required this.type,
    @required this.submittedUser,
    @required this.taskHeader,
    @required this.taskDescription,
    @required this.submittedImageUrlList,
  });
}
