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

    print(_position);
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
  }

  _update(DragUpdateDetails details) {
    //print("update");
    _onChanged(details.globalPosition);
  }
}
