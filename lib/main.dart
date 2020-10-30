import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './web_screens/landing_screen.dart';
import './provider/auth.dart';

FirebaseAnalytics firebaseAnalytics;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  firebaseAnalytics = FirebaseAnalytics();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(
        title: 'Railway Reservation System',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF009688),
          shadowColor: Colors.grey[400],
          accentColor: Color(0xFF4DD0E1),
          fontFamily: 'OpenSans',
        ),
        home: LandingPageScreen(),
      ),
    );
  }
}
