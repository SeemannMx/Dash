import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/utils/clipper.dart';

class PlayAnimation extends StatefulWidget {

  PlayAnimation({@required this.size});

  Size size;

  @override
  _PlayAnimationState createState() => _PlayAnimationState();
}

class _PlayAnimationState extends State<PlayAnimation>  with TickerProviderStateMixin{

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getTriangle();
  }

  _getTriangle(){
    return GestureDetector(
      onTap: () {},
      child: ClipPath(
        child: Container(
          height: widget.size.height,
          width:  widget.size.width,
          color: Colors.lightBlueAccent.withAlpha(120),
        ),
        clipper: ArrowTriangle(),
      ),
    );
  }
}
