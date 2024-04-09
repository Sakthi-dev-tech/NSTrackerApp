import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nstrackerapp/pages/ippt.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.only(
            top:
                0), //padding on top of the page between the app bar and the container for the elements
        child: Container(
          //container for the whole page
          alignment: Alignment.bottomRight,
          color: Colors.amber,
          constraints: const BoxConstraints.tightForFinite(),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  //ord progress container
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[200],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.4), // Adjust shadow color and opacity
                          spreadRadius: 5.0, // Adjusts the spread of the shadow
                          blurRadius: 7.0, // Adjusts the blur of the shadow
                          offset: const Offset(0,
                              3), // Adjusts the position of the shadow (x, y)
                        )
                      ]),
                  height: 200, //height of the ord progress level section
                  child: Column(children: [
                    Align(
                      //to align the text to the top left of the container
                      alignment: Alignment.topLeft,
                      //to align the text to the top left of the container
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Progress",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey[1000],
                              fontSize: 20,
                            )),
                      ),
                    ),
                    Align(
                      //clipart of truck on the progress bar
                      alignment: Alignment.center,
                      child: Transform(
                        transform: Matrix4.translationValues(-100, 0, 0),
                        child: const Image(
                          colorBlendMode: BlendMode.dstOut,
                          image: NetworkImage(
                              'https://cdn-icons-png.flaticon.com/512/6142/6142172.png'),
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                    Align(
                      //progressbar
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Stack(
                            children: [
                              LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(5.0),
                                backgroundColor: Colors.orange,
                                color: Colors.black,
                                value: 0.2,
                                minHeight: 20,
                              ),
                              Text("584 days to ORD!",
                                  style: GoogleFonts.montserrat(
                                    color: Colors.cyan,
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "20% Done!",
                            style: GoogleFonts.montserrat(
                              color: Colors.grey[1000],
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              Row(
                //row for holiday and pay day sections
                children: [
                  Padding(
                    //upcoming holiday section
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      color: Colors.deepPurple[200],
                      height: 75,
                      width: 160,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.mosque,
                                      size: 30,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 70),
                                      child: Text(
                                        "2",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Hari Raya Puasa",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    //Days to Pay day
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      color: Colors.deepPurple[200],
                      height: 75,
                      width: 160,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          //column to accomodate the icon, no. of days and the text
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                //row to accomodate the icon and text of number of days to pay day
                                children: [
                                  const Align(
                                    child: Padding(
                                      //icon
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.payments,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    //text to show number of days to Pay Day
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 70),
                                      child: Text(
                                        "8",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Pay Day",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                //row for ippt score and OIL cards
                children: [
                  Padding(
                    //Prev IPPT score
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      color: Colors.deepPurple[200],
                      height: 75,
                      width: 160,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: 5, right: 5, left: 5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                left: 4,
                                right: 4,
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Icon(
                                      Icons.directions_run,
                                      size: 30,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 70, top: 2),
                                      child: Text(
                                        "61 \nPts",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 1),
                                child: Text(
                                  "Prev IPPT",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    //OIL Left
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      color: Colors.deepPurple[200],
                      height: 75,
                      width: 160,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.hotel,
                                      size: 30,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 70),
                                      child: Text(
                                        "5.0",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "OIL Left",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                //row for leave and ____ sections
                children: [
                  Padding(
                    //Leaves left section
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      color: Colors.deepPurple[200],
                      height: 75,
                      width: 160,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.wallet_giftcard_sharp,
                                      size: 30,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 70),
                                      child: Text(
                                        "14.0",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Leaves Left",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        title: const Text("Home"),
        toolbarHeight: 65,
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Colors.grey.shade700,
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: const Column(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                  'https://thumbs.dreamstime.com/z/orange-starburst-military-soldier-12123023.jpg?w=768'),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "My NS Tracker",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomePage(),
              )),
            ),
            ListTile(
              leading: const Icon(Icons.hotel),
              title: const Text("OIL"),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomePage(),
              )),
            ),
            ListTile(
              leading: const Icon(Icons.directions_run),
              title: const Text("IPPT"),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const IPPT(),
              )),
            ),
            ListTile(
              leading: const Icon(Icons.wallet_giftcard_sharp),
              title: const Text("Leave"),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomePage(),
              )),
            ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomePage(),
              )),
            ),
          ],
        ),
      );
}


