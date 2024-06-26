
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:nstracker/backend/database.dart';
import 'package:nstracker/backend/functionsVariables.dart';
import 'package:nstracker/backend/homepage_provider.dart';
import 'package:nstracker/pages/homepage.dart';
import 'package:nstracker/pages/settings.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {

  await initializeHive();

  await Hive.openBox('holidayListBox'); // open a Hive box to store the date and the corresponding name of the public holiday

  if (await checkInternetConnection()){ //if there is a connection, refresh my Hive box that contains the holidays so that it refreshes for a new year
    holidayBox.clear();
  }

  await checkHolidayBoxEmpty(); // function to check if the Hive box is empty by any chance, and populate it if it is empty

  await Hive.openBox('homepageDisplay'); // open a Hive box to store the variables displayed on the Homepage

  if (homepageBox.isEmpty){
    await setDefaultValuesHomepage();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomepageProvider(
          leavesLeftNotifier: homepageBox.get('leavesLeft'), 
          ipptDisplay: homepageBox.get('ipptResult'), 
          daysToPayDay: homepageBox.get('daysToPayDay'),
          progressValue: progressValue,
          displayProgressCompleted: displayProgressCompleted,
          progressCompleted: progressCompleted,
          progressCompletedDisplay: progressCompletedDisplay,
          displayDaysToORD: displayDaysToORD,
          )
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.chakraPetchTextTheme(),
            brightness: Brightness.dark,
          ),
          home: const HomePage(),
          routes: <String, WidgetBuilder>{
            '/settings': (BuildContext context) => const SettingsPage()
          }
        ),
    );
  }
}

Future<bool> checkInternetConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  // ignore: unrelated_type_equality_checks
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}