import 'package:event_calender/widgets/editable_checklist.dart';
import 'package:event_calender/widgets/editable_notes.dart';
import 'package:flutter/material.dart';

const addEventScreenRoute = '/addEvent';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() {
    return _AddEventState();
  }
}

class _AddEventState extends State<AddEvent> {
  List<String> eventNotes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text('This is just a test page'),
          EditableNotes(eventNotes: eventNotes),
        ],
      ),
    );
  }
}
