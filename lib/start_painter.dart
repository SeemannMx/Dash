import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StartPainter extends CustomPainter {
  final double xPos;
  final double yPos;

  Size _size;

  StartPainter(this.xPos, this.yPos);

  @override
  void paint(Canvas canvas, Size size) {
    this._size = size;

    Path _path = Path();
    Paint _paint = Paint();

    _paint.color = Colors.black12;
    _path.lineTo(0, _size.height);
    _path.lineTo(_size.width, 0);
    _path.close();

    canvas.drawPath(_path, _paint);

    _path = Path();
    _paint = Paint();

    _paint.color = Colors.blueGrey;
    _path.moveTo(0, _size.height);
    _path.lineTo(_size.width, 0);
    _path.lineTo(_size.width, _size.height);
    _path.close();

    canvas.drawPath(_path, _paint);

    final paint = Paint()
      ..color = Colors.pinkAccent
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(xPos, yPos), 5, paint);
  }

  @override
  bool shouldRepaint(StartPainter old) => xPos != old.xPos && yPos != old.yPos;
}
