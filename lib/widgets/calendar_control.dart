import 'package:calendar_view/calendar_view.dart';
import 'package:event_calender/widgets/add_event_modal.dart';
import 'package:event_calender/widgets/custom_filled_cell.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var format = DateFormat.yMMM();
var dayFormat = DateFormat('EEE, d');

class CalendarControl extends StatefulWidget {
  const CalendarControl(
      {super.key, required this.eventController, required this.calendarType});
  final dynamic eventController;
  final String calendarType;

  @override
  State<CalendarControl> createState() {
    return _CalenderControllState();
  }
}

class _CalenderControllState extends State<CalendarControl> {
  void openAddEventForm() => showDialog(
        context: context,
        builder: (ctx) => const AddEventModal(),
      );

  @override
  Widget build(BuildContext context) {
    final String calendarType = widget.calendarType;
    return Column(
      children: [
        if (calendarType == 'week')
          Expanded(
            child: WeekView(
              weekPageHeaderBuilder: (startDate, endDate) => Container(),
              startDay: WeekDays.sunday,
            ),
          ),
        if (calendarType == 'day')
          Expanded(
            child: DayView(
              eventTileBuilder:
                  (date, events, boundary, startDuration, endDuration) => Text(
                date.toString(),
              ),
              dayTitleBuilder: (date) {
                final dayString = dayFormat.format(date).split(',');
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          dayString[0],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.blueAccent),
                        ),
                        Text(
                          dayString[1],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ),
                );
              },
              heightPerMinute: 1.2,
            ),
          ),
        if (calendarType == 'month')
          Expanded(
            child: MonthView(
              cellBuilder: (date, event, isToday, isInMonth) {
                return CustomFilledCell(
                  //highlightColor: Colors.amberAccent,
                  date: date,
                  shouldHighlight: isToday,
                  backgroundColor:  isInMonth ? Colors.white : const Color(0xfff0f0f0),
                  events: event,
                  onTileTap: (event, date) {
                    print('Tap event $event');
                  },
                );
              },
              headerBuilder: (date) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  format.format(date),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              //controller: widget.eventController,
              // cellBuilder: (date, events, isToday, isInMonth) {
              //   // Return your widget to display as month cell.
              //   return FilledCell(date: date, events: events);
              // },
              //initialMonth: DateTime(2021),
              //cellAspectRatio: 1,
              onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
              // onCellTap: (events, date) {
              //   // Implement callback when user taps on a cell.
              //   print('CEll tap $events');
              //   openAddEventForm();
              // },
              startDay: WeekDays.sunday, // To change the first day of the week.
              // This callback will only work if cellBuilder is null.
              onEventTap: (event, date) => print('Event $event'),
              onDateLongPress: (date) => print('DAte is $date'),
            ),
          ),
      ],
    );
  }
}
