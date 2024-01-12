import 'package:event_calender/screens/add_event.dart';
import 'package:event_calender/model/dummy_event_list.dart';
import 'package:event_calender/routes.dart';
import 'package:event_calender/widgets/calendar_control.dart';
import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final calendarEventController = EventController();
    return CalendarControllerProvider(
      controller: calendarEventController..addAll(dummyEvents),
      child: MaterialApp(
        title: 'Event Calender',
        theme: ThemeData(
          //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: routes,
      ),
    );
  }
}
