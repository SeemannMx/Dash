import 'package:flutter/material.dart';

class ColorSet {
  ColorSet._internal() {}
  static ColorSet _colorSet = ColorSet._internal();

  factory ColorSet() => _colorSet;

  List<Color> get tileColors => _tileColors;

  List<Color> get gameColors => _gameColors;

  List<Color> _tileColors = [
    Colors.blueAccent,
    Colors.blueAccent[100],
    Colors.blue[200],
    Colors.pinkAccent
  ];

  List<Color> _gameColors = [
    Colors.grey,
    Colors.blue,
    Colors.blueGrey.withAlpha(50),
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.teal,
    Colors.tealAccent,
    Colors.pinkAccent,
    Colors.white.withAlpha(50),
    Colors.pink.withAlpha(100),
    Colors.purple.withAlpha(50),
    Colors.deepPurpleAccent
  ];
}
