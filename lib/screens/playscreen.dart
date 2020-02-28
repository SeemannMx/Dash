import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/screens/dialog.dart';
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
        this._size = Size(constraints.biggest.width, constraints.biggest.height);
        this._corr = (_size.width + _size.height) / 2;
        this._navBarHeight =  _corr / 10;

        return Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Container(
            height: _size.height,
            width: _size.width,
            child: _getStack(_lenght),
          ),
          bottomNavigationBar: Container(
            height:_navBarHeight,
            //color: Colors.white,
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Center(
                        child:
                        Container(
                          width: _size.width / 5,
                          padding: EdgeInsets.only(top: _navBarHeight / 8, bottom:  _navBarHeight / 16),
                          decoration: BoxDecoration(
                              color: Colors.grey.withAlpha(50),
                              borderRadius: BorderRadius.only(
                                  topLeft:  Radius.circular(_corr / 50),
                                  topRight: Radius.circular(_corr / 50)
                              )
                          ),
                            child: Center(
                              child: Text(
                                "Score ${_initLenght} / ${_score}",
                                style: TextStyle(
                                    fontSize: _navBarHeight / 4,
                                    fontFamily: "Elite",
                                    color: Colors.white.withAlpha(150)),
                              ),
                            )
                        )
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.grey.withAlpha(150),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("MY"),
                            Slider(
                              min: 1,
                              max: _maxLevel,
                              value: _level,
                              activeColor: !_started ? Colors.pinkAccent : Colors.grey,
                              inactiveColor: !_started ? Colors.yellowAccent : Colors.black54,
                              onChanged: (newLevel) {
                                if(_started) return;
                                setState(() {
                                  _level = newLevel;
                                  _lenght = Random().nextInt(_level.round());
                                  _initLenght = (_lenght - 1 <= 0 )? 0 : _lenght - 1;
                                });
                              },
                            ),
                            Text("WORLD")
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _getStack(int limit) {
    this._widgets = List<Widget>();
    for (int i = 0; i < limit; i++) {
      this._widgets.add(_getCircle(i));
    }
    return Stack(children: _widgets);
  }

  _getCircle(int value) {

    double limit = _size.width / 25;
    double radius = _random.nextInt(limit.round()).ceilToDouble();
    double xPos = _random.nextInt((_size.width).round()).ceilToDouble();
    double yPos = _random.nextInt((_size.height).round()).ceilToDouble();

    if (radius < limit / 2) radius += limit / (3 / 2);
    if (xPos > _size.width) xPos = _size.width - xPos * value;
    if (yPos > (_size.height - _navBarHeight)) yPos = _size.height - yPos * value;

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
          clipper: CircleClip(offset: Offset(xPos, yPos), radius: radius)),
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
              _widgets.clear();
              _lenght = 0;
              _level = 1;
              _score = 0;
              _initLenght = 0;
              _started = false;
              Navigator.of(dialogContext).pop();
            });
            },
        );
      },
    );
  }
}
