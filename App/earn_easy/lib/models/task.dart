import 'package:earneasy/shared/constants.dart';
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
    this.type = ImageTaskType,
    @required this.taskDescription,
    @required this.numberOfImages,
    @required this.workerResponses,
  });

  ImageTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.type = data["type"],
        this.taskDescription = data["taskDescription"],
        this.numberOfImages = data["numberOfImages"],
        this.workerResponses = List.from(data["workerResponses"]
                .map((index) => ImageTaskWorkerResponse.fromMap(index))) ??
            [];

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'type': this.type ?? "",
      'taskDescription': this.taskDescription ?? "",
      'numberOfImages': this.numberOfImages ?? 0,
      'workerResponses': this.workerResponses ?? [],
    };
  }
}

class ImageTaskWorkerResponse {
  final String submittedUserUid;
  final List<String> submittedImageUrlList;

  ImageTaskWorkerResponse(
      {@required this.submittedUserUid, @required this.submittedImageUrlList});

  ImageTaskWorkerResponse.fromMap(Map<String, dynamic> data)
      : this.submittedUserUid = data["submittedUserUid"],
        this.submittedImageUrlList =
            List.from(data["submittedImageUrlList"]) ?? List<String>();

  Map<String, dynamic> toMap() {
    return {
      'submittedUserUid': this.submittedUserUid ?? "",
      'submittedImageUrlList': this.submittedImageUrlList ?? List<String>(),
    };
  }
}
