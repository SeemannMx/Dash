import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

void main() => runApp(DashApp());

class DashApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dash',
      home: DashScreen(title: 'Dashboard'),
    );
  }
}

class DashScreen extends StatefulWidget {
  DashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  StreamController _timeStreamController = StreamController();
  Timer _timer;

  int _timerMax = 10;
  int runner = 0;
  var _value;

  @override
  dispose() {
    if (_timeStreamController != null) _timeStreamController.close();
    if (_timer != null) _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
    );
  }

  _getBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Center(
          child: StreamBuilder<Object>(
              stream: _timeStreamController.stream,
              builder: (context, snapshot) {
                _run();
                return Text(snapshot.data.toString());
              }),
        ),
      );
    });
  }

  _run() {
    if (runner == 0) {
      print('Timer started ...');
      _timer = Timer.periodic(Duration(seconds: 2), (_) {
        _getTime("http://numbersapi.com/random/math?json");
      });
      runner++;
    }
  }

  _getTime(String url) async {
    _cancelTimer();

    await get(url).then((_t) {
      _value = jsonDecode(_t.body);
      _timeStreamController.sink.add(_value['number']);
    });
  }

  _cancelTimer() {
    if (_timer.tick < _timerMax) {
      //print('send ${_timer.tick} request');
    } else {
      _timer.cancel();
      print('Timer stoped at Tick: ${_timer.tick}');
    }
  }
}
