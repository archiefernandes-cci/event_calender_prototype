import 'package:event_calender/model/categories.dart';
import 'package:event_calender/model/routine.dart';
import 'package:flutter/material.dart';

class DayPlan {
  TimeOfTheDay timeOfTheDay;
  List<Routine> routineList;
  List<Routine> additionalTaskList;
  Color sectionColor;
  IconData leadingIcon;
  DayPlan({
    required this.timeOfTheDay,
    required this.routineList,
    required this.additionalTaskList,
    required this.sectionColor,
    required this.leadingIcon,
  });
}
