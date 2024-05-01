import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


import 'package:nstracker/backend/database.dart';
import 'package:nstracker/backend/functionsVariables.dart';
import 'package:nstracker/pages/homepage.dart';
import 'package:nstracker/pages/settings.dart';

import 'package:google_fonts/google_fonts.dart';
void main() async {

  await initializeHive();

  await Hive.openBox('holidayListBox'); // open a Hive box to store the date and the corresponding name of the public holiday
  await Hive.openBox('settings'); //open a Hive box to store the settings from the user

  checkHolidayBoxEmpty(); // function to check if the Hive box is empty by any chance
  fillSettingsWithDefaultValues(); // function to fill the Settings Hive box with default values to be used

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.chakraPetchTextTheme(),
        ),
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          '/settings': (BuildContext context) => SettingsPage()
        });
  }
}
