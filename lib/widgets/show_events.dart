import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class ShowEvents extends StatelessWidget {
  const ShowEvents({super.key, required this.eventData});

  final CalendarEventData eventData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(eventData.event.toString()),
        content: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text('Description: '),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(eventData.description),
                  ],
                ),
                Row(
                  children: [
                    const Text('Date:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(eventData.date.toString()),
                  ],
                ),
                Row(
                  children: [
                    const Text('Start Time:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(eventData.startTime.toString()),
                  ],
                ),
                Row(
                  children: [
                    const Text('End Time:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(eventData.endTime.toString()),
                  ],
                ),
                Row(
                  children: [
                    const Text('End date:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(eventData.endDate.toString()),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
