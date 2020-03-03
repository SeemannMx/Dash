import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/screens/start/startscreen.dart';
import 'package:flutter_dash/utils/authenticator.dart';
import 'package:flutter_dash/utils/clipper.dart';

class HomeControll extends StatefulWidget {
  HomeControll({@required this.size});

  Size size;

  @override
  _HomeControllState createState() => _HomeControllState();
}

class _HomeControllState extends State<HomeControll> {
  bool onTapTop = false;
  bool onTapBottom = false;
  bool onTapText = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _getStackItemTopTriangle(),
        _getStackItemBottomTriangle(),
        _getStackItemText(),
      ],
    );
  }

  _getStackItemTopTriangle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          onTapTop = !onTapTop;
        });
      },
      child: ClipPath(
          child: Container(
            height: widget.size.height,
            width: widget.size.width,
            color: (onTapTop ? Colors.white : Colors.grey).withAlpha(100),
          ),
          clipper: TopTriangle()),
    );
  }

  _getStackItemBottomTriangle() {
    return GestureDetector(
      onTap: () {
        setState(() {
          onTapBottom = !onTapBottom;
        });
      },
      child: ClipPath(
          child: Container(
            height: widget.size.height,
            width: widget.size.width,
            color: (onTapBottom
                    ? Colors.lightBlueAccent.shade400
                    : Colors.lightBlueAccent.shade100)
                .withAlpha(100),
          ),
          clipper: BottomTriangle()),
    );
  }

  _getStackItemText() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            onTapText = !onTapText;
          });
        },
        onDoubleTap: () {
          Navigator.pushNamed(context, Startscreen.route);
        },
        child: ClipPath(
            child: Container(
              color: (onTapText ? Colors.pinkAccent.shade400 : Colors.white),
              height: widget.size.height / 2,
              width: widget.size.height / 2,
            ),
            clipper: CenterText()),
      ),
    );
  }
}
