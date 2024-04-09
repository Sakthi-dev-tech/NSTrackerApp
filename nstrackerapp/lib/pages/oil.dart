import 'package:flutter/material.dart';

class OIL extends StatefulWidget {
  const OIL({super.key});

  @override
  State<OIL> createState() => _OILState();
}

class _OILState extends State<OIL> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const oil(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}


class oil extends StatefulWidget {
  const oil({super.key});

  @override
  State<oil> createState() => _oilState();
}

class _oilState extends State<oil> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}