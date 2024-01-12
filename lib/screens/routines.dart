import 'package:event_calender/model/categories.dart';
import 'package:event_calender/model/dummy_event_list.dart';
import 'package:event_calender/model/hat.dart';
import 'package:event_calender/model/routine.dart';
import 'package:event_calender/screens/hats.dart';
import 'package:flutter/material.dart';

const routineScreenRoutes = '/routines';

class RoutineArguments {
  final List<Routine>? defaultRoutineList;
  final Color? gradientColor;

  RoutineArguments({
    this.defaultRoutineList = const [],
    this.gradientColor,
  });
}

class Routines extends StatefulWidget {
  const Routines({
    super.key,
  });

  @override
  State<Routines> createState() => _RoutinesState();
}

class _RoutinesState extends State<Routines> {
  final textController = TextEditingController();

  List<Routine> routineList = [];
  List<Routine> recomendedRoutineList = List.from(dummyRoutineList);
  late FocusNode textFocusNode;
  var iIconIndex = -1;
  bool _isInitializedFromNavArg = false;

  @override
  void initState() {
    super.initState();
    textFocusNode = FocusNode();
  }

  void addRoutine() {
    if (textController.text.isNotEmpty) {
      String routineDesc = textController.text;
      final newRoutine = Routine(
        routineDesc: routineDesc,
        routineLabel: RoutineLabel.noHat,
        routineOccurance: 'Occurs Every Day',
      );
      setState(() {
        routineList.add(newRoutine);
        textController.clear();
      });
    } else {
      setState(() {
        textFocusNode.requestFocus();
      });
    }
  }

  void addRecomendedRoutine(Routine routine) {
    setState(() {
      routine.routineOccurance = 'Occures Every Day';
      routineList.add(routine);
      recomendedRoutineList.remove(routine);
    });
  }

  void editRoutineDesc(int routineIndex, String newRoutineDesc) {
    routineList[routineIndex].routineDesc = newRoutineDesc;
  }

  void setIconIndex(int index) {
    setState(() {
      iIconIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
    textFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RoutineArguments arguments =
        (ModalRoute.of(context)?.settings.arguments as RoutineArguments?) ??
            RoutineArguments();

    if (!_isInitializedFromNavArg) {
      routineList = [...arguments.defaultRoutineList!];
      _isInitializedFromNavArg = true;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              arguments.gradientColor != null
                  ? arguments.gradientColor!
                  : const Color.fromARGB(255, 248, 124, 28),
              arguments.gradientColor != null
                  ? hatBackgroundColor(arguments.gradientColor!)
                  : const Color.fromARGB(255, 255, 172, 47),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Your routines',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 5, 5),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  addRoutine();
                                },
                                icon: const Icon(Icons.add)),
                            Expanded(
                              child: TextFormField(
                                focusNode: textFocusNode,
                                controller: textController,
                                decoration: const InputDecoration(
                                  hintText:
                                      'Add the routines that fill your day...',
                                  border: InputBorder.none,
                                ),
                                onFieldSubmitted: (value) {
                                  addRoutine();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (routineList.isNotEmpty)
                        ...List.generate(
                          routineList.length,
                          (index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Divider(),
                                        ListTile(
                                          title: Row(
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  initialValue:
                                                      routineList[index]
                                                          .routineDesc,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  onChanged: (value) {
                                                    editRoutineDesc(
                                                        index, value);
                                                  },
                                                  onTap: () {
                                                    setIconIndex(index);
                                                  },
                                                ),
                                              ),
                                              if (index == iIconIndex)
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            hatsScreenRoutes);
                                                  },
                                                  icon: const Icon(Icons.info),
                                                )
                                            ],
                                          ),
                                          // Text(
                                          //   routineList[index].routineDesc,
                                          // ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 20,
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.grey,
                                                  ),
                                                  child: Text(
                                                    routineList[index]
                                                        .routineLabel
                                                        .value,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                if (routineList[index]
                                                        .routineOccurance !=
                                                    null)
                                                  Text(routineList[index]
                                                      .routineOccurance!),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
              if (recomendedRoutineList.isNotEmpty)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Recomended routines',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              if (recomendedRoutineList.isNotEmpty)
                Card(
                  child: Column(
                    children: List.generate(
                      recomendedRoutineList.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        recomendedRoutineList[index]
                                            .routineDesc,
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 80,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey,
                                              ),
                                              child: Text(
                                                recomendedRoutineList[index]
                                                    .routineLabel
                                                    .value,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          addRecomendedRoutine(
                                              recomendedRoutineList[index]);
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ),
                                    if (index !=
                                        recomendedRoutineList.length - 1)
                                      const Divider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
