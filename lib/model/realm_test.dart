import 'package:event_calender/model/categories.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:uuid/uuid.dart' as uuid;

part 'realm_test.g.dart';

@RealmModel()
class _RealmAdditionalNotes {
  @PrimaryKey()
  late String id;
  late String routineDesc;
  late String timeOfTheDay;
  late String minutes;
  late String routineLabel;
  late int backgroundColor;
  late bool checked;
}

class RealmHelper {
  static String mapTimeOfTheDay(TimeOfTheDay timeOfTheDay) {
    return timeOfTheDay.toString().split('.').last;
  }

  static TimeOfTheDay mapTimeOfTheDayFromString(String value) {
    return TimeOfTheDay.values.firstWhere((e) => e.toString().split('.').last == value);
  }

  static String mapRoutineLabel(RoutineLabel routineLabel) {
    return routineLabel.toString().split('.').last;
  }

  static RoutineLabel mapRoutineLabelFromString(String value) {
    return RoutineLabel.values.firstWhere((e) => e.toString().split('.').last == value);
  }

  static int mapColorToInt(Color color) {
    return color.value;
  }

  static Color mapIntToColor(int intValue) {
    return Color(intValue);
  }

  static bool addAdditionalNotes(
      Realm realm, String routineDesc, TimeOfTheDay timeOfTheDay, String numMinutes,
      RoutineLabel routineLabel, Color pickerColor, bool isChecked) {
    try {
      RealmAdditionalNotes tempItem = RealmAdditionalNotes(
        const uuid.Uuid().v1(),
        routineDesc,
        mapTimeOfTheDay(timeOfTheDay),
        numMinutes,
        mapRoutineLabel(routineLabel),
        mapColorToInt(pickerColor),
        isChecked,
      );

      realm.write(() {
        realm.add(tempItem);
      });

      // If no exception is thrown, the write operation is successful
      return true;
    } catch (e) {
      // Handle the exception or log the error
      print("Error adding data to Realm: $e");
      return false;
    }
  }
}
