import 'dart:math';

import 'package:flutter/painting.dart';

class Helper {
  Helper._internal() {}
  static Helper _helper = Helper._internal();

  factory Helper() => _helper;

  Line _limit = Line();

  calculateLine(Size size) => _limit.create(size);

  isLeft(Offset pos) => (pos.dy < _limit.getYPointLine(pos.dx)) ? true : false;
}

class Line {
  Line._internal() {}
  static Line _line = Line._internal();

  factory Line() => _line;

  Point start;
  Point end;
  Offset _s;
  Offset _e;

  create(Size size) {
    this._s = Offset(0, size.height);
    this._e = Offset(size.width, 0);

    start = Point(_s.dx, _s.dy);
    end = Point(_e.dx, _e.dy);
  }

  // y = m * x + b
  // print("f(${x}) = $y");
  getYPointLine(double x) {
    var m = (end.y - start.y) / (end.x - start.x);
    var b = start.y - (m * start.x);
    return (m * x + b);
  }
}