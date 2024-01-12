import 'package:event_calender/model/categories.dart';
import 'package:flutter/material.dart';

class AdditionalNotes {
  String id; // id will be useful to fimnd and edit the data
  String taskTitle;
  TimeOfTheDay timeOfTheDay;
  String minutes;
  RoutineLabel routineLabel;
  Color backgroundColor;
  bool checked;

  AdditionalNotes({
    required this.id,
    required this.taskTitle,
    required this.timeOfTheDay,
    required this.minutes,
    required this.routineLabel,
    this.backgroundColor = Colors.grey,
    this.checked = false,
  });
}
