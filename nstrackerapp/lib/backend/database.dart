import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

// initialise the Hive
Future<void> initializeHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
}

// Function to update the Hive box 'holidayListBox' with the public holidays of the current year
Future<Box<dynamic>> fetchPublicHolidays() async {
  String thisYear = DateTime.now().year.toString();
  final url = Uri.parse(
      'https://date.nager.at/api/v3/PublicHolidays/$thisYear/SG'); // Replace with your API URL
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final holidayDataList = jsonDecode(response.body) as List<dynamic>;

    final holidayBox = Hive.box('holidayListBox');

    for (var holiday in holidayDataList) {
      await holidayBox.put(holiday['date'], holiday['name']);
    }

    return holidayBox;
  } else {
    throw Exception('Failed to fetch public holidays');
  }
}

// get DateTime for a date that is certain number of months and years in the future
DateTime addMonthsAndYears(DateTime date, int monthsToAdd, int yearsToAdd) {
  final targetYear = date.year + yearsToAdd;
  final targetMonth =
      (date.month + monthsToAdd) % 12; // Wrap around for months exceeding 12
  int targetDay = date.day;

  // Handle potential overflow for very large years (more than 9999)
  if (targetYear > 2100) {
    return DateTime(2100, targetMonth,
        targetDay); // Return a max year with adjusted month and day
  }

  // Adjust for days based on month length and leap years
  final daysInTargetMonth =
      DateTime(targetYear, targetMonth + 1, 0).day; // Get days in target month
  if (targetDay > daysInTargetMonth) {
    targetDay =
        daysInTargetMonth; // Adjust day if it exceeds the target month's length
  }

  return DateTime(targetYear, targetMonth,
      targetDay - 1); // Months are 0-indexed (January = 0)
}

// fill the Settings Hive box with default values
Future<void> fillSettingsWithDefaultValues() async {
  final settingsBox = await Hive.openBox('settings');
  settingsBox.put('enlistmentDate', DateTime.now());
  final defaultValues = {
    'serviceDurationInMonths': 24,
    'years': 2,
    'months': 0,
    'enlistmentDate' : DateTime.now(),
    'ordDate': addMonthsAndYears(settingsBox.get('enlistmentDate'), 0, 2),
    '8th of every month': 8,
    '9th of every month': 9,
    '10th of every month': 10,
    '12th of every month': 12,
    'days to next pay day': 0,
    'leavesLeft': 14.0,
    'latestIPPTScore': 69,
  };

  for (final key in defaultValues.keys) {
    if (!settingsBox.containsKey(key)) {
      await settingsBox.put(key, defaultValues[key]);
    }
  }
}
