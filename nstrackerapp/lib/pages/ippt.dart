import 'package:flutter/material.dart';

class IPPT extends StatefulWidget {
  const IPPT({super.key});

  @override
  State<IPPT> createState() => _IPPTState();
}

class _IPPTState extends State<IPPT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const IpptSettings(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}

class IpptSettings extends StatefulWidget {
  const IpptSettings({super.key});

  @override
  State<IpptSettings> createState() => _IpptSettingsState();
}

class _IpptSettingsState extends State<IpptSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [],
      ),
    );
  }
}