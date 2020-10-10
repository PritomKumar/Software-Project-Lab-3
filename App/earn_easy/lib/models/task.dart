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
  final bool require;

  CheckboxTask({
    @required this.taskId,
    @required this.gigId,
    @required this.taskDescription,
    @required this.optionList,
    @required this.require,
  });

  CheckboxTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.taskDescription = data["taskDescription"],
        this.optionList = List.from(data["optionList"]
            .map((index) => TaskOption.fromMap(index))) ??
            [],
        this.require = data["require"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'taskDescription': this.taskDescription ?? "",
      'optionList': this.optionList ?? [],
      'require': this.require ?? false,
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

  MultipleChoiceTask({
    @required this.taskId,
    @required this.gigId,
    @required this.taskDescription,
    @required this.optionList,
    @required this.require,
  });

  MultipleChoiceTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.taskDescription = data["taskDescription"],
        this.optionList = List.from(data["optionList"]
            .map((index) => TaskOption.fromMap(index))) ??
            [],
        this.require = data["require"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'taskDescription': this.taskDescription ?? "",
      'optionList': this.optionList ?? [],
      'require': this.require ?? false,
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

  DropdownTask({
    @required this.taskId,
    @required this.gigId,
    @required this.taskDescription,
    @required this.optionList,
    @required this.require,
  });

  DropdownTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.taskDescription = data["taskDescription"],
        this.optionList = List.from(data["optionList"]
            .map((index) => TaskOption.fromMap(index))) ??
            [],
        this.require = data["require"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'taskDescription': this.taskDescription ?? "",
      'optionList': this.optionList ?? [],
      'require': this.require ?? false,
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

  FreeTextTask({
    @required this.taskId,
    @required this.gigId,
    @required this.taskDescription,
    @required this.userResponse,
    @required this.require,
  });

  FreeTextTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.taskDescription = data["taskDescription"],
        this.userResponse = data["userResponse"],
        this.require = data["require"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'taskDescription': this.taskDescription ?? "",
      'userResponse': this.userResponse ?? "",
      'require': this.require ?? false,
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
  List<ImageTaskWorkerResponse> workerResponses =
      List<ImageTaskWorkerResponse>();

  ImageTask({
    @required this.taskId,
    @required this.gigId,
    @required this.taskDescription,
    @required this.numberOfImages,
    @required this.workerResponses,
    @required this.require,
  });

  ImageTask.fromMap(Map<String, dynamic> data)
      : this.taskId = data["taskId"],
        this.gigId = data["gigId"],
        this.taskDescription = data["taskDescription"],
        this.numberOfImages = data["numberOfImages"],
        this.workerResponses = List.from(data["workerResponses"]
                .map((index) => ImageTaskWorkerResponse.fromMap(index))) ??
            [],
        this.require = data["require"] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'taskId': this.taskId ?? "",
      'gigId': this.gigId ?? "",
      'taskDescription': this.taskDescription ?? "",
      'numberOfImages': this.numberOfImages ?? 0,
      'workerResponses': this.workerResponses ?? [],
      'require': this.require ?? false,
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
