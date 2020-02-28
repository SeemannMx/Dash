import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dash/utils/color_set.dart';
import 'package:http/http.dart';

class Provider {
  Provider._internal() {}
  static Provider _provider = Provider._internal();

  ColorSet _set = ColorSet();
  Random _random = Random();
  Timer _timer;

  var _runner = 0;
  int _minutes = 0;
  int _hours = 0;

  factory Provider({var p}) => _provider;

  startTimer(StreamController ctr){
    if (_runner == 0) {
      print('Timer started ...');
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        ctr.sink.add(timer.tick);
      });
      _runner++;
    }
  }

  stopTimer() {
    _minutes = 0;
    _hours = 0;
    if (_timer != null) _timer.cancel();
  }

  getDisplayTime(int tick){
    _minutes = tick;
    if(_minutes == 60) {
      _hours++;
      _minutes = 0;
    }
    return {"hour": _hours.toString(), "minutes": _minutes.toString()};
  }

  getColor(int index) {
    index = _random.nextInt(_set.tileColors.length);
    int last = index;

    if (index == last && index == _set.tileColors.length) index - 1;
    if (index == last && index == 0) index + 1;

    return _set.tileColors[index];
  }
}
