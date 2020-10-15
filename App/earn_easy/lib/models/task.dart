import 'package:earneasy/models/task_option.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:flutter/cupertino.dart';

class TaskSnippet {
  final String taskId;
  final String taskType;
  final String taskDescription;
  final bool require;

  TaskSnippet({
    @required this.taskId,
    @required this.taskType,
    @required this.taskDescription,
    @required this.require,
  });

  TaskSnippet.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.taskType = data["taskType"],
        this.taskDescription = data["taskDescription"],
        this.require = data["require"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'taskType': this.taskType ?? "",
      'taskDescription': this.taskDescription ?? "",
      'require': this.require ?? false,
    };
  }
}

class CheckboxTask {
  final String taskId;
  final String gigId;
  final String type = CheckBoxTaskType;
  final String taskDescription;
  final List<TaskOption> optionList;
  final bool isCompleted;
  final bool require;

  CheckboxTask({
    @required this.taskId,
    @required this.gigId,
    @required this.taskDescription,
    @required this.optionList,
    @required this.require,
    @required this.isCompleted,
  });

  CheckboxTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.taskDescription = data["taskDescription"],
        this.optionList = List.from(data["optionList"]
            .map((index) => TaskOption.fromMap(index))) ??
            [],
        this.isCompleted = data["isCompleted"] ?? false,
        this.require = data["require"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'type': this.type ?? "",
      'taskDescription': this.taskDescription ?? "",
      'optionList':
      List.from(this.optionList.map((index) => index.toMap())) ?? [],
      'require': this.require ?? false,
      'isCompleted': this.isCompleted ?? false,
    };
  }
}


class MultipleChoiceTask {
  final String taskId;
  final String gigId;
  final String type = MultipleChoiceTaskType;
  final String taskDescription;
  final List<TaskOption> optionList;
  final bool require;
  final bool isCompleted;

  MultipleChoiceTask({
    @required this.taskId,
    @required this.gigId,
    @required this.taskDescription,
    @required this.optionList,
    @required this.require,
    @required this.isCompleted,
  });

  MultipleChoiceTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.taskDescription = data["taskDescription"],
        this.optionList = List.from(data["optionList"]
            .map((index) => TaskOption.fromMap(index))) ??
            [],
        this.isCompleted = data["isCompleted"] ?? false,
        this.require = data["require"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'type': this.type ?? "",
      'taskDescription': this.taskDescription ?? "",
      'optionList':
          List.from(this.optionList.map((index) => index.toMap())) ?? [],
      'require': this.require ?? false,
      'isCompleted': this.isCompleted ?? false,
    };
  }
}

class DropdownTask {
  final String taskId;
  final String gigId;
  final String type = DropdownTaskType;
  final String taskDescription;
  final List<TaskOption> optionList;
  final bool require;
  final bool isCompleted;

  DropdownTask({
    @required this.taskId,
    @required this.gigId,
    @required this.taskDescription,
    @required this.optionList,
    @required this.require,
    @required this.isCompleted,
  });

  DropdownTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.taskDescription = data["taskDescription"],
        this.optionList = List.from(data["optionList"]
            .map((index) => TaskOption.fromMap(index))) ??
            [],
        this.require = data["require"] ?? false,
        this.isCompleted = data["isCompleted"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'type': this.type ?? "",
      'taskDescription': this.taskDescription ?? "",
      'optionList':
      List.from(this.optionList.map((index) => index.toMap())) ?? [],
      'require': this.require ?? false,
      'isCompleted': this.isCompleted ?? false,
    };
  }
}

class FreeTextTask {
  final String taskId;
  final String gigId;
  final String type = FreeTextTaskType;
  final String taskDescription;
  final String userResponse;
  final bool require;
  final bool isCompleted;

  FreeTextTask({
    @required this.taskId,
    @required this.gigId,
    @required this.taskDescription,
    @required this.userResponse,
    @required this.require,
    @required this.isCompleted,
  });

  FreeTextTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.taskDescription = data["taskDescription"],
        this.userResponse = data["userResponse"],
        this.require = data["require"] ?? false,
        this.isCompleted = data["isCompleted"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'type': this.type ?? "",
      'taskDescription': this.taskDescription ?? "",
      'userResponse': this.userResponse ?? "",
      'require': this.require ?? false,
      'isCompleted': this.isCompleted ?? false,
    };
  }
}

class ImageTask {
  final String taskId;
  final String gigId;
  final String type = ImageTaskType;
  final String taskDescription;
  final int numberOfImages;
  final bool require;
  final bool isCompleted;
  List<ImageTaskWorkerResponse> workerResponses =
      List<ImageTaskWorkerResponse>();
  List<String> imageUrlList;

  ImageTask({
    @required this.taskId,
    @required this.gigId,
    @required this.taskDescription,
    @required this.numberOfImages,
    @required this.workerResponses,
    @required this.require,
    @required this.isCompleted,
    @required this.imageUrlList,
  });

  ImageTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.taskDescription = data["taskDescription"],
        this.numberOfImages = data["numberOfImages"],
        this.workerResponses = List.from(data["workerResponses"]
                .map((index) => ImageTaskWorkerResponse.fromMap(index))) ??
            [],
        this.imageUrlList = data["imageUrlList"] ?? [],
        this.isCompleted = data["isCompleted"] ?? false,
        this.require = data["require"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'type': this.type ?? "",
      'taskDescription': this.taskDescription ?? "",
      'numberOfImages': this.numberOfImages ?? 0,
      'workerResponses': this.workerResponses ?? [],
      'imageUrlList': this.imageUrlList ?? [],
      'require': this.require ?? false,
      'isCompleted': this.isCompleted ?? false,
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
