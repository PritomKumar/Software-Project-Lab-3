import 'package:flutter/cupertino.dart';

class ImageTask {
  final String taskId;
  final String type;
  final String taskDescription;
  final int numberOfImages;
  final List<ImageTaskWorkerResponse> workerResponses;

  ImageTask({
    @required this.taskId,
    //TODO Have to create a constant for type of task , Preferably a map
    this.type = "ImageTask",
    @required this.taskDescription,
    @required this.numberOfImages,
    @required this.workerResponses,
  });
}

class ImageTaskWorkerResponse {
  final String submittedUserUid;
  final List<String> submittedImageUrlList;

  ImageTaskWorkerResponse(
      {@required this.submittedUserUid, @required this.submittedImageUrlList});

  ImageTaskWorkerResponse.fromMap(Map<String, dynamic> data)
      : this.submittedUserUid = data["submittedUserUid"],
        this.submittedImageUrlList = List.from(data["submittedImageUrlList"]) ?? List<String>();

  Map<String, dynamic> toMap() {
    return {
      'submittedUserUid': this.submittedUserUid,
      'submittedImageUrlList': this.submittedImageUrlList?? List<String>(),
    };
  }

}
