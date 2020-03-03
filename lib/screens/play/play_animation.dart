import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/utils/clipper.dart';
import 'package:flutter_dash/utils/color_set.dart';

class PlayAnimation extends StatefulWidget {
  @override
  _PlayAnimationState createState() => _PlayAnimationState();
}

class _PlayAnimationState extends State<PlayAnimation> {
  ColorSet _colorSet = ColorSet();

  Color _colorBackground = Colors.blueGrey;
  Color _colorItem = Colors.amber;
  Size _size;
  double _corr;

  int _count;
  int _colorIndex = 0;
  Random _random = Random();

  @override
  void initState() {
    super.initState();
    this._count = _random.nextInt(10);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        this._size = Size(constraints.biggest.width, constraints.biggest.height);
        this._corr = (_size.width + _size.height) / 2;

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
        child: Container(
            decoration: BoxDecoration(
                color: Colors.pinkAccent.withAlpha(100),
                borderRadius: BorderRadius.all(
                  Radius.circular(_corr / 75),
                )),
            child: Padding(
              padding: EdgeInsets.only(
                  top: _corr / 35, left: _corr / 40, right: _corr / 40),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    this._count = this._random.nextInt(10);
                    this._colorIndex = _count%_colorSet.gameColors.length;
                    this._colorItem = _colorSet.gameColors[_colorIndex];
                  });
                },
                child: Text(
                  "$_count : $_colorIndex",
                  style: TextStyle(fontSize: _corr / 10, fontFamily: "Elite"),
                ),
              ),
            )));
  }

  _getGrid() {

    if(_count == null || _count <= 0) _count = 4;

    return GridView.count(
      crossAxisCount: _count,
      children: List.generate(_count * _count, (index) {
        return _getGridItem(index);
      }),
    );
  }

  _getGridItem(int index) {
    return Container(
      margin: EdgeInsets.all(_corr / (_count * 50)),
      child: AnimatedContainer(
          duration: Duration(seconds: 3),
          color: _colorItem,
          child: _getGridText(index)),
    );
  }

  _getGridText(int index) {
    return Center(
      child: Text(
        'Item $index',
      ),
    );
  }
}
