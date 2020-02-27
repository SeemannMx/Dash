import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/screens/home_controll.dart';
import 'package:flutter_dash/screens/home_list.dart';

class Homescreen extends StatefulWidget {
  static String route = "/home";

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Size _size;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      this._size = Size(constraints.biggest.width, constraints.biggest.height);
      return Scaffold(backgroundColor: Colors.black54, body: _getBody());
    });
  }

  _getDotText(String text, int limit) {
    String result = "";
    for (int i = 0; i < limit; i++) {
      result += text;
    }
    return result;
  }

  _getBody() {
    return Stack(
      children: <Widget>[
        _getStackItemText(),
        _getStackItemHomeControll(),
        //_getStackItemList(),
      ],
    );
  }

  _getStackItemText() {
    return Text(_getDotText("010110011", 5000),
        style: TextStyle(fontFamily: "Dot", color: Colors.white.withAlpha(50)));
  }

  _getStackItemList() {
    return HomeList(
      size: _size,
    );
  }

  _getStackItemHomeControll(){
    return HomeControll(size: _size);
  }
}

