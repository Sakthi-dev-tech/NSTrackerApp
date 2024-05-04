import 'dart:core';

import 'package:flutter/material.dart';
import 'package:nstracker/backend/database.dart';
import 'package:nstracker/backend/functionsVariables.dart';
import 'package:nstracker/backend/homepage_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double leavesLeftDoubleToBeUsedInSettings = double.parse(leavesLeftDisplay);

  double paddingForEachBigSettingsGroup = 8.0;
  double marginForAllSettingsContainer = 5.0;

  BoxDecoration bigSettingsBoxDecoration = BoxDecoration(
    color: Colors.black87,
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        color:
            const Color.fromARGB(255, 3, 63, 5).withOpacity(0.5), // Red shadow
        blurRadius: 5.0, // Blur radius for softness
        spreadRadius: 5.0, // Spread radius for shadow size
        offset: const Offset(5.0, 5.0), // Shadow offset
      ),
    ],
    border: Border.all(
      color: Colors.green, // Green border
      width: 2.0, // Border width
    ),
  );

  TextStyle settingsTextDecoration = const TextStyle(
    color: Colors.white,
  );

  TextStyle settingsContainerLabelDecoration = const TextStyle(
    color: Colors.orange,
    fontSize: 20,
  );

  var dropdownList = <String>[
    '8th of every month',
    '9th of every month',
    '10th of every month',
    '12th of every month',
  ];
  var dropdownValue =
      payDayToDropdownValue[homepageBox.get('payDay')] ?? "8th of every month";

  // text controller for the date selectors in the setting page
  final TextEditingController _enlistmentDateController =
      TextEditingController(text: homepageBox.get('enlistmentDate'));
  final TextEditingController _ordDateController =
      TextEditingController(text: homepageBox.get('ordDate'));

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
                    decoration: bigSettingsBoxDecoration,
                    constraints: BoxConstraints(
                      maxWidth: maxWidthForContainerOfAllSettings,
                    ),
                    child: Column(
                      children: [
                        //Section Heading
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'NSF',
                              style: settingsContainerLabelDecoration,
                            ),
                          ),
                        ),
                        //Enilistment Date Setting
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: maxWidthForEachSettingsContainer,
                            maxHeight: maxHeightForEachSettingsContainer,
                          ),
                          margin: EdgeInsets.all(marginForAllSettingsContainer),
                          height: double.maxFinite,
                          //Text and a Calendar selector
                          child: TextField(
                            controller: _enlistmentDateController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "Enlistment Date",
                                labelStyle: TextStyle(color: Colors.white),
                                filled: true,
                                suffixIcon: Icon(
                                  Icons.edit_calendar_rounded,
                                  size: 24,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                            readOnly: true,
                            onTap: () {
                              _selectEnlistmentDate(); //go on to execute the following function code at the bottom when clicked on the textfield
                            },
                          ),
                        ),

                        //Choose ORD Date
                        Container(
                          margin: EdgeInsets.all(marginForAllSettingsContainer),
                          constraints: BoxConstraints(
                            maxWidth: maxWidthForEachSettingsContainer,
                            maxHeight: maxHeightForEachSettingsContainer,
                          ),
                          height: double.maxFinite,
                          child: TextField(
                            controller: _ordDateController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                labelText: "ORD Date",
                                labelStyle: TextStyle(color: Colors.white),
                                filled: true,
                                suffixIcon: Icon(
                                  Icons.edit_calendar_rounded,
                                  size: 24,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                            readOnly: true,
                            onTap: () {
                              _selectORDDate(); //go on to execute the following function code at the bottom when clicked on the textfield
                            },
                          ),
                        ),

                        //Pay Day Settings

                        Container(
                          margin: EdgeInsets.all(marginForAllSettingsContainer),
                          constraints: BoxConstraints(
                            maxHeight: maxHeightForEachSettingsContainer,
                            maxWidth: maxWidthForEachSettingsContainer,
                          ),
                          height: double.maxFinite,
                          child: Row(
                            //Text and dropdown menu showing the 10th of every month or 12th of every month

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Pay Day",
                                  style: settingsTextDecoration,
                                ),
                              ),
                              DropdownButton(
                                value: dropdownValue,
                                icon: const Icon(Icons.expand_more_rounded),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(color: Colors.white),
                                dropdownColor: Colors.black,
                                items: dropdownList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newDropdownValue) {
                                  setState(() {
                                    dropdownValue = newDropdownValue!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        //Leaves Left Setting

                        Container(
                          margin: EdgeInsets.all(marginForAllSettingsContainer),
                          constraints: BoxConstraints(
                            maxHeight: maxHeightForEachSettingsContainer,
                            maxWidth: maxWidthForEachSettingsContainer,
                          ),
                          height: double.maxFinite,
                          child: Row(
                            // this row will contain my text and a child row that consists of the arrows and number displayed
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "Leaves Left",
                                  style: settingsTextDecoration,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: decreaseLeaves,
                                    icon: const Icon(Icons.arrow_left_rounded),
                                  ),
                                  Text(
                                    leavesLeftDisplay,
                                    style: settingsTextDecoration,
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
                    decoration: bigSettingsBoxDecoration,
                    margin: EdgeInsets.all(marginForAllSettingsContainer),
                    constraints: BoxConstraints(
                      maxWidth: maxWidthForContainerOfAllSettings,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "MISC",
                              style: settingsContainerLabelDecoration,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(marginForAllSettingsContainer),
                          constraints: BoxConstraints(
                            maxWidth: maxWidthForEachSettingsContainer,
                            maxHeight: maxHeightForEachSettingsContainer,
                          ),
                          height: double.maxFinite,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  style: settingsTextDecoration,
                                  "Update IPPT Score",
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              SizedBox(
                                height: double.maxFinite,
                                width: 100,
                                child: TextField(
                                  style: const TextStyle(color: Colors.white),
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
                                            ipptTextController.text = value;
                                          });
                                        } else {
                                          ipptDisplay = '0';
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
                              style: TextButton.styleFrom(
                                backgroundColor: Colors
                                    .grey.shade800, // Darker grey background
                                foregroundColor:
                                    Colors.green.shade500, // Light green text
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Rounded corners
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                              ),
                              onPressed: () async {
                                await updateHomepageBox(); //update my variables into my homepageBox

                                // create a function to calculate the days between enlistment date and ORD date, days to ORD, percentage of the progress using the prev 2 var

                                // Update the variables' value thru the provider
                                if (mounted) {
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<HomepageProvider>()
                                      .updateHomepage(
                                        newLeavesLeft: leavesLeftDisplay,
                                        newIPPTDisplay: ipptTextController.text,
                                        payDay: dropdownValue,
                                        enlistmentDate:
                                            _enlistmentDateController.text,
                                        ordDate: _ordDateController.text,
                                      );
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }
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

  SnackBar snackBar = SnackBar(
    content: const Text(
        'Select an ORD date that comes after your enlistment date',
        style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.green[800],
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: 'Dismiss',
      textColor: Colors.white,
      onPressed: () {},
    ),
  );

  Future<void> _selectEnlistmentDate() async {
    // ignore: no_leading_underscores_for_local_identifiers
    DateTime? _datePicked = await showDatePicker(
      //stores the selected value/null value after the user selects the date/cancel on the calendar in the _picked variable
      context: context,
      initialDate: DateTime.parse(homepageBox.get('enlistmentDate')),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_datePicked != null) {
      //if a date has been selected
      setState(() {
        final selectedEnlistmentDateWithoutTime =
            DateTime(_datePicked.year, _datePicked.month, _datePicked.day)
                .toString()
                .split(" ")[0];
        _enlistmentDateController.text =
            selectedEnlistmentDateWithoutTime; //set the text in the controller to be updated with the selected date
      });
    }
  }

  Future<void> _selectORDDate() async {
    // ignore: no_leading_underscores_for_local_identifiers
    DateTime? _ordDatePicked = await showDatePicker(
      //stores the selected value/null value after the user selects the date/cancel on the calendar in the _picked variable
      context: context,
      initialDate: DateTime.parse(homepageBox.get('ordDate')),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_ordDatePicked != null) {
      //if a date has been selected
      if (_ordDatePicked
          .isAfter(DateTime.parse(_enlistmentDateController.text))) {
        setState(() {
          final selectedORDDateWithoutTime = DateTime(
                  _ordDatePicked.year, _ordDatePicked.month, _ordDatePicked.day)
              .toString()
              .split(" ")[0];
          _ordDateController.text =
              selectedORDDateWithoutTime; //set the text in the controller to be updated with the selected date
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              snackBar); // prompt user to change the ORD date so that it comes after their enlistment date
        }
      }
    }
  }

  void increaseLeaves() {
    if (leavesLeftDoubleToBeUsedInSettings + 0.5 <= 14) {
      setState(() {
        leavesLeftDoubleToBeUsedInSettings =
            leavesLeftDoubleToBeUsedInSettings + 0.5;
        leavesLeftDisplay = leavesLeftDoubleToBeUsedInSettings.toString();
      });
    }
  }

  void decreaseLeaves() async {
    if ((leavesLeftDoubleToBeUsedInSettings - 0.5) >= 0) {
      setState(() {
        leavesLeftDoubleToBeUsedInSettings =
            leavesLeftDoubleToBeUsedInSettings - 0.5;
        leavesLeftDisplay = leavesLeftDoubleToBeUsedInSettings.toString();
      });
    }
  }

  Future<void> updateHomepageBox() async {
    await homepageBox.put('ipptResult', ipptTextController.text);

    await homepageBox.put('leavesLeft', leavesLeftDisplay);

    await homepageBox.put('serviceDuration', serviceDuration);

    await homepageBox.put('enlistmentDate', _enlistmentDateController.text);
    await homepageBox.put('ordDate', _ordDateController.text);
  }
}
