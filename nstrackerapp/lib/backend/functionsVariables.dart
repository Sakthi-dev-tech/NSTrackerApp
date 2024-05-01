import 'package:flutter/material.dart';
import 'package:nstracker/backend/database.dart';

import 'package:hive_flutter/hive_flutter.dart';
//Homepage Page Variables

// Progress Bar Variables
double heightForSmallWidgets = 75;

final settingsBox = Hive.box('settings');

double progressValue = (settingsBox.get('ordDate').difference(DateTime.now()).inDays + 1.0) / (settingsBox
        .get('ordDate')
        .difference(settingsBox.get('enlistmentDate'))
        .inDays);
double progressCompleted = progressValue;
String progressCompletedDisplay = progressCompleted.toStringAsFixed(2);
String displayProgressCompleted = '$progressCompletedDisplay% Done';

int daysToORD =
    (settingsBox.get('ordDate').difference(DateTime.now()).inDays + 1);
String displayDaysToORD = "$daysToORD Days Left!";

// this is everything that concerns the Upcoming Holiday

Map<String, String> holidayIconPaths = {
  "Labour Day": 'assets/icons/hard-work.png',
  "New Year's Day": 'assets/icons/newYear.png',
  "Chinese New Year": 'assets/icons/cny.png',
  "Good Friday": 'assets/icons/good-friday.png',
  "Hari Raya Puasa": 'assets/icons/harirayapuasa.png',
  "Vesak Day": 'assets/icons/vesak.png',
  "Hari Raya Haji": 'assets/icons/harirayahaji.png',
  "National Day": 'assets/icons/nationalday.png',
  "Polling Day": 'assets/icons/polling.png',
  "Deepavali": 'assets/icons/diwali.png',
  "Christmas Day": 'assets/icons/christmas.png',
};

final holidayBox = Hive.box('holidayListBox');

Null checkHolidayBoxEmpty() {
  if (holidayBox.isEmpty) {
    fetchPublicHolidays();
  }
}

String nextUpcomingHolidayDate() {
  for (final key in holidayBox.keys) {
    DateTime dateBeingChecked = DateTime.parse(key);
    if (dateBeingChecked.isAfter(DateTime.now())) {
      return key;
    }
  }

  return "Error";
}

String dateForUpcomingHoliday = nextUpcomingHolidayDate();
String upcomingHolidayName = holidayBox.get(dateForUpcomingHoliday);
String iconPath = holidayIconPaths[holidayBox.get(
    dateForUpcomingHoliday)]!; //* think of what to do when there is an approstrophe in the ''
int numberOfDaysToUpcomingHoliday =
    DateTime.parse(dateForUpcomingHoliday).difference(DateTime.now()).inDays +
        1;

class InformationWidgets extends StatefulWidget {
  final String widgetTitle;
  final String iconPath;
  final String data;

  const InformationWidgets(
      {super.key,
      required this.widgetTitle,
      required this.iconPath,
      required this.data});

  @override
  State<InformationWidgets> createState() => _InformationWidgetsState();
}

// Variables required for the Pay Day

String? daysToPayDay = settingsBox.get('days to next pay day').toString();
String payDayDisplayOnHomePage = daysToPayDay ?? '0';


// The widget for the smaller information widgets on the Homepage
class _InformationWidgetsState extends State<InformationWidgets> {
  BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.black87,
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        color: Colors.green.withOpacity(0.2), // Red shadow
        blurRadius: 5.0, // Blur radius for softness
        spreadRadius: 5.0, // Spread radius for shadow size
        offset: const Offset(5.0, 5.0), // Shadow offset
      ),
    ],
    border: Border.all(
      color: Colors.green, // Red border
      width: 2.0, // Border width
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: containerDecoration,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.4,
        ),
        child: Column(
          //to have the icon and data value on the top and the title for this particular widget at the bottom
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: Image(
                      image: AssetImage(widget.iconPath),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      widget.data),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10, bottom: 5),
              child: Align(
                  alignment: const Alignment(-1, -1),
                  child: Text(
                    widget.widgetTitle,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

//Settings Page Variables

double leavesLeft = settingsBox.get('leavesLeft');
String serviceDuration = "22";
String payDayDisplayInSettings = '8th of every month';
int ippt = settingsBox.get('latestIPPTScore');

TextEditingController ipptTextController =
    TextEditingController(text: ippt.toString());
