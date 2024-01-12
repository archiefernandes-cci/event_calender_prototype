import 'package:calendar_view/calendar_view.dart';
import 'package:event_calender/model/categories.dart';
import 'package:event_calender/model/day_plan.dart';
import 'package:event_calender/model/routine.dart';
import 'package:flutter/material.dart';

DateTime get _now => DateTime.now();

List<CalendarEventData> dummyEvents = [
  CalendarEventData(
    date: _now,
    event: "Joe's Birthday",
    title: "Project meeting",
    description: "Today is project meeting.",
    startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
    endTime: DateTime(_now.year, _now.month, _now.day, 22),
  ),
  CalendarEventData(
    date: _now.add(Duration(days: 1)),
    startTime: DateTime(_now.year, _now.month, _now.day, 18),
    endTime: DateTime(_now.year, _now.month, _now.day, 19),
    event: "Wedding anniversary",
    title: "Wedding anniversary",
    description: "Attend uncle's wedding anniversary.",
  ),
  CalendarEventData(
      date: _now,
      startTime: DateTime(_now.year, _now.month, _now.day, 14),
      endTime: DateTime(_now.year, _now.month, _now.day, 17),
      event: "Football Tournament",
      title: "Football Tournament",
      description: "Go to football tournament.",
      color: Colors.amber),
  CalendarEventData(
    date: _now,
    startTime: DateTime(_now.year, _now.month, _now.day, 14),
    endTime: DateTime(_now.year, _now.month, _now.day, 17),
    event: "Football Tournament 2",
    title: "Football Tournament 2",
    description: "new event.",
    color: Colors.purple,
  ),
  CalendarEventData(
      date: _now,
      startTime: DateTime(_now.year, _now.month, _now.day, 14),
      endTime: DateTime(_now.year, _now.month, _now.day, 17),
      event: "3rd event added",
      title: "3rd Event Tournament",
      description: "3rd evntr tournament.",
      color: Colors.indigo),
  CalendarEventData(
    date: _now.add(Duration(days: 3)),
    startTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
    endTime: DateTime(_now.add(Duration(days: 3)).year,
        _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
    event: "Sprint Meeting.",
    title: "Sprint Meeting.",
    description: "Last day of project submission for last year.",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        14),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        16),
    event: "Team Meeting",
    title: "Team Meeting",
    description: "Team Meeting",
  ),
  CalendarEventData(
    date: _now.subtract(Duration(days: 2)),
    startTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        10),
    endTime: DateTime(
        _now.subtract(Duration(days: 2)).year,
        _now.subtract(Duration(days: 2)).month,
        _now.subtract(Duration(days: 2)).day,
        12),
    event: "Chemistry Viva",
    title: "Chemistry Viva",
    description: "Today is Joe's birthday.",
  ),
];

List<Routine> dummyRoutineList = [
  Routine(
    routineDesc: 'Dinner Prep',
    routineLabel: RoutineLabel.home,
    routineOccurance: '',
  ),
  Routine(
    routineDesc: 'Spend Time Outdoors',
    routineLabel: RoutineLabel.noHat,
    routineOccurance: '',
  ),
  Routine(
    routineDesc: 'Family Time',
    routineLabel: RoutineLabel.noHat,
    routineOccurance: '',
  ),
  Routine(
    routineDesc: 'Exercise',
    routineLabel: RoutineLabel.noHat,
    routineOccurance: '',
  ),
  Routine(
    routineDesc: 'Team Catch-up',
    routineLabel: RoutineLabel.noHat,
    routineOccurance: '',
  ),
];

//PlanMyDay -> routine & task Cards.
List<Routine> dummyEarlyMorningList = [
  Routine(
    routineDesc: 'Pray',
    routineLabel: RoutineLabel.home,
    routineOccurance: '',
    minutes: '15',
    timeOfTheDay: TimeOfTheDay.morning,
  ),
  Routine(
    routineDesc: 'Breakfast',
    routineLabel: RoutineLabel.me,
    routineOccurance: '',
    minutes: '20',
    timeOfTheDay: TimeOfTheDay.evening,
  ),
  Routine(
    routineDesc: 'Plan Task',
    routineLabel: RoutineLabel.noHat,
    routineOccurance: '',
    minutes: '40',
    timeOfTheDay: TimeOfTheDay.afternoon,
  ),
];

List<Routine> dummyAdditionalNotes = [
  Routine(
    routineDesc: 'Extra morning Duties',
    timeOfTheDay: TimeOfTheDay.morning,
    minutes: '30',
    routineLabel: RoutineLabel.home,
    backgroundColor: const Color.fromARGB(255, 53, 184, 245),
  ),
  Routine(
    routineDesc: 'Extra Duties afternoon',
    timeOfTheDay: TimeOfTheDay.afternoon,
    minutes: '30',
    routineLabel: RoutineLabel.home,
    backgroundColor: const Color.fromARGB(255, 114, 53, 245),
  ),
  Routine(
    routineDesc: 'Extra morning Duties 2',
    timeOfTheDay: TimeOfTheDay.earlyMorning,
    minutes: '40',
    routineLabel: RoutineLabel.noHat,
    backgroundColor: const Color.fromARGB(255, 39, 234, 45),
    checked: true,
  )
];

