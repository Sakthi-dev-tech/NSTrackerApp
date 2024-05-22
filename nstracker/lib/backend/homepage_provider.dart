import 'package:flutter/material.dart';
import 'package:nstracker/backend/database.dart';

import 'package:nstracker/backend/functionsVariables.dart';

class HomepageProvider extends ChangeNotifier{
  String daysToPayDay;
  String leavesLeftNotifier;
  String ipptDisplay;
  double progressValue;
  double progressCompleted;
  String progressCompletedDisplay;
  String displayProgressCompleted;
  String displayDaysToORD;

  HomepageProvider({
    required this.leavesLeftNotifier,
    required this.ipptDisplay,
    required this.daysToPayDay,
    required this.progressValue,
    required this.displayProgressCompleted,
    required this.progressCompleted,
    required this.progressCompletedDisplay,
    required this.displayDaysToORD,
  });



  String getDaysToPayDay (int payDay){
    DateTime now = DateTime.now(); // Get the current date and time
    int currentDay = now.day; // Get the current day of the month

    // Calculate the days to the next 8th
    int daysToNextEighth;

    if (currentDay < payDay) {
      // Target day is within the current month
      daysToNextEighth = payDay - currentDay;
    } else {
      // Target day has passed, calculate days for next month
      final nextMonth = DateTime(now.year, now.month + 1, 1);
      final daysInCurrentMonth = nextMonth.subtract(const Duration(days: 1)).day;
      daysToNextEighth = daysInCurrentMonth - currentDay + payDay;
    }
    return daysToNextEighth.toString();
  }

  double calculateProgressValue (String enlistmentDate, String ordDate){
    int daysBetweenEnlistmentAndORD = DateTime.parse(ordDate).difference(DateTime.parse(enlistmentDate)).inDays;
    int daysBetweenEnlistmentAndNow = daysBetweenEnlistmentAndORD - DateTime.parse(ordDate).difference(DateTime.now()).inDays - 1;

    // ignore: no_leading_underscores_for_local_identifiers
    double _progressValue = daysBetweenEnlistmentAndNow/daysBetweenEnlistmentAndORD;

    return _progressValue;
  }

  void updateHomepage({required String newLeavesLeft, required String newIPPTDisplay, required String payDay, required enlistmentDate, required ordDate}) async {

    leavesLeftNotifier = newLeavesLeft;

    ipptDisplay = newIPPTDisplay;

    int daysBetweenORDAndNow = DateTime.parse(ordDate).difference(DateTime.now()).inDays + 1;

    progressValue = calculateProgressValue(enlistmentDate, ordDate);

    progressCompleted = progressValue * 100;

    if (progressValue > 1.00){
      progressValue = 1.00;
      await homepageBox.put('progressValue', progressValue);
      progressCompleted = 100.00;
      progressCompletedDisplay = progressCompleted.toStringAsFixed(2);
      displayProgressCompleted = 'OWADIO!';
      displayDaysToORD = "0 Days Left!";
    } else {
      await homepageBox.put('progressValue', progressValue);
      progressCompletedDisplay = progressCompleted.toStringAsFixed(2);
      displayProgressCompleted = '$progressCompletedDisplay% Done';
      displayDaysToORD = "$daysBetweenORDAndNow Days Left!";
    }

    await homepageBox.put('displayDaysToORD', displayDaysToORD);
    daysToPayDay = getDaysToPayDay(daysToPayDayDictionary[payDay]!);
    await homepageBox.put('daysToPayDay', daysToPayDay);
    await homepageBox.put('payDay', daysToPayDayDictionary[payDay].toString());

    notifyListeners();
  }
}