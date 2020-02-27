import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dash/screens/authscreen.dart';
import 'package:flutter_dash/screens/playscreen.dart';
import 'package:flutter_dash/utils/helper.dart';
import 'package:flutter_dash/screens/homescreen.dart';
import 'package:flutter_dash/screens/start_painter.dart';

class Startscreen extends StatefulWidget {
  static String route = "/start";

  @override
  StartscreenState createState() => new StartscreenState();
}

class StartscreenState extends State<Startscreen> {
  Offset _position = Offset(0, 0);
  ValueChanged<Offset> onChanged;
  Helper _helper = Helper();
  Size _size;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _size = Size(constraints.biggest.width, constraints.biggest.height);
        return Container(
          height: constraints.biggest.height,
          width: constraints.biggest.width,
          child: GestureDetector(
            onPanStart: _start,
            onPanEnd: _end,
            onPanUpdate: _update,
            child: CustomPaint(
                size: Size(_position.dx, _position.dy),
                painter: StartPainter(_position.dx, _position.dy)),
          ),
        );
      },
    );
  }

  _onChanged(Offset offset) {
    setState(() {
      this._position = _getPosition(offset);
      if (onChanged != null) onChanged(_position);
    });
  }

  _getPosition(Offset offset) {
    RenderBox referenceBox = context.findRenderObject();
    return referenceBox.globalToLocal(offset);
  }

  _start(DragStartDetails details) {
    //print("start");
    _onChanged(details.globalPosition);

    // create Limit Line
    _helper.calculateLine(_size);

    // is Position left of Line
    if (_helper.isLeft(_position)) {
      //Navigator.pushNamed(context, Homescreen.route);
      Navigator.pushNamed(context, Playscreen.route);
    } else {
      Navigator.pushNamed(context, Authscreen.route);
    }
  }

  _end(DragEndDetails details) {
    // print("end");}
  }

  _update(DragUpdateDetails details) {
    //print("update");
    _onChanged(details.globalPosition);
  }
}
