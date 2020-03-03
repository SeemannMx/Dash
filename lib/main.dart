import 'package:flutter/material.dart';
import 'package:flutter_dash/screens/auth/authscreen.dart';
import 'package:flutter_dash/screens/home/homescreen.dart';
import 'package:flutter_dash/screens/play/play_animation.dart';
import 'package:flutter_dash/screens/play/playscreen.dart';
import 'package:flutter_dash/screens/start/startscreen.dart';


void main() => runApp(DashApp());

class DashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dash',
      home: DashScreen(),
      routes: {
        Homescreen.route: (context) => Homescreen(),
        Startscreen.route: (context) => Startscreen(),
        Authscreen.route: (context) => Authscreen(),
        Playscreen.route: (context) => Playscreen(),
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
        //body: Startscreen(),
        body: PlayAnimation(),
      );
    });
  }
}