List<DayPlan> dymmyDayPlanList = [
  DayPlan(
    timeOfTheDay: TimeOfTheDay.earlyMorning,
    sectionColor: Colors.purple,
    leadingIcon: Icons.alarm,
    routineList: [
      Routine(
        routineDesc: 'Pray',
        routineLabel: RoutineLabel.home,
        routineOccurance: '',
        minutes: '15',
        timeOfTheDay: TimeOfTheDay.earlyMorning,
      ),
    ],
    additionalTaskList: [
      Routine(
        routineDesc: 'Extra morning Duties 2',
        timeOfTheDay: TimeOfTheDay.earlyMorning,
        minutes: '40',
        routineLabel: RoutineLabel.noHat,
        backgroundColor: const Color.fromARGB(255, 39, 234, 45),
        checked: true,
      ),
    ],
  ),
  DayPlan(
    timeOfTheDay: TimeOfTheDay.morning,
    sectionColor: const Color.fromARGB(255, 238, 186, 17),
    leadingIcon: Icons.sunny,
    routineList: [
      Routine(
        routineDesc: 'Sweep',
        routineLabel: RoutineLabel.home,
        routineOccurance: '',
        minutes: '15',
        //timeOfTheDay: TimeOfTheDay.morning,
      ),
    ],
    additionalTaskList: [
      Routine(
        routineDesc: 'Extra morning Duties 2',
        timeOfTheDay: TimeOfTheDay.morning,
        minutes: '40',
        routineLabel: RoutineLabel.noHat,
        backgroundColor: Colors.blueGrey,
        checked: true,
      ),
      Routine(
        routineDesc: 'Extra morning Duties 3',
        timeOfTheDay: TimeOfTheDay.morning,
        minutes: '30',
        routineLabel: RoutineLabel.me,
        backgroundColor: Colors.amberAccent,
        checked: false,
      ),
    ],
  ),
  DayPlan(
   leadingIcon: Icons.nightlife,
    timeOfTheDay: TimeOfTheDay.evening,
    sectionColor: Colors.indigo,
    routineList: [
      Routine(
        routineDesc: 'Watch Tv',
        routineLabel: RoutineLabel.me,
        routineOccurance: '',
        minutes: '15',
        //timeOfTheDay: TimeOfTheDay.morning,
      ),
    ],
    additionalTaskList: [
       Routine(
        routineDesc: 'Extra morning Duties 2',
        timeOfTheDay: TimeOfTheDay.morning,
        minutes: '40',
        routineLabel: RoutineLabel.noHat,
        backgroundColor: Colors.blueGrey,
        checked: true,
      ),
      Routine(
        routineDesc: 'Extra morning Duties 3',
        timeOfTheDay: TimeOfTheDay.morning,
        minutes: '30',
        routineLabel: RoutineLabel.me,
        backgroundColor: Colors.amberAccent,
        checked: false,
      ),
    ],
  ),
   DayPlan(
    timeOfTheDay: TimeOfTheDay.earlyMorning,
    sectionColor: Colors.purple,
    leadingIcon: Icons.alarm,
    routineList: [
      Routine(
        routineDesc: 'Pray',
        routineLabel: RoutineLabel.home,
        routineOccurance: '',
        minutes: '15',
        timeOfTheDay: TimeOfTheDay.earlyMorning,
      ),
    ],
    additionalTaskList: [
      Routine(
        routineDesc: 'Extra morning Duties 2',
        timeOfTheDay: TimeOfTheDay.earlyMorning,
        minutes: '40',
        routineLabel: RoutineLabel.noHat,
        backgroundColor: const Color.fromARGB(255, 39, 234, 45),
        checked: true,
      ),
    ],
  ),
  DayPlan(
    timeOfTheDay: TimeOfTheDay.morning,
    sectionColor: const Color.fromARGB(255, 238, 186, 17),
    leadingIcon: Icons.sunny,
    routineList: [
      Routine(
        routineDesc: 'Sweep',
        routineLabel: RoutineLabel.home,
        routineOccurance: '',
        minutes: '15',
        //timeOfTheDay: TimeOfTheDay.morning,
      ),
    ],
    additionalTaskList: [
      Routine(
        routineDesc: 'Extra morning Duties 2',
        timeOfTheDay: TimeOfTheDay.morning,
        minutes: '40',
        routineLabel: RoutineLabel.noHat,
        backgroundColor: Colors.blueGrey,
        checked: true,
      ),
      Routine(
        routineDesc: 'Extra morning Duties 3',
        timeOfTheDay: TimeOfTheDay.morning,
        minutes: '30',
        routineLabel: RoutineLabel.me,
        backgroundColor: Colors.amberAccent,
        checked: false,
      ),
    ],
  ),
  DayPlan(
   leadingIcon: Icons.nightlife,
    timeOfTheDay: TimeOfTheDay.evening,
    sectionColor: Colors.indigo,
    routineList: [
      Routine(
        routineDesc: 'Watch Tv',
        routineLabel: RoutineLabel.me,
        routineOccurance: '',
        minutes: '15',
        //timeOfTheDay: TimeOfTheDay.morning,
      ),
    ],
    additionalTaskList: [],
  ),
];
