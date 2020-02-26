import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dash/start_painter.dart';

class Startscreen extends StatefulWidget {

  static String route = "/start";

  final double xPos;
  final double yPos;
  final ValueChanged<Offset> onChanged;

  const Startscreen({Key key,
    this.onChanged,
    this.xPos:0.0,
    this.yPos:0.0}) : super(key: key);

  @override
  StartscreenState createState() => new StartscreenState();
}

/**
 * Draws a circle at supplied position.
 *
 */
class StartscreenState extends State<Startscreen> {
  double xPos = 0.0;
  double yPos = 0.0;

  GlobalKey _painterKey = new GlobalKey();

  void onChanged(Offset offset) {
    final RenderBox referenceBox = context.findRenderObject();
    Offset position = referenceBox.globalToLocal(offset);
    if (widget.onChanged != null)
      widget.onChanged(position);

    setState(() {
      xPos = position.dx;
      yPos = position.dy;
    });
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    if (event is PointerDownEvent ) {
      // ??
    }
  }

  void _handlePanStart(DragStartDetails details) {
    onChanged(details.globalPosition);
  }

  void _handlePanEnd(DragEndDetails details) {
    print('end');
    // TODO
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    onChanged(details.globalPosition);
  }

  @override
  Widget build(BuildContext context) {
    return new ConstrainedBox(
      constraints: new BoxConstraints.expand(),
      child: new GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart:_handlePanStart,
        onPanEnd: _handlePanEnd,
        onPanUpdate: _handlePanUpdate,
        child: new CustomPaint(
          size: new Size(xPos, yPos),
          painter: StartPainter(xPos, yPos)
        ),
      ),
    );
  }
}