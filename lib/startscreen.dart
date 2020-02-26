import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Startscreen extends StatefulWidget {
  static String route = "/start";

  Startscreen({@required this.size});

  Size size;

  @override
  _StartscreenState createState() => _StartscreenState();
}

class _StartscreenState extends State<Startscreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomPaint(
          size: widget.size,
          painter: StartPainter("top"),
        ),
        CustomPaint(
          size: widget.size,
          painter: StartPainter("bottom"),
        ),
      ],
    );
  }
}

class StartPainter extends CustomPainter {
  StartPainter(@required this.type);

  String type = "default";

  Size _size;
  Path _path = Path();
  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    this._size = size;
    _clear();

    if(type.compareTo("top") == 0){
      _isTop();
    } else {
      _isBottom();
    }
    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }

  _isTop(){
    _paint.color = Colors.black12;
    _path.lineTo(0, _size.height);
    _path.lineTo(_size.width, 0);
    _path.close();
  }

  _isBottom(){
    _paint.color = Colors.blueGrey;
    _path.moveTo(0,_size.height);
    _path.lineTo(_size.width, 0);
    _path.lineTo(_size.width,_size.height);
    _path.close();
  }

  _clear(){
    this._path.reset();
  }
}
