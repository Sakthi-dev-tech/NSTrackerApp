import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:nstracker/backend/functionsVariables.dart';

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

final holidayBox = Hive.box('holidayListBox');
final homepageBox = Hive.box('homepageDisplay');

Future<Null> checkHolidayBoxEmpty() async {
  if (holidayBox.isEmpty) {
    await fetchPublicHolidays();
  }
}

String nextUpcomingHolidayDate() {
  for (final key in holidayBox.keys) {
    DateTime dateBeingChecked = DateTime.parse(key);
    if (dateBeingChecked.isAfter(DateTime.now())) {
      return key;
    }
  }

  return "Error finding the next Holiday";
}

String upcomingHolidayNameFunction({required String dateForUpcomingHoliday}) {
  return holidayBox.get(dateForUpcomingHoliday);
}

Future<void> setDefaultValuesHomepage() async {
  for (final key in homepageVariables.keys){
    if (!homepageBox.containsKey(key)){
      homepageBox.put(key, homepageVariables[key]);
    }
  }

  await homepageBox.put('progressValue', 0.0);
}