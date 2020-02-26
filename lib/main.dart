import 'package:flutter/material.dart';
import 'package:flutter_dash/screens/homescreen.dart';
import 'package:flutter_dash/screens/startscreen.dart';


void main() => runApp(DashApp());

class DashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dash',
      home: DashScreen(),
      routes: {
        Homescreen.route: (context) => Homescreen(),
        Startscreen.route: (context) => Startscreen()
      },
    );
  }
}

class DashScreen extends StatefulWidget {
  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Startscreen(),
      );
    });
  }
}
