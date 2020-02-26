import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dash/start_painter.dart';

class Startscreen extends StatefulWidget {
  static String route = "/start";

  Size size;

  Startscreen({Key key,@required this.size,}) : super(key: key);

  @override
  StartscreenState createState() => new StartscreenState();
}

class StartscreenState extends State<Startscreen> {

  Offset _position = Offset(0,0);
  ValueChanged<Offset> onChanged;
  Helper _helper = Helper();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      child: GestureDetector(
        onPanStart: _start,
        onPanEnd: _end,
        onPanUpdate: _update,
        child: CustomPaint(
          size: Size(_position.dx, _position.dy),
            painter: StartPainter(_position.dx, _position.dy)
        ),
      ),
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
  }

  _end(DragEndDetails details) {
    //print("end");
    Offset o1 = Offset(0, widget.size.height);
    Offset o2 = Offset(widget.size.width, 0);
    _helper.calculateLine(o1, o2);
    //print(_position);
  }

  _update(DragUpdateDetails details) {
    //print("update");
    _onChanged(details.globalPosition);
  }
}

class Helper{

  Helper._internal() {}
  static Helper _helper = Helper._internal();
  factory Helper() =>  _helper;

  calculateLine(Offset start, Offset end){
    Line limit = Line();
    limit.create(start, end);
  }
}

class Line {

  Line._internal() {}
  static Line _line = Line._internal();
  factory Line() =>  _line;

  Point start;
  Point end;


  create(Offset s, Offset e){
    start = Point(s.dx, s.dy);
    end = Point(e.dx, e.dy);

    _getYPointLine(s);
    _getYPointLine(e);
  }

  // y = m * x + b
  _getYPointLine(Offset position){
    var m = (end.y - start.y) / (end.x - start.x);
    var b = start.y - (m * start.x);

    var y = m * position.dx + b;

    print("f(${position.dx}) = $y");
    return y;
  }


}
