import 'package:calendar_view/calendar_view.dart';
import 'package:event_calender/screens/add_event.dart';
import 'package:event_calender/screens/frequency.dart';
import 'package:event_calender/screens/realm_additional_details.dart';
import 'package:event_calender/screens/routines.dart';
import 'package:event_calender/screens/test_realm.dart';
import 'package:event_calender/screens/test_sticky_header.dart';
import 'package:event_calender/widgets/calendar_control.dart';
import 'package:event_calender/widgets/event_sections_list.dart';
import 'package:flutter/material.dart';

const calendarScreenRouteName = '/';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  bool _showCalendarOptions = false;
  String calendarType = 'day';

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);

    _controller.addListener(() {
      setState(() {
        _showCalendarOptions = _controller.index == 2;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void changeView(String type) {
    setState(() {
      calendarType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Event Calendar'),
        actions: [
          if (_showCalendarOptions)
            PopupMenuButton(
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: const Text('Day view'),
                    onTap: () => changeView('day'),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: const Text('Week view'),
                    onTap: () => changeView('week'),
                  ),
                  PopupMenuItem<int>(
                    value: 2,
                    child: const Text('Month View'),
                    onTap: () => changeView('month'),
                  ),
                ];
              },
            )
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Tasks'),
            Tab(text: 'Events'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          const EventSectionsList(),
          //const Text('All'),
          const TestStickyHeader(),
          CalendarControl(
            eventController: CalendarControllerProvider.of(context).controller,
            calendarType: calendarType,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.of(context).pushNamed(frequencyScreenRoute);
          //Navigator.of(context).pushNamed(realmTestRoute);
          Navigator.of(context).pushNamed(realmAdditionalDetailsRoute);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
