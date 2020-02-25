import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dash/homescreen.dart';

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
            )
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
  Timer _timer;
  Size _size;

  int _timerMax = 10;
  int runner = 0;
  var _value;

  @override
  Widget build(BuildContext context) {
    print('build');

    return LayoutBuilder(
      builder: (context, constraints) {
        this._size =
            Size(constraints.biggest.width, constraints.biggest.height);
        return Scaffold(
          body: Homescreen(
            timeStreamController: _timeStreamController,
            size: _size,
          ),
        );
      },
    );
  }

  @override
  dispose() {
    if (_timeStreamController != null) _timeStreamController.close();
    if (_timer != null) _timer.cancel();
    super.dispose();
  }
}
