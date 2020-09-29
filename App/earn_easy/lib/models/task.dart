abstract class Task {
  final String type;
  final String submittedUser;
  final String taskHeader;
  final String taskDescription;

  Task(this.type, this.submittedUser, this.taskHeader, this.taskDescription);
}

class ImageTask extends Task {
  final List<String> imageFileList;

  ImageTask(String type, String submittedUser, String taskHeader,
      String taskDescription, this.imageFileList)
      : super(type, submittedUser, taskHeader, taskDescription);
}
