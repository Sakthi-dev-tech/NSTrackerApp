import 'package:flutter/material.dart';
import 'package:nstracker/backend/database.dart';

//Homepage Page Variables

// Progress Bar Variables
double heightForSmallWidgets = 75;

double progressValue = homepageBox.get('progressValue');
double progressCompleted = progressValue * 100;
String progressCompletedDisplay = progressCompleted.toStringAsFixed(2);
String displayProgressCompleted = '$progressCompletedDisplay% Done';


String displayDaysToORD = homepageBox.get('displayDaysToORD');

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

Map homepageVariables = {
  "enlistmentDate": DateTime.now().toString().split(" ")[0],
  "ordDate": DateTime.now().toString().split(" ")[0],
  "displayDaysToORD": "730 Days Left!",
  "payDay": '10',
  "daysToPayDay": '8',
  "ipptResult": "69",
  "leavesLeft": '14.0',
  "serviceDuration": "22",
  "progressValue": 0.0,
};

Map<String, int> daysToPayDayDictionary = {
  '8th of every month': 8,
  '9th of every month': 9,
  '10th of every month': 10,
  '12th of every month': 12,
};

Map<String, String> payDayToDropdownValue = {
  '8': '8th of every month',
  '9': '9th of every month',
  '10': '10th of every month',
  '12': '12th of every month',
};

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

String daysToPayDay = '15';

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

String leavesLeftDisplay = homepageBox.get('leavesLeft');

String serviceDuration = homepageBox.get('serviceDuration');

String ipptDisplay = homepageBox.get('ipptResult');

TextEditingController ipptTextController =
    TextEditingController(text: ipptDisplay.toString());
