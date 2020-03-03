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
  String time;

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
    _minutes = tick ?? 0;
    _minutes %= 60;

    if(_minutes % 60 == 0 && tick != null) _hours++;
    if(_hours == 24) _hours = 0;

    return {"hour": _hours, "minutes": _minutes};
  }

  formatTime(Map time){
    Map timeMap =  {"hour": "00", "minutes" : "00"};

    if(time['minutes'] == null) timeMap['minutes'] = "00";

    if(time['minutes'] < 10) {
      timeMap['minutes'] = "0${time['minutes']}";
    } else {
      timeMap['minutes'] = "${time['minutes']}";
    }
    if(time['hour'] < 10) {
      timeMap['hour'] = "0${time['hour']}";
    } else {
      timeMap['hour'] = "${time['hour']}";
    }
    return timeMap;
  }

  getColor(int index) {
    index = _random.nextInt(_set.tileColors.length);
    int last = index;

    if (index == last && index == _set.tileColors.length) index - 1;
    if (index == last && index == 0) index + 1;

    return _set.tileColors[index];
  }
}
