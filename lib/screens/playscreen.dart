import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/screens/startscreen.dart';
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

  List<Color> _colors = [
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

  List<Widget> _widgets = List<Widget>();
  int _lenght = Random().nextInt(100);

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
              child: _getStack(_lenght),
            ));
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
    Random random = Random();

    double limit = _size.width / 25;
    double radius = random.nextInt(limit.round()).ceilToDouble();
    double xPos = random.nextInt((_size.width).round()).ceilToDouble();
    double yPos = random.nextInt((_size.height).round()).ceilToDouble();
    ;

    if (radius < limit / 2) radius += limit / (3 / 2);
    if (xPos > _size.width) xPos = _size.width - xPos * value;
    if (yPos > _size.height) yPos = _size.height - yPos * value;

    return GestureDetector(
      onTap: () {
        setState(() {
          this._widgets.removeAt(value);
          this._lenght--;
        });
        if (_lenght == 1) _getDialog();
      },
      onDoubleTap: () {
        Navigator.pushNamed(context, Startscreen.route);
      },
      child: ClipOval(
          child: Container(
            height: _size.height,
            width: _size.width,
            color: (_colors[value % _colors.length])
                .withAlpha((value * 100) % 255),
          ),
          clipper: CircleClip(offset: Offset(xPos, yPos), radius: radius)),
    );
  }

  _getDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Center(
                  child: Text('Winner', style: TextStyle(fontFamily: "Elite"))),
              Divider()
            ],
          ),
          content: Text('Your score is ...'),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.check),
                color: _colors[Random().nextInt(_colors.length)],
                onPressed: () {
                  setState(() {
                    _widgets.add(_getCircle(0));
                    _lenght++;
                    Navigator.of(dialogContext).pop();
                  });
                }),
          ],
        );
      },
    );
  }
}
