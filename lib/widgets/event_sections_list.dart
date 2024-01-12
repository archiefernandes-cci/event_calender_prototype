import 'package:event_calender/model/day_plan.dart';
import 'package:event_calender/model/dummy_event_list.dart';
import 'package:event_calender/widgets/event_section.dart';
import 'package:flutter/material.dart';

class EventSectionsList extends StatefulWidget {
  const EventSectionsList({super.key});

  @override
  State<EventSectionsList> createState() => _EventSectionsListState();
}

class _EventSectionsListState extends State<EventSectionsList> {
  List<DayPlan> tempDayPlanList = [...dymmyDayPlanList];

  void onAdditionalTaskCheck(int planIndex, int taskIndex) {
    setState(() {
      tempDayPlanList[planIndex].additionalTaskList[taskIndex].checked =
          !tempDayPlanList[planIndex].additionalTaskList[taskIndex].checked;
    });
  }

  void onRoutineCheck(int planIndex, int routineIndex) {
    setState(() {
      tempDayPlanList[planIndex].routineList[routineIndex].checked =
          !tempDayPlanList[planIndex].routineList[routineIndex].checked;
    });
  }

  void _updateDayPlanOrder(planIndex, oldIndex, newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item =
          tempDayPlanList[planIndex].additionalTaskList.removeAt(oldIndex);
      tempDayPlanList[planIndex].additionalTaskList.insert(newIndex, item);
      //tempDayPlanList.removeAt(oldIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        // child: ReorderableListView(
        //   onReorder: (oldIndex, newIndex) {
        //     _updateDayPlanOrder(oldIndex, newIndex);
        //   },
        //   children: [
        //     ...tempDayPlanList.asMap().entries.map((entry) {
        //       final planIndex = entry.key;
        //       final dayPlan = entry.value;
        //       return EventSection(
        //         key: ValueKey('$entry-$planIndex'),
        //         dayPlan: dayPlan,
        //         planIndex: planIndex,
        //         onRoutineCheck: (planIndex, routineIndex) =>
        //             onRoutineCheck(planIndex, routineIndex),
        //         onAdditionalTaskCheck: (planIndex, taskIndex) =>
        //             onAdditionalTaskCheck(planIndex, taskIndex),
        //       );
        //     }),
        //   ],
        // child: ReorderableListView(
        //   onReorder: (oldIndex, newIndex) {
        //     _updateDayPlanOrder(oldIndex, newIndex);
        //   },
        //   children: [
        //     ...tempDayPlanList.asMap().entries.map((entry) {
        //       final planIndex = entry.key;
        //       final dayPlan = entry.value;
        //       return EventSection(
        //         key: ValueKey('$entry-$planIndex'),
        //         dayPlan: dayPlan,
        //         planIndex: planIndex,
        //         onRoutineCheck: (planIndex, routineIndex) =>
        //             onRoutineCheck(planIndex, routineIndex),
        //         onAdditionalTaskCheck: (planIndex, taskIndex) =>
        //             onAdditionalTaskCheck(planIndex, taskIndex),
        //       );
        //     }),
        //   ],
        child: Column(
          children: [
            ...tempDayPlanList.asMap().entries.map((entry) {
              final planIndex = entry.key;
              final dayPlan = entry.value;
              return EventSection(
                onAdditionalTaskReorder: (planIndex, oldIndex, newIndex) =>
                    _updateDayPlanOrder(planIndex, oldIndex, newIndex),
                key: ValueKey('$entry-$planIndex'),
                dayPlan: dayPlan,
                planIndex: planIndex,
                onRoutineCheck: (planIndex, routineIndex) =>
                    onRoutineCheck(planIndex, routineIndex),
                onAdditionalTaskCheck: (planIndex, taskIndex) =>
                    onAdditionalTaskCheck(planIndex, taskIndex),
              );
            }),
          ],
        ),
      ),
    );
  }
}
