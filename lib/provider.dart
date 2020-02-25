import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dash/homescreen.dart';

import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class Provider {
  Provider._internal() {}
  static Provider _provider = Provider._internal();

  // Objects
  Timer _timer;

  // Parameter
  var _parameter;
  var _value;
  int _runner = 0;

  // URL
  String url_Numbers = "http://numbersapi.com/random/math?json";

  factory Provider({var p}) {
    return _provider;
  }

  run(StreamController ctr, limit, intervall) {
    if (_runner == 0) {
      print('Timer started ...');
      _timer = Timer.periodic(Duration(seconds: intervall), (_) {
        _getTime(ctr, url_Numbers, limit);
      });
      _runner++;
    }
  }

  _getTime(StreamController ctr, String url, int limit) async {
    _cancelTimer(limit);

    await get(url).then((_t) {
      _value = jsonDecode(_t.body);
      ctr.sink.add(_value['number']);
    });
  }

  _cancelTimer(int limit) {
    if (_timer.tick > limit) {
      _timer.cancel();
      print('Timer stoped at Tick: ${_timer.tick}');
    }
  }
}
