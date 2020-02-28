import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/screens/dialog.dart';
import 'package:flutter_dash/screens/play_navigation.dart';
import 'package:flutter_dash/screens/startscreen.dart';
import 'package:flutter_dash/utils/clipper.dart';
import 'package:flutter_dash/utils/color_set.dart';
import 'package:flutter_dash/utils/provider.dart';

class Playscreen extends StatefulWidget {
  static String route = "/play";

  @override
  _PlayscreenState createState() => _PlayscreenState();
}

class _PlayscreenState extends State<Playscreen> {
  Provider _provider = Provider();
  ColorSet _set = ColorSet();
  Random _random = Random();

  Size _size;
  double _corr;
  double _navBarHeight;
  List<Widget> _widgets = List<Widget>();
  Map _circleConfig;

  double _maxLevel;
  int _initLenght;
  double _level;
  int _lenght;
  int _score;

  bool _started = false;

  @override
  void initState() {
    this._score = 0;
    this._level = 100;
    this._maxLevel = _level;
    this._lenght = Random().nextInt(_level.round());
    this._initLenght = _lenght;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        this._size =
            Size(constraints.biggest.width, constraints.biggest.height);
        this._corr = (_size.width + _size.height) / 2;
        this._navBarHeight = _corr / 10;

        return Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Container(
            height: _size.height,
            width: _size.width,
            child: _getStack(_lenght),
          ),
        );
      },
    );
  }

  _getStack(int limit) {
    this._widgets = List<Widget>();

    _createBodyWidgets(limit);
    _createBottomNavigationBar();

    return Stack(children: _widgets);
  }

  _createBodyWidgets(int limit) {
    for (int i = 0; i < limit; i++) {
      this._widgets.add(_getCircle(i));
    }
  }

  _createBottomNavigationBar() {
    this._widgets.add(Align(
          alignment: Alignment.bottomCenter,
          child: _getBottomNavigationBar(),
        ));
  }

  _getBottomNavigationBar() {
    return CustomBootomNavigationBar(
      corr: _corr,
      result: [_initLenght, _score],
      sliderConfig: {
        "maxLevel": _maxLevel,
        "level": _level,
        "started": _started
      },
      sliderCallback: (newLevel) {
        if (_started) return;
        setState(() {
          _level = newLevel;
          _lenght = Random().nextInt(_level.round());
          _initLenght = (_lenght - 1 <= 0) ? 0 : _lenght - 1;
        });
      },
    );
  }

  _getCircle(int value) {
    this._circleConfig = _getCircleConfig(value);
    return GestureDetector(
      onTap: () {
        setState(() {
          this._widgets.removeAt(value);
          this._lenght--;
          this._score++;
          this._started = true;
        });
        if (_lenght == 1) _getDialog();
      },
      onDoubleTap: () {
        this._started = false;
        Navigator.pushNamed(context, Startscreen.route);
      },
      child: ClipOval(
          child: Container(
            height: _size.height,
            width: _size.width,
            color: (_set.gameColors[value % _set.gameColors.length])
                .withAlpha((value * 100) % 255),
          ),
          clipper: CircleClip(
              offset: _circleConfig["offset"],
              radius: _circleConfig["radius"])),
    );
  }

  _getDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return CustomDialog(
          corr: _corr,
          result: [_initLenght, _score],
          callback: () {
            setState(() {
              _reset();
              Navigator.of(dialogContext).pop();
            });
          },
        );
      },
    );
  }

  _getCircleConfig(value) {
    double limit = _size.width / 25;
    double radius = _random.nextInt(limit.round()).ceilToDouble();
    double xPos = _random.nextInt((_size.width).round()).ceilToDouble();
    double yPos = _random.nextInt((_size.height).round()).ceilToDouble();

    if (radius < limit / 2) radius += limit / (3 / 2);
    if (xPos > _size.width) xPos = _size.width - xPos * value;
    if (yPos > (_size.height - _navBarHeight))
      yPos = _size.height - yPos * value;
    return {"offset": Offset(xPos, yPos), "radius": radius};
  }

  _reset() {
    _widgets.clear();
    _lenght = 0;
    _level = 1;
    _score = 0;
    _initLenght = 0;
    _started = false;
  }
}
