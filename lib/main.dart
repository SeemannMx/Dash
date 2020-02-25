import 'dart:math';

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
  Size _size;

  int _timerMax = 10;
  int runner = 0;
  var _value;

  @override
  Widget build(BuildContext context) {
    print('build');
    return LayoutBuilder(
      builder: (context, constraints) {
        this._size = Size(constraints.biggest.width, constraints.biggest.height);
        return Scaffold(
          body: _getBody(),
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

  _getBody() {
    return StreamBuilder<Object>(
        stream: _timeStreamController.stream,
        builder: (context, snapshot) {
          _run();
          return (snapshot.data != null)
              ? _getListBody(snapshot.data.toString())
              : Text("0");
        });
  }

  _getListBody(String nr) {
    List<String> chars = [];
    for (int i = 0; i < nr.length; i++) chars.add(nr[i]);

    double fontsize = _getFontsize(chars);
    double padding = fontsize * 0.25;

    return Align(
      alignment: Alignment.center,
      child: Container(
        height: fontsize,
        width: (fontsize - padding + (padding * 0.115)) * chars.length,
        color: Colors.indigoAccent,
        child: _getList(chars, fontsize, padding)
      ),
    );
  }

  _getList(List <String> chars, double fontsize, double padding){
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: chars.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: _getColor(index),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Text(
              chars[index],
              style: TextStyle(fontSize: fontsize / 2),
            ),
          );
        });
  }

  _getFontsize(List <String> chars){
    return double.parse(chars[0]) < 8 ? double.parse(chars[0]) * 50 : _size.height / 2;
  }

  _getColor(int index){
    List<Color> colors = [
      Colors.blueAccent,
      Colors.blueAccent[100],
      Colors.blue[200],
      Colors.pinkAccent
    ];



    Random random = Random();
    index = random.nextInt(colors.length);
    int last = index;

    if(index == last && index == colors.length) index - 1;
    if(index == last && index == 0) index + 1;

    return colors[index];
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
