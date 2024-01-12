import 'package:event_calender/model/day_plan.dart';
import 'package:event_calender/model/hat.dart';
import 'package:event_calender/screens/routines.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class EventSection extends StatefulWidget {
  const EventSection({
    super.key,
    required this.planIndex,
    required this.dayPlan,
    this.onAdditionalTaskCheck,
    this.onRoutineCheck,
    this.onAdditionalTaskReorder,
  });

  final int planIndex;
  final DayPlan dayPlan;
  final void Function(int planIndex, int taskIndex)? onAdditionalTaskCheck;
  final void Function(int planIndex, int routineIndex)? onRoutineCheck;
  final void Function(int planIndex, int oldIndex, int newIndex)? onAdditionalTaskReorder;

  @override
  State<EventSection> createState() => _EventSectionState();
}

class _EventSectionState extends State<EventSection> {
  @override
  Widget build(BuildContext context) {
    var dayPlan = widget.dayPlan;
    var sectionTitleWithCount = dayPlan.timeOfTheDay.value;
    if (dayPlan.routineList.isNotEmpty) {
      sectionTitleWithCount =
          '$sectionTitleWithCount(${dayPlan.routineList.length})';
    }
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          StickyHeader(
            header: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    dayPlan.sectionColor,
                    hatBackgroundColor(dayPlan.sectionColor),
                  ],
                ),
              ),
              child: ExpansionTile(
                onExpansionChanged: (expanded) {
                  if (dayPlan.routineList.isEmpty) {
                    Navigator.of(context).pushNamed(
                      routineScreenRoutes,
                      arguments: RoutineArguments(
                        defaultRoutineList: dayPlan.routineList,
                        gradientColor: dayPlan.sectionColor,
                      ),
                    );
                  }
                },
                shape: const Border(),
                title: Text(
                  sectionTitleWithCount,
                  style: const TextStyle(color: Colors.white),
                ),
                leading: Icon(
                  dayPlan.leadingIcon,
                  color: Colors.white,
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      routineScreenRoutes,
                      arguments: RoutineArguments(
                        defaultRoutineList: dayPlan.routineList,
                        gradientColor: dayPlan.sectionColor,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ),
                children: [
                  ...dayPlan.routineList.asMap().entries.map((entry) {
                    final e = entry.value;
                    final routineIndex = entry.key;
                    return ListTile(
                      title: Text(
                        e.routineDesc,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${e.minutes} mins',
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          if (widget.onRoutineCheck != null) {
                            widget.onRoutineCheck!(
                                widget.planIndex, routineIndex);
                          }
                        },
                        icon: const Icon(
                          Icons.check_circle_outline,
                        ),
                        color: e.checked ? Colors.green : Colors.white,
                      ),
                    );
                  }),
                ],
              ),
            ),
            // content: Column(
            //   children: [
            //     const SizedBox(
            //       height: 10,
            //     ),
            // if (dayPlan.additionalTaskList.isNotEmpty)
            //   ...dayPlan.additionalTaskList.asMap().entries.map(
            //     (entry) {
            //       final int taskIndex = entry.key;
            //       final e = entry.value;
            //       return Card(
            //         color: e.backgroundColor,
            //         child: Column(
            //           children: [
            //             ListTile(
            //               title: Text(e.title),
            //               subtitle: Text(
            //                   '${e.timeOfTheDay?.value} | ${e.minutes}'),
            //               trailing: IconButton(
            //                 icon: const Icon(Icons.check_circle_outline),
            //                 onPressed: () {
            //                   if (widget.onAdditionalTaskCheck != null) {
            //                     widget.onAdditionalTaskCheck!(
            //                         widget.planIndex, taskIndex);
            //                   }
            //                 },
            //                 color: e.checked ? Colors.green : Colors.white,
            //               ),
            //             ),
            //             Padding(
            //               padding:
            //                   const EdgeInsets.symmetric(horizontal: 15),
            //               child: Column(
            //                 children: [
            //                   const SizedBox(height: 10),
            //                   const Divider(),
            //                   const SizedBox(height: 15),
            //                   Row(
            //                     children: [
            //                       Container(
            //                         height: 25,
            //                         width: 80,
            //                         decoration: BoxDecoration(
            //                           borderRadius:
            //                               BorderRadius.circular(10),
            //                           color: Colors.grey,
            //                         ),
            //                         child: Text(
            //                           e.routineLabel.value,
            //                           textAlign: TextAlign.center,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   const SizedBox(
            //                     height: 15,
            //                   )
            //                 ],
            //               ),
            //             )
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // if(dayPlan.additionalTaskList.isEmpty)
            // const SizedBox(width: double.infinity,)
            //   ],
            // ),
            content: ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) {
                if(widget.onAdditionalTaskReorder != null) {
                  widget.onAdditionalTaskReorder!(widget.planIndex, oldIndex, newIndex);
                }
              },
              children: [
                ...dayPlan.additionalTaskList.asMap().entries.map(
                  (entry) {
                    final int taskIndex = entry.key;
                    final e = entry.value;
                    return Card(
                      key: ValueKey('$entry-$taskIndex'),
                      color: e.backgroundColor,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(e.title),
                            subtitle:
                                Text('${e.timeOfTheDay?.value} | ${e.minutes}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.check_circle_outline),
                              onPressed: () {
                                if (widget.onAdditionalTaskCheck != null) {
                                  widget.onAdditionalTaskCheck!(
                                      widget.planIndex, taskIndex);
                                }
                              },
                              color: e.checked ? Colors.green : Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey,
                                      ),
                                      child: Text(
                                        e.routineLabel.value,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (dayPlan.additionalTaskList.isEmpty)
            const SizedBox(
              width: double.infinity,
            )
        ],
      ),
    );
  }
}
