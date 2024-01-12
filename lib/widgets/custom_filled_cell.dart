import 'package:calendar_view/calendar_view.dart';
import 'package:event_calender/widgets/show_events.dart';
import 'package:flutter/material.dart';

class CustomFilledCell<T extends Object?> extends StatelessWidget {
  /// Date of current cell.
  final DateTime date;

  /// List of events on for current date.
  final List<CalendarEventData<T>> events;

  /// defines date string for current cell.
  final StringProvider? dateStringBuilder;

  /// Defines if cell should be highlighted or not.
  /// If true it will display date title in a circle.
  final bool shouldHighlight;

  /// Defines background color of cell.
  final Color backgroundColor;

  /// Defines highlight color.
  final Color highlightColor;

  /// Color for event tile.
  final Color tileColor;

  /// Called when user taps on any event tile.
  final TileTapCallback<T>? onTileTap;

  /// defines that [date] is in current month or not.
  final bool isInMonth;

  /// defines radius of highlighted date.
  final double highlightRadius;

  /// color of cell title
  final Color titleColor;

  /// color of highlighted cell title
  final Color highlightedTitleColor;

  /// This class will defines how cell will be displayed.
  /// This widget will display all the events as tile below date title.
  const CustomFilledCell({
    Key? key,
    required this.date,
    required this.events,
    this.isInMonth = false,
    this.shouldHighlight = false,
    this.backgroundColor = Colors.blue,
    this.highlightColor = Colors.blue,
    this.onTileTap,
    this.tileColor = Colors.blue,
    this.highlightRadius = 11,
    this.titleColor = Colors.black,
    this.highlightedTitleColor = Colors.white,
    this.dateStringBuilder,
  }) : super(key: key);

  void eventDetailsModal(BuildContext context, CalendarEventData event )=> showDialog(
        context: context,
        builder: (ctx) => ShowEvents(eventData: event),
  );


  void handlBottomSheet(
    List<CalendarEventData<T>> events, BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext ctx) {
        return SizedBox(
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(15, 50, 10, 20),
                    itemCount: events.length,
                    itemBuilder: (ctx, index) {
                      print('-------------index------ $index');
                      // if (index > 0) {
                        return GestureDetector(
                          onTap: () => eventDetailsModal(context, events[index]),
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: events[index].color,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 3.0),
                            padding: const EdgeInsets.all(2.0),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    events[index].title,
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    style: events[0].titleStyle ??
                                        TextStyle(
                                          color: events[index].color.accent,
                                          fontSize: 12,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                     // } 
                      // else {
                      //   return null;
                      // }
                    },
                  ),
                ),
                ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          const SizedBox(
            height: 5.0,
          ),
          CircleAvatar(
            radius: highlightRadius,
            backgroundColor:
                shouldHighlight ? highlightColor : Colors.transparent,
            child: Text(
              dateStringBuilder?.call(date) ?? "${date.day}",
              style: TextStyle(
                color: shouldHighlight
                    ? highlightedTitleColor
                    : isInMonth
                        ? titleColor
                        : titleColor.withOpacity(0.4),
                fontSize: 12,
              ),
            ),
          ),
          if (events.isNotEmpty)
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    GestureDetector(
                      onTap: () => onTileTap?.call(events[0], events[0].date),
                      child: Container(
                        decoration: BoxDecoration(
                          color: events[0].color,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 3.0),
                        padding: const EdgeInsets.all(2.0),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                events[0].title,
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: events[0].titleStyle ??
                                    TextStyle(
                                      color: events[0].color.accent,
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          if (events.length > 1)
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    GestureDetector(
                      onTap: () => handlBottomSheet(events, context),
                      child: Container(
                        decoration: BoxDecoration(
                          color: events[0].color,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 3.0),
                        padding: const EdgeInsets.all(2.0),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '+ ${events.length - 1}',
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: events[0].titleStyle ??
                                    TextStyle(
                                      color: events[0].color.accent,
                                      fontSize: 12,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
