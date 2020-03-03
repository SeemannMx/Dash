import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPainter extends CustomPainter {
  Size _size;
  double xPos;
  double yPos;
  double _corr;
  double _fontsize;

  Path _path = Path();
  Paint _paint = Paint();

  TextPainter _textPainter;
  Offset _textOffset;

  StartPainter(this.xPos, this.yPos);

  @override
  bool shouldRepaint(StartPainter old) => xPos != old.xPos && yPos != old.yPos;

  @override
  void paint(Canvas canvas, Size size) {
    // init
    this._size = size;
    this._corr = (_size.height + _size.width) / 2;
    this._fontsize = _corr / 10;

    // draw
    _drawTriangles(canvas);
    _drawPoint(canvas);
    _drawText(canvas);
  }

  _drawTriangles(Canvas canvas) {
    // Triangle
    _paint.color = Colors.blueGrey.shade600;
    _path
      ..lineTo(0, _size.height)
      ..lineTo(_size.width, 0)
      ..close();
    canvas.drawPath(_path, _paint);

    _clear();

    // Triangle
    _paint.color = Colors.blueGrey;
    _path.moveTo(0, _size.height);
    _path
      ..lineTo(_size.width, 0)
      ..lineTo(_size.width, _size.height)
      ..close();
    canvas.drawPath(_path, _paint);
  }

  _drawPoint(Canvas canvas) {
    // Point
    _paint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(xPos, yPos), 5, _paint);
  }

  _drawText(Canvas canvas) {
    // Text
    _textPainter = _getTextPainter("Open Source", "Cabin");
    _textOffset = Offset(_size.width / 2 - _fontsize * 5, _size.height / 4.5);
    _textPainter.paint(canvas, _textOffset);

    // Text
    _textOffset = Offset(_size.width / 2, _size.height / 1.5);
    _textPainter = _getTextPainter("Enterprise","Elite");
    _textPainter.paint(canvas, _textOffset);
  }

  _getTextPainter(String text, String fontFamily) {
    TextStyle style = TextStyle(color: Colors.pinkAccent, fontSize: _fontsize, fontFamily: fontFamily);

    TextSpan span = TextSpan(text: text, style: style);

    TextPainter painter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );

    painter.layout(minWidth: 0, maxWidth: _size.width);

    return painter;
  }

  _clear() {
    _path = Path();
    _paint = Paint();
  }
}
