import 'dart:io';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

const customFrequencyScreenRoute = '/customFrequency';

const defaultFrequencyText = 'Events will occure';
var frequencyText = defaultFrequencyText;
final now = DateTime.now();
final lastDayOfMonth = DateTime(now.year, now.month + 1, 0).day;
final daysOfTheWeek =
    DateFormat.EEEE(Platform.localeName).dateSymbols.STANDALONEWEEKDAYS;
final monthList =
    DateFormat.EEEE(Platform.localeName).dateSymbols.STANDALONESHORTMONTHS;

class CustomFrequency extends StatefulWidget {
  const CustomFrequency({super.key});

  @override
  State<CustomFrequency> createState() => _CustomFrequencyState();
}

class _CustomFrequencyState extends State<CustomFrequency> {
  final frequencyDropdownList = [
    'Daily',
    'Weekly',
    'Monthly',
    'Yearly',
  ];

  List<String> daysList = [];
  //List<String> weeksList = [];
  List<String> selectedWeekList = [];
  List<String> selectedMonthList = [];
  List<DateTime> _selectedDays = [];
  final List<String> onTheDay = [
    'first',
    'second',
    'third',
    'fourth',
    'fifth',
    'last'
  ];
  final List<String> onTheWeek = [
    ...daysOfTheWeek,
    'day',
    'weekday',
    'weekend day'
  ];

  DateTime _focusedDay = DateTime.utc(now.year, now.month, now.day);

  var dropdownFrequencyValue = '';
  //var dropdownDayValue = '';
  //var dropdownWeekValue = '';
  //var dropdownDaysOfTheWeek = '';
  var dropdownEveryValue = '';
  var monthOption = 'each';
  var selectedOnTheDay = '';
  var selectedOnTheWeek = '';
  var hasDaysOfWeek = false;

  @override
  void initState() {
    super.initState();
    print('month list $monthList');
    List<String> tempDaylist = [];
    for (var i = 0; i < 370; i++) {
      tempDaylist.add('${i + 1}');
    }

    // for (var i = 0; i < 30; i++) {
    //   weeksList.add('${i + 1}');
    // }

    setState(() {
      daysList = [...tempDaylist];
      //dropdownDayValue = daysList.first;
      //weeksList;
      //dropdownWeekValue = weeksList.first;
      dropdownFrequencyValue = frequencyDropdownList.first;
      //dropdownDaysOfTheWeek = daysOfTheWeek.first;
      dropdownEveryValue = '1';
    });
    print('selected days $_selectedDays');
  }

  void handleDropdownEveryChange(String value) {
    var dynamicText = getDynamicText(dropdownFrequencyValue);
    setState(() {
      dropdownEveryValue = value;
      if (int.parse(value) > 1) {
        frequencyText = '$defaultFrequencyText every $value $dynamicText' 's';
      }
    });
  }

  void resetAllFields() {
    setState(() {
      selectedWeekList = [];
      _selectedDays = [];
      selectedOnTheDay = '';
      selectedOnTheWeek = '';
      frequencyText = '$defaultFrequencyText every day';
      selectedMonthList = [];
      _focusedDay = DateTime.utc(now.year, now.month, now.day);
    });
  }

  void handleFrequencyChange(String value) {
    var dynamicText = getDynamicText(value);
    setState(() {
      dropdownFrequencyValue = value;
      frequencyText = '$defaultFrequencyText every $dynamicText';
      dropdownEveryValue = daysList.first;
      resetAllFields();

      switch (value) {
        case 'Weekly':
          selectedWeekList.add(daysOfTheWeek.first);
          break;
        case 'Monthly':
          _selectedDays.add(_focusedDay);
          selectedOnTheDay = onTheDay.first;
          selectedOnTheWeek = onTheWeek.first;
          break;
        case 'Yearly':
          selectedMonthList = [monthList.first];
          selectedOnTheDay = onTheDay.first;
          selectedOnTheWeek = onTheWeek.first;
          break;
      }
    });
  }

  void handleWeekTap(String dayOfTheweek) {
    var dynamicText = getDynamicText(dropdownFrequencyValue);
    setState(() {
      if (selectedWeekList.contains(dayOfTheweek) &&
          selectedWeekList.length > 1) {
        selectedWeekList.remove(dayOfTheweek);
      } else if (!selectedWeekList.contains(dayOfTheweek)) {
        selectedWeekList.add(dayOfTheweek);
      }
      frequencyText =
          '$defaultFrequencyText every $dropdownEveryValue $dynamicText${int.parse(dropdownEveryValue) > 1 ? 's' : ''} on ${selectedWeekList.join(', ')}';
    });
  }

