import 'package:event_calender/model/categories.dart';
import 'package:event_calender/model/realm_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:realm/realm.dart';
import 'package:intl/intl.dart';

const realmAdditionalDetailsRoute = '/realmAdditionalDetails';

class RealmAdditionalDetails extends StatefulWidget {
  const RealmAdditionalDetails({super.key});

  @override
  State<RealmAdditionalDetails> createState() => _RealmAdditionalDetailsState();
}

class _RealmAdditionalDetailsState extends State<RealmAdditionalDetails> {
  // String realmText = '';
  //String tempText = '';
  Color pickerColor = Colors.blue;
  String routineDesc = '';
  String numMinutes = '';
  var isChecked = false;
  DateTime? selectedDateTime;
  RoutineLabel routineLabel = RoutineLabel.noHat;
  TimeOfTheDay timeOfTheDay = TimeOfTheDay.none;

  var config =
      Configuration.local([RealmAdditionalNotes.schema], schemaVersion: 3);
  late Realm realm;

  @override
  void initState() {
    super.initState();

    realm = Realm(config);

    // var tempObject = realm.query<RealmTest>(r'id == $0', [01]);

    // if (tempObject.isNotEmpty) {
    //   setState(() {
    //     realmText = tempObject[0].testString;
    //   });
    // }
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  void showColorModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          height: 500,
          child: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              colorPickerWidth: 300,
              pickerAreaHeightPercent: 0.7,
              enableAlpha: true,
              labelTypes: const [ColorLabelType.hsl, ColorLabelType.hsv],
              displayThumbColor: true,
              paletteType: PaletteType.hsl,
              pickerAreaBorderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
              hexInputBar: true,
              //onHistoryChanged: widget.onHistoryChanged,
            ),
          ),
        );
      },
    );
  }

  void handleSubmit() {
    // RealmAdditionalNotes tempItem = RealmAdditionalNotes(
    //   const uuid.Uuid().v1(),
    //   routineDesc,
    //   RealmHelper.mapTimeOfTheDay(timeOfTheDay),
    //   numMinutes,
    //   RealmHelper.mapRoutineLabel(routineLabel),
    //   RealmHelper.mapColorToInt(pickerColor),
    //   isChecked,
    // );

    // realm.write(() {
    //   realm.add(tempItem);
    // });
    bool success = RealmHelper.addAdditionalNotes(
      realm,
      routineDesc,
      timeOfTheDay,
      numMinutes,
      routineLabel,
      pickerColor,
      true,
    );

    if (success) {
      print("Data added successfully");
      //clear data
    } else {
      print("Failed to add data");
    }
  }

  void assignTimeOfTheDay(DateTime dt) {
    print(" date --- ${DateFormat.Hm().format(dt)}");
    int hour = dt.hour;

    setState(() {
      if (hour >= 4 && hour < 7) {
        timeOfTheDay = TimeOfTheDay.earlyMorning;
      } else if (hour >= 7 && hour < 12) {
        timeOfTheDay = TimeOfTheDay.morning;
      } else if (hour >= 12 && hour < 16) {
        timeOfTheDay = TimeOfTheDay.afternoon;
      } else if (hour >= 16 && hour < 20) {
        timeOfTheDay = TimeOfTheDay.evening;
      } else {
        timeOfTheDay = TimeOfTheDay.night;
      }
    });
  }

  void dateTimePickerWidget(BuildContext ctx) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime:
          selectedDateTime != null ? selectedDateTime! : DateTime.now(),
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          selectedDateTime = dateTime;
        });
        assignTimeOfTheDay(dateTime);
        // DateTime selectdate = dateTime;
        // final selIOS = DateFormat('dd-MMM-yyyy - HH:mm').format(selectdate);
        //print(dateTime);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realm DB test'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'routine Desc',
                ),
                onChanged: (value) {
                  setState(() {
                    routineDesc = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'minutes',
                ),
                onChanged: (value) {
                  setState(() {
                    numMinutes = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              // TextField(
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Routine Label',
              //   ),
              //   onChanged: (value) {
              //     setState(() {
              //       tempText = value;
              //     });
              //   },
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Routine Label'),
                  DropdownButton<RoutineLabel>(
                    value: routineLabel,
                    onChanged: (RoutineLabel? newLabel) {
                      setState(() {
                        routineLabel = newLabel!;
                      });
                    },
                    items: RoutineLabel.values
                        .map<DropdownMenuItem<RoutineLabel>>(
                            (RoutineLabel value) {
                      return DropdownMenuItem<RoutineLabel>(
                        value: value,
                        child: Text(value.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Color'),
                  const SizedBox(width: 50),
                  InkWell(
                    onTap: showColorModal,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: pickerColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text('Checked'),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Date Time'),
                  TextButton(
                    onPressed: () {
                      dateTimePickerWidget(context);
                    },
                    child: Text(selectedDateTime != null
                        ? DateFormat('dd-MMM-yyyy - HH:mm')
                            .format(selectedDateTime!)
                        : 'Select'),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Time Of The Day'),
                  Text(timeOfTheDay.value),
                ],
              ),
              const SizedBox(height: 50),
              OutlinedButton(
                  onPressed: () {
                    handleSubmit();
                  },
                  child: const Text('Submit Text')),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
