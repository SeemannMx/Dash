import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeControll extends StatefulWidget {
  HomeControll({@required this.size});

  Size size;

  @override
  _HomeControllState createState() => _HomeControllState();
}

class _HomeControllState extends State<HomeControll> {
  bool onTapTop = false;
  bool onTapBottom = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _getStackItemTopTriangle(),
        _getStackItemBottomTriangle()
      ],
    );
  }

  _getStackItemTopTriangle(){
    return GestureDetector(
      onTap: () {
        print("HomeControll onTap Top");
        setState(() { onTapTop = !onTapTop; });
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
  _getStackItemBottomTriangle(){
    return GestureDetector(
      onTap: () {
        print("HomeControll onTap Bottom");
        setState(() { onTapBottom = !onTapBottom; });
      },
      child: ClipPath(
          child: Container(
            height: widget.size.height,
            width: widget.size.width,
            color: (onTapBottom ? Colors.lightBlueAccent.shade400 : Colors.lightBlueAccent.shade100).withAlpha(100),
          ),
          clipper: BottomTriangle()),
    );
  }

}

class TopTriangle extends CustomClipper<Path> {
  Path p = Path();

  @override
  Path getClip(Size size) {
    return p..lineTo(size.width / 2, size.height)..lineTo(size.width, 0.0)..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BottomTriangle extends CustomClipper<Path> {
  Path p = Path();

  @override
  Path getClip(Size size) {
    return p..moveTo(0.0, size.height)..lineTo(size.width / 2, 0)..lineTo(size.width, size.height)..close();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}