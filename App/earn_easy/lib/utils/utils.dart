import 'package:earneasy/shared/constants.dart';
import 'package:flutter/material.dart';

class Utils{
  static DateTime CombineDateTimeWithTimeOfDay({DateTime dateTime, TimeOfDay timeOfDay}) {
    if (dateTime != null) {
      return timeOfDay != null
          ? DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour, timeOfDay.minute)
          : DateTime(dateTime.year, dateTime.month, dateTime.day, TimeOfDay.now().hour,
          TimeOfDay.now().minute);
    } else {
      return defaultInitializedTimestamp.toDate();
    }
  }
}