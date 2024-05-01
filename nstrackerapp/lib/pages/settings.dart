import 'dart:core';

import 'package:flutter/material.dart';
import 'package:nstracker/backend/database.dart';
import 'package:nstracker/backend/functionsVariables.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double paddingForEachBigSettingsGroup = 8.0;

  final TextEditingController _dateController = TextEditingController(text: settingsBox.get('enlistmentDate').toString().split(" ")[0]);

  @override
  Widget build(BuildContext context) {
    double maxWidthForContainerOfAllSettings =
        MediaQuery.of(context).size.width * 0.9;
    double maxWidthForEachSettingsContainer =
        maxWidthForContainerOfAllSettings * 0.95;
    double maxHeightForEachSettingsContainer = 50;

    return Scaffold(
      backgroundColor: const Color.fromARGB(153, 11, 46, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 46, 25),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Form(
            child: Column(
              children: <Widget>[
                //NSF Section
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    color: Colors.red,
                    constraints: BoxConstraints(
                      maxWidth: maxWidthForContainerOfAllSettings,
                    ),
                    child: Column(
                      children: [
                        //Section Heading
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'NSF',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        //Enilistment Date Setting
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: maxWidthForEachSettingsContainer,
                            maxHeight: maxHeightForEachSettingsContainer,
                          ),
                          height: double.maxFinite,
                          //Text and a Calendar selector
                          child: TextField(
                            controller: _dateController,
                            decoration: const InputDecoration(
                                labelText: "Enlistment Date",
                                filled: true,
                                suffixIcon: Icon(
                                  Icons.edit_calendar_rounded,
                                  size: 24,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue))),
                            readOnly: true,
                            onTap: () {
                              _selectDate(); //go on to execute the following function code at the bottom when clicked on the textfield
                            },
                          ),
                        ),
            
                        //Service Duration Settings
                        Container(
                          color: Colors.blue,
                          constraints: BoxConstraints(
                            maxWidth: maxWidthForEachSettingsContainer,
                            maxHeight: maxHeightForEachSettingsContainer,
                          ),
                          height: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Text and a dropdown menu showing 1 year 10 months and 2 years
            
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Service Duration (Months)",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              DropdownButton(
                                  value: serviceDuration,
                                  icon: const Icon(Icons.expand_more_rounded),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  items: <String>[
                                    '22',
                                    '24',
                                  ] // List of dropdown options
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      serviceDuration = newValue!;
                                    });
                                  }),
                            ],
                          ),
                        ),
            
                        //Pay Day Settings
            
                        Container(
                          color: Colors.deepPurpleAccent,
                          constraints: BoxConstraints(
                            maxHeight: maxHeightForEachSettingsContainer,
                            maxWidth: maxWidthForEachSettingsContainer,
                          ),
                          height: double.maxFinite,
                          child: Row(
                            //Text and dropdown menu showing the 10th of every month or 12th of every month
            
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text("Pay Day"),
                              ),
                              DropdownButton(
                                  value: payDayDisplayInSettings,
                                  icon: const Icon(Icons.expand_more_rounded),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  items: <String>[
                                    '8th of every month',
                                    '9th of every month',
                                    '10th of every month',
                                    '12th of every month',
                                  ] // List of dropdown options
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? payDayDropdownValue) {
                                    setState(() {
                                      payDayDisplayInSettings =
                                          payDayDropdownValue!;
                                    });
                                  }),
                            ],
                          ),
                        ),
            
                        //Leaves Left Setting
            
                        Container(
                          color: Colors.deepPurple[200],
                          constraints: BoxConstraints(
                            maxHeight: maxHeightForEachSettingsContainer,
                            maxWidth: maxWidthForEachSettingsContainer,
                          ),
                          height: double.maxFinite,
                          child: Row(
                            // this row will contain my text and a child row that consists of the arrows and number displayed
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text("Leaves Left"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: decreaseLeaves,
                                    icon: const Icon(Icons.arrow_left_rounded),
                                  ),
                                  Text(
                                    leavesLeft.toString(),
                                  ),
                                  IconButton(
                                    onPressed: increaseLeaves,
                                    icon: const Icon(Icons.arrow_right_rounded),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        //Text and a option to select left/right arrow decreasing/increasing 0.5 days respectively (set max at 14)
                      ],
                    ),
                  ),
                ),
            
                //MISC Settings
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    color: Colors.amber,
                    constraints: BoxConstraints(
                      maxWidth: maxWidthForContainerOfAllSettings,
                    ),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("MISC"),
                          ),
                        ),
                        Container(
                          color: Colors.blueGrey,
                          constraints: BoxConstraints(
                            maxWidth: maxWidthForEachSettingsContainer,
                            maxHeight: maxHeightForEachSettingsContainer,
                          ),
                          height: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Update IPPT Score",
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Container(
                                height: double.maxFinite,
                                width: 100,
                                color: Colors.brown,
                                child: TextField(
                                  controller: ipptTextController,
                                  decoration: const InputDecoration(
                                    filled: true,
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (String value) {
                                    if (value.isNotEmpty) {
                                      final parsedValue = int.tryParse(value);
                                      if (parsedValue != null) {
                                        if (parsedValue > 0 &&
                                            parsedValue <= 100) {
                                          setState(() {
                                            ippt = parsedValue;
                                            ipptTextController.text = value;
                                          });
                                        } else {
                                          ippt = 0;
                                          ipptTextController.text = '0';
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            
                //save and cancel button
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                      constraints: BoxConstraints(
                        maxWidth: maxWidthForContainerOfAllSettings,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //cancel button
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                "CANCEL",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
            
                            //Submit Button
                            ElevatedButton(
                              onPressed: () {
                                print("SAVE PRESSED");
                      
                                updateHiveBox(_dateController);

                                daysToPayDay = updateDaysToPayDay();
            
                                Navigator.pop(context);

                                setState(() {
                                  leavesLeft = settingsBox.get('leavesLeft');
                                });
                              },
                              child: const Text("SAVE"),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    // ignore: no_leading_underscores_for_local_identifiers
    DateTime? _datePicked = await showDatePicker(
        //stores the selected value/null value after the user selects the date/cancel on the calendar in the _picked variable
        context: context,
        initialDate: settingsBox.get('enlistmentDate'),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_datePicked != null) {
      //if a date has been selected
      setState(() {
        final selectedDateWithoutTime =
            DateTime(_datePicked.year, _datePicked.month, _datePicked.day).toString().split(" ")[0];
        _dateController.text = selectedDateWithoutTime; //set the text in the controller to be updated with the selected date

        settingsBox.put('enlistmentDate', selectedDateWithoutTime);
      });
    }
  }

  void increaseLeaves() async {
    if (leavesLeft + 0.5 <= 14) {

      await settingsBox.put('leavesLeft', leavesLeft + 0.5);

      setState(() {
        leavesLeft = settingsBox.get('leavesLeft');
      });
    }
  }

  void decreaseLeaves() async {
    if ((leavesLeft - 0.5) >= 0) {
      
      await settingsBox.put('leavesLeft', leavesLeft - 0.5);

      setState(() {
        leavesLeft = settingsBox.get('leavesLeft');
      });
    }
  }
}

String updateDaysToPayDay() {
  // When I press submit, get the day of pay day from the Hive Box
  int payDayFallsOn = settingsBox.get(payDayDisplayInSettings);

  // Update the variable of daysToPayDay with the string value of the number of days to the next instance of the certain pay Day that falls on the next month
  DateTime dateToday = DateTime.now();

  return DateTime(dateToday.year, dateToday.month + 1, payDayFallsOn)
      .difference(dateToday)
      .inDays
      .toString();
}

// ignore: no_leading_underscores_for_local_identifiers
Future<void> updateHiveBox(_dateController) async {
  // this is to update the enlistment date
  if (_dateController.text != '') {
    await settingsBox.put(
        'enlistmentDate', DateTime.parse(_dateController.text));

    await settingsBox.put(
        'ordDate', addMonthsAndYears(settingsBox.get('enlistmentDate'), 0, 2));
  }

  await settingsBox.put('leavesLeft', leavesLeft); //update the leaves left

  if (ipptTextController.text != settingsBox.get('latestIPPTScore')) {
    await settingsBox.put(
        'latestIPPTScore',
        int.parse(ipptTextController
            .text)); //update the latestIPPTScore only if something is entered
  }
}