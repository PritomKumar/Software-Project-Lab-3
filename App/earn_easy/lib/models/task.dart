import 'package:earneasy/shared/constants.dart';
import 'package:flutter/cupertino.dart';

class TaskSnippet {
  final String taskId;
  final String taskType;
  final String taskDescription;

  TaskSnippet({this.taskId,this.taskType, this.taskDescription});

  TaskSnippet.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.taskType = data["taskType"],
        this.taskDescription = data["taskDescription"];

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'taskType': this.taskType ?? "",
      'taskDescription': this.taskDescription ?? "",
    };
  }
}

class ImageTask {
  final String taskId;
  final String gigId;
  final String type;
  final String taskDescription;
  final int numberOfImages;
  List<ImageTaskWorkerResponse> workerResponses =
      List<ImageTaskWorkerResponse>();

  ImageTask({
    @required this.taskId,
    @required this.gigId,
    this.type = ImageTaskType,
    @required this.taskDescription,
    @required this.numberOfImages,
    @required this.workerResponses,
  });

  ImageTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.type = data["type"],
        this.taskDescription = data["taskDescription"],
        this.numberOfImages = data["numberOfImages"],
        this.workerResponses = List.from(data["workerResponses"]
                .map((index) => ImageTaskWorkerResponse.fromMap(index))) ??
            [];

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'type': this.type ?? "",
      'taskDescription': this.taskDescription ?? "",
      'numberOfImages': this.numberOfImages ?? 0,
      'workerResponses': this.workerResponses ?? [],
    };
  }
}

class ImageTaskWorkerResponse {
  final String submittedUserUid;
  List<String> submittedImageUrlList = List<String>();

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
