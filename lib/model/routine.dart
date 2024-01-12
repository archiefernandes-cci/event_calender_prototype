import 'package:event_calender/model/categories.dart';
import 'package:flutter/material.dart';

class Routine {
  String routineDesc;
  RoutineLabel routineLabel;
  String title;
  String minutes;
  bool checked;
  String? routineOccurance;
  TimeOfTheDay? timeOfTheDay;
  Color? backgroundColor;
  
  Routine({
    required this.routineDesc,
    required this.routineLabel,
    this.routineOccurance,
    this.checked = false,
    this.title = '',
    this.minutes = '',
    this.timeOfTheDay,
    this.backgroundColor,
  });
}
