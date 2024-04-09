import 'package:flutter/material.dart';
import 'package:nstrackerapp/pages/ippt.dart';
import 'pages/homepage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        '/ippt':(context) => const IPPT(),
        '/oil':(context) => const IPPT(),
        '/leaves':(context) => const IPPT(),
        '/settings':(context) => const IPPT()
      }
    );
  }
}
