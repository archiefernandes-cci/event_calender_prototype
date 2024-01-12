import 'package:event_calender/screens/add_event.dart';
import 'package:event_calender/screens/calendar.dart';
import 'package:event_calender/screens/custom_frequency.dart';
import 'package:event_calender/screens/frequency.dart';
import 'package:event_calender/screens/hat_color_picker.dart';
import 'package:event_calender/screens/hats.dart';
import 'package:event_calender/screens/realm_additional_details.dart';
import 'package:event_calender/screens/routines.dart';
//import 'package:event_calender/screens/test_realm.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes = {
  calendarScreenRouteName: (ctx) => const CalendarScreen(),
  addEventScreenRoute: (ctx) => const AddEvent(),
  routineScreenRoutes: (ctx) => const Routines(),
  hatsScreenRoutes: (ctx) => const Hats(),
  hatColorPickerScreenRoute: (ctx) => const HatColorPicker(),
  frequencyScreenRoute:(ctx) => const Frequency(),
  customFrequencyScreenRoute: (ctx) => const CustomFrequency(),
  //realmTestRoute: (ctx) => const TestRealm(),
  realmAdditionalDetailsRoute: (ctx) => const RealmAdditionalDetails(),
};
