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
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween<Offset>(begin: Offset(0,0), end: Offset(1,0)).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      child: SlideTransition(
        position: _animation,
        child: Container(
        height: widget.size.height,
        width:  widget.size.width,
        color: Colors.pinkAccent.withAlpha(150),
    ),
      ),
      clipper: ArrowTriangle(),
    );
  }
}
