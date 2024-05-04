import 'package:flutter/material.dart';
import 'package:nstracker/backend/functionsVariables.dart';
import 'package:nstracker/backend/homepage_provider.dart';
import 'package:nstracker/pages/settings.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.black87,
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        color: const Color.fromARGB(255, 3, 63, 5).withOpacity(0.5), // Red shadow
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

  @override
  Widget build(BuildContext context) {
    double tonnerMove =
        MediaQuery.of(context).size.width * 0.9 * 0.8 * context.watch<HomepageProvider>().progressValue - 10;
    return Scaffold(
      backgroundColor: const Color.fromARGB(153, 11, 46, 1),
      appBar: AppBar(
        //top app bar
        backgroundColor: const Color.fromARGB(255, 1, 46, 25),
        title: const Text(
          "My NS Journey",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            //Settings button
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(parent:BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal)),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            width: double.maxFinite,
            child: Column(
              children: <Widget>[
                Padding(
                  //Progress Bar Section
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                      maxHeight: 175,
                    ),
                    width: double.maxFinite,
                    decoration: containerDecoration,
                    child: Center(
                      child: Container(
                        //container that will contain the progress bar and all so that we can center it within the parent container
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                        ),
                        height: 100,
                        width: double.maxFinite,
                        child: Center(
                          child: Column(
                            //to fit all the progress bar, icon and texts in this segment
                            children: [
                              Transform.translate(
                                //entire thing for the tonner image
                                offset: Offset(tonnerMove, 0),
                                child: Transform.flip(
                                  flipX: true,
                                  child: const Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Image(
                                      image:
                                          AssetImage('assets/images/tonner.png'),
                                      width: 40,
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  LinearProgressIndicator(
                                    minHeight: 12,
                                    color: Colors.green[600],
                                    backgroundColor:
                                        const Color.fromARGB(103, 131, 153, 5),
                                    value: context.watch<HomepageProvider>().progressValue,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  Positioned(
                                    right: 10,
                                    child: Text(
                                      context.watch<HomepageProvider>().displayProgressCompleted,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    context.watch<HomepageProvider>().displayDaysToORD,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  //the row that contains holiday and days to pay day
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                          minHeight: heightForSmallWidgets),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InformationWidgets(
                            widgetTitle: upcomingHolidayName,
                            iconPath: iconPath,
                            data: numberOfDaysToUpcomingHoliday.toString(),
                          ),
                          InformationWidgets(
                            widgetTitle: 'Pay Day',
                            iconPath: 'assets/icons/payday.png',
                            data: context.watch<HomepageProvider>().daysToPayDay,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  // for prev ippt score and leaves left
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                          minHeight: heightForSmallWidgets),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InformationWidgets(
                            widgetTitle: 'Prev IPPT',
                            iconPath: 'assets/icons/running.png',
                            data: context.watch<HomepageProvider>().ipptDisplay,
                          ),
                          InformationWidgets(
                            widgetTitle: 'Leaves Left',
                            iconPath: 'assets/icons/sunbed.png',
                            data: context.watch<HomepageProvider>().leavesLeftNotifier,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


