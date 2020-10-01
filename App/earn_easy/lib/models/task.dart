abstract class Task {
  final String type;
  final String submittedUser;
  final String taskHeader;
  final String taskDescription;

  Task(Set<String> set, {this.type, this.submittedUser, this.taskHeader, this.taskDescription});
}

class ImageTask extends Task {
  final List<String> imageFileUrlList;

  ImageTask({String type, String submittedUser, String taskHeader,
      String taskDescription, this.imageFileUrlList})
      : super({type, submittedUser, taskHeader, taskDescription});
}