  void handleMonthTap(String monthName) {
    setState(() {
      if (selectedMonthList.contains(monthName) &&
          selectedMonthList.length > 1) {
        selectedMonthList.remove(monthName);
      } else if (!selectedMonthList.contains(monthName)) {
        selectedMonthList.add(monthName);
      }
      
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    var dynamicText = getDynamicText(dropdownFrequencyValue);

    setState(() {
      _focusedDay = focusedDay;

      // Update values in a Set
      if (_selectedDays.contains(selectedDay) && _selectedDays.length > 1) {
        _selectedDays.remove(selectedDay);
      } else if (!_selectedDays.contains(selectedDay)) {
        _selectedDays.add(selectedDay);
      }

      frequencyText =
          '$defaultFrequencyText every $dropdownEveryValue $dynamicText${int.parse(dropdownEveryValue) > 1 ? 's' : ''} on ${getSelectedDateList().join(', ')}';
    });

    print('selected days $_selectedDays');
  }

  String getDynamicText(String dropdownFrequencyValue) {
    var dynamicText = 'day';
    if (dropdownFrequencyValue == 'Weekly') {
      dynamicText = 'week';
    } else if (dropdownFrequencyValue == 'Monthly') {
      dynamicText = 'month';
    } else if (dropdownFrequencyValue == 'Yearly') {
      dynamicText = 'year';
    }
    return dynamicText;
  }

  List<int> getSelectedDateList() {
    List<String> dateList = [];
    //var tempList =[];
    for (final date in _selectedDays) {
      dateList.add(date.day.toString());
    }
    final sorted = dateList.map(int.parse).toList()..sort();

    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    var dynamicText = getDynamicText(dropdownFrequencyValue);
    var showDaysOfWeeks =
        (dropdownFrequencyValue == 'Monthly' && monthOption == 'onThe') ||
            (dropdownFrequencyValue == 'Yearly' && hasDaysOfWeek);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Frequency'),
                  DropdownButton<String>(
                    value: dropdownFrequencyValue,
                    underline: const SizedBox(),
                    onChanged: (String? value) {
                      handleFrequencyChange(value!);
                    },
                    items: frequencyDropdownList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Every'),
                  DropdownButton<String>(
                    value: dropdownEveryValue,
                    underline: const SizedBox(),
                    onChanged: (String? value) {
                      handleDropdownEveryChange(value!);
                    },
                    items:
                        daysList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                            '$value ${int.parse(value) > 1 ? '${dynamicText}s' : dynamicText}'),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(frequencyText),
              const SizedBox(
                height: 20,
              ),
              if (dropdownFrequencyValue == 'Weekly')
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: daysOfTheWeek.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(daysOfTheWeek[index]),
                    trailing: selectedWeekList.contains(daysOfTheWeek[index])
                        ? const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          )
                        : const Icon(Icons.circle_outlined),
                    onTap: () => handleWeekTap(daysOfTheWeek[index]),
                  ),
                ),
              if (dropdownFrequencyValue == 'Monthly')
                Column(
                  children: [
                    Container(
                      color: monthOption == 'each' ? Colors.green : null,
                      child: ListTile(
                        title: const Text('Each'),
                        onTap: () {
                          setState(() {
                            monthOption = 'each';
                          });
                        },
                      ),
                    ),
                    Container(
                      color: monthOption == 'onThe' ? Colors.green : null,
                      child: ListTile(
                        title: const Text('On the...'),
                        onTap: () {
                          setState(() {
                            monthOption = 'onThe';
                          });
                        },
                      ),
                    ),
                    if (monthOption == 'each')
                      TableCalendar(
                        firstDay: DateTime.utc(now.year, now.month, 1),
                        lastDay:
                            DateTime.utc(now.year, now.month, lastDayOfMonth),
                        focusedDay: _focusedDay,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        headerVisible: false,
                        selectedDayPredicate: (day) {
                          // Use values from Set to mark multiple days as selected
                          return _selectedDays.contains(day);
                        },
                        onDaySelected: _onDaySelected,
                      ),
                  ],
                ),
              if (dropdownFrequencyValue == 'Yearly')
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      children: List.generate(monthList.length, (index) {
                        return Center(
                          child: InkWell(
                            onTap: () {
                              handleMonthTap(monthList[index]);
                            },
                            child: Container(
                              color:
                                  selectedMonthList.contains(monthList[index])
                                      ? Colors.green
                                      : null,
                              width: 70,
                              height: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    monthList[index],
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Days Of Week'),
                        Switch(
                          // This bool value toggles the switch.
                          value: hasDaysOfWeek,
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              hasDaysOfWeek = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              if (showDaysOfWeeks)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: selectedOnTheDay,
                      underline: const SizedBox(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedOnTheDay = value!;
                        });
                      },
                      items: onTheDay
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      value: selectedOnTheWeek,
                      underline: const SizedBox(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedOnTheWeek = value!;
                        });
                      },
                      items: onTheWeek
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
