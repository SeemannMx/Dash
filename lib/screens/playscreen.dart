import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/utils/authenticator.dart';
import 'package:flutter_dash/utils/clipper.dart';

class Playscreen extends StatefulWidget {
  static String route = "/play";

  @override
  _PlayscreenState createState() => _PlayscreenState();
}

class _PlayscreenState extends State<Playscreen> {
  Size _size;
  double _corr;

  List <Color> _colors = [
    Colors.grey,
    Colors.blue,
    Colors.blueGrey,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.greenAccent,
    Colors.teal,
    Colors.tealAccent,
    Colors.pinkAccent,
    Colors.white.withAlpha(50),
    Colors.pink,
    Colors.purple.withAlpha(50),
    Colors.deepPurpleAccent
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _size = Size(constraints.biggest.width, constraints.biggest.height);
        _corr = (_size.width + _size.height) / 2;
        return Scaffold(
            backgroundColor: Colors.blueGrey,
            body: Container(
              height: _size.height,
              width: _size.width,
              child: _getStack(100),
            ));
      },
    );
  }

  _getCircle(int value) {

    double limit = _size.width / 25;
    double radius =  Random().nextInt(limit.round()).ceilToDouble();
    double xPos = Random().nextInt((_size.width).round()).ceilToDouble();
    double yPos = Random().nextInt((_size.height).round()).ceilToDouble();;

    if(radius < limit / 2) radius += limit / (3/2);
    if(xPos > _size.width) xPos = _size.width - xPos * value;
    if(yPos > _size.height) yPos = _size.height - yPos * value;

    return ClipOval(
        child: Container(
            height: _size.height,
            width: _size.width,
            color: (_colors[value%_colors.length]).withAlpha((value*100)%255),
        ),
        clipper:
            CircleClip(
                offset: Offset(xPos , yPos),
                radius: radius
            )
    );
  }

  _getStack(int limit){
    List <Widget> widgets = List <Widget>();
    for(int i = 0; i < limit; i++){
      widgets.add(_getCircle(i));
    }
    return Stack(children: widgets);
  }
}
