import 'package:flutter/material.dart';

import './web_screens/landing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Railway Reservation System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF009688),
        shadowColor: Colors.grey[400],
        accentColor: Color(0xFF4DD0E1),
      ),
      home: LandingPageScreen(),
    );
  }
}
