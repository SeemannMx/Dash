import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dash/homescreen.dart';
import 'package:flutter_dash/startscreen.dart';
import 'package:flutter_dash/startscreen.dart';

import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

void main() => runApp(DashApp());

class DashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dash',
      home: DashScreen(),
      routes: {
        Homescreen.route: (context) => Homescreen(
              size: null,
              timeStreamController: null,
            ),
        Startscreen.route: (context) => Startscreen(size: null)
      },
    );
  }
}

class DashScreen extends StatefulWidget {
  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  StreamController _timeStreamController = StreamController();

  @override
  Widget build(BuildContext context) {
    print('build');

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
            body: Startscreen(size: Size(constraints.biggest.width, constraints.biggest.height),

            /**
            body: Startscreen()
                  Homescreen(
                    timeStreamController: _timeStreamController,
                    size: Size(constraints.biggest.width, constraints.biggest.height),
                  ),
            **/

        ));
      },
    );
  }
}
