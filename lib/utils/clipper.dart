import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class TopTriangle extends CustomClipper<Path> {
  Path _p = Path();

  @override
  Path getClip(Size size) {
    return _p
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0.0)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BottomTriangle extends CustomClipper<Path> {
  Path _p = Path();

  @override
  Path getClip(Size size) {
    return _p
      ..moveTo(0.0, size.height)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CenterText extends CustomClipper<Path> {
  Path _p = Path();
  List<Offset> _points = [];

  @override
  Path getClip(Size size) {
    _points
      ..add(Offset(size.width / 2, 0))
      ..add(Offset(size.width, size.height / 2))
      ..add(Offset(size.width / 2, size.height))
      ..add(Offset(0, size.height / 2));

    _p.addPolygon(_points, true);
    return _p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CircleClip extends CustomClipper<Rect> {

  CircleClip({@required this.offset,@required this.radius });

  Offset offset;
  double radius;

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: offset, radius: radius);

    return  Rect.fromLTRB(offset.dx, offset.dy, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> old) => true;
}
