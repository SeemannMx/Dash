import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:text_to_path_maker/text_to_path_maker.dart';

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
        _getStackItemBottomTriangle(),
        _getStackItemtext()
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

  _getStackItemtext(){
    return Center(
      child: GestureDetector(
        onTap: () {
          print("HomeControll onTap Bottom");
          setState(() { onTapBottom = !onTapBottom; });
        },
        child: ClipPath(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border.all(color: Colors.pinkAccent, width: 1)),
              height: widget.size.height / 2,
              width: widget.size.width / 2,
            ),
            clipper: CenterText()),
      ),
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

class CenterText extends CustomClipper<Path> {
  Path p = Path();
  PMFont font;

  @override
  Path getClip(Size size) {

    rootBundle.load("assets/fonts/Prata-Regular.ttf").then(((ByteData data) {

    }));

    return null;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}