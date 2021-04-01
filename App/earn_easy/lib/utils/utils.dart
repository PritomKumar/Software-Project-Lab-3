import 'package:earneasy/app_screens/task/checkbox_task.dart';
import 'package:earneasy/app_screens/task/dropdown_task.dart';
import 'package:earneasy/app_screens/task/free_text_task.dart';
import 'package:earneasy/app_screens/task/image_task.dart';
import 'package:earneasy/app_screens/task/multiple_choice_task.dart';
import 'package:earneasy/models/task.dart';
import 'package:earneasy/models/user.dart';
import 'package:earneasy/services/firestore_task_databse.dart';
import 'package:earneasy/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Utils {
  static DateTime combineDateTimeWithTimeOfDay(
      {DateTime dateTime, TimeOfDay timeOfDay}) {
    if (dateTime != null) {
      return timeOfDay != null
          ? DateTime(dateTime.year, dateTime.month, dateTime.day,
              timeOfDay.hour, timeOfDay.minute)
          : DateTime(dateTime.year, dateTime.month, dateTime.day,
              TimeOfDay.now().hour, TimeOfDay.now().minute);
    } else {
      return defaultInitializedTimestamp.toDate();
    }
  }

  static void previousAndNextNavigation(
      UserResponse userResponse, int index, BuildContext context) {
    var taskList = userResponse.taskSnippetList;
    //<editor-fold desc="Different type of task to different page Navigation">
    if (taskList[index].taskType == ImageTaskType) {
      var imageTask = DatabaseServiceTasks()
          .selectedImageTaskData(userResponse.gigId, taskList[index]);

      print(imageTask.toString());

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StreamProvider<ImageTask>.value(
                    value: imageTask,
                    child: ImageTaskScreen(),
                  )));
    }
    if (taskList[index].taskType == CheckBoxTaskType) {
      var checkBoxTask = DatabaseServiceTasks()
          .selectedCheckboxTaskData(userResponse.gigId, taskList[index]);

      print(checkBoxTask.toString());

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StreamProvider<CheckboxTask>.value(
                    value: checkBoxTask,
                    child: CheckBoxTaskScreen(index: index),
                  )));
    }
    if (taskList[index].taskType == MultipleChoiceTaskType) {
      var multipleChoiceTask = DatabaseServiceTasks()
          .selectedMultipleChoiceTaskData(userResponse.gigId, taskList[index]);

      print(multipleChoiceTask.toString());

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StreamProvider<MultipleChoiceTask>.value(
                    value: multipleChoiceTask,
                    child: MultipleChoiceTaskScreen(),
                  )));
      // print("Multiple choice = ${mul.toMap()}");
    }
    if (taskList[index].taskType == DropdownTaskType) {
      var dropdownTask = DatabaseServiceTasks()
          .selectedDropdownTaskData(userResponse.gigId, taskList[index]);

      print(dropdownTask.toString());

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StreamProvider<DropdownTask>.value(
                    value: dropdownTask,
                    child: DropdownTaskScreen(),
                  )));
    }
    if (taskList[index].taskType == FreeTextTaskType) {
      var freeTextTask = DatabaseServiceTasks()
          .selectedFreeTextTaskData(userResponse.gigId, taskList[index]);

      print(freeTextTask.toString());

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => StreamProvider<FreeTextTask>.value(
                    value: freeTextTask,
                    child: FreeTextTaskScreen(),
                  )));
    }
    //</editor-fold>
  }
}