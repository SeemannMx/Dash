import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/screens/start/startscreen.dart';
import 'package:flutter_dash/utils/clipper.dart';
import 'package:flutter_dash/utils/color_set.dart';

class PlayAnimation extends StatefulWidget {
  static String route = "/anim";

  @override
  _PlayAnimationState createState() => _PlayAnimationState();
}

class _PlayAnimationState extends State<PlayAnimation> {
  ColorSet _colorSet = ColorSet();

  Color _colorBackground = Colors.blueGrey;
  Color _colorItem = Colors.amber;
  Size _size;
  double _corr;
  double _radius;

  int _runner = 0;
  int _count;
  int _colorIndex = 0;
  Random _random = Random();
  Duration _duration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    //this._count = _random.nextInt(10);
    this._count = 4;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        this._size =
            Size(constraints.biggest.width, constraints.biggest.height);
        this._corr = (_size.width + _size.height) / 2;

        if (_runner++ == 0) this._radius = _corr / 75;

        return Scaffold(
          backgroundColor: _colorBackground,
          body: Stack(
            children: <Widget>[_getGrid(), _getCenterTile()],
          ),
        );
      },
    );
  }

  _getCenterTile() {
    return Center(
      child: AnimatedContainer(
          duration: _duration,
          decoration: BoxDecoration(
              color: Colors.pinkAccent.withAlpha(100),
              border: Border.all(color: Colors.amber, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(_radius),
              )),
          child: Padding(
            padding: EdgeInsets.only(
                top: _corr / 35, left: _corr / 40, right: _corr / 40),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  this._count = this._random.nextInt(10);
                  this._colorIndex = _count % _colorSet.gameColors.length;
                  this._colorItem = _colorSet.gameColors[_colorIndex];
                  this._radius = (_corr * _count) / 100;
                });
              },
              child: Text(
                "$_count : $_colorIndex",
                style: TextStyle(fontSize: _corr / 10, fontFamily: "Elite"),
              ),
            ),
          )),
    );
  }

  _getGrid() {
    if (_count == null || _count <= 0) _count = 4;

    return GridView.count(
      crossAxisCount: _count,
      children: List.generate(_count * _count, (index) {
        return _getGridItem(index);
      }),
    );
  }

  _getGridItem(int index) {
    return AnimatedContainer(
        duration: _duration,
        margin: EdgeInsets.all(_corr / (_count * 50)),
        decoration: BoxDecoration(
            color: _colorItem,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(_corr / 50),
            )),
        child: _getGridText(index));
  }

  _getGridText(int index) {
    return Center(
      child: GestureDetector(
        onDoubleTap: () {
          Navigator.pushNamed(context, Startscreen.route);
        },
        child: Text(
          '$index',
          style: TextStyle(fontSize: _corr / (_count * 4), fontFamily: "Dot"),
        ),
      ),
    );
  }
}
