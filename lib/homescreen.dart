import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/provider.dart';

class Homescreen extends StatefulWidget {
  Homescreen({@required this.timeStreamController, @required this.size});

  static String route = "/home";

  StreamController timeStreamController;
  Size size;

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  Provider _provider = Provider();
  Random _random = Random();
  List<String> _chars = [];
  List<Color> _colors = [
    Colors.blueAccent,
    Colors.blueAccent[100],
    Colors.blue[200],
    Colors.pinkAccent
  ];
  double _fontsize, _padding;

  @override
  Widget build(BuildContext context) => _getHomescreen();

  @override
  dispose() {
    _provider.clear();
    super.dispose();
  }

  _getHomescreen() => Scaffold(
        body: _getBody(),
      );

  _getBody() {
    _provider.chatbot();

    return StreamBuilder<Object>(
        stream: widget.timeStreamController.stream,
        builder: (context, snapshot) {
          _chars.clear();
          _provider.run(widget.timeStreamController, 10, 2);

          return (snapshot.data != null)
              ? _getListBody(snapshot.data.toString())
              : Text("0");
        });
  }

  _getListBody(String nr) {
    for (int i = 0; i < nr.length; i++) _chars.add(nr[i]);

    _fontsize = _getFontsize();
    _padding = _fontsize * 0.25;

    return Align(
      alignment: Alignment.center,
      child: Container(
          height: _fontsize,
          width: (_fontsize - _padding + (_padding * 0.115)) * _chars.length,
          color: Colors.indigoAccent,
          child: _getList()),
    );
  }

  _getList() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _chars.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: _getColor(index),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: _padding),
            child: Text(
              _chars[index],
              style: TextStyle(fontSize: _fontsize / 2),
            ),
          );
        });
  }

  _getFontsize() {
    return double.parse(_chars[0]) < 8
        ? double.parse(_chars[0]) * 50
        : widget.size.height / 2;
  }

  _getColor(int index) {
    index = _random.nextInt(_colors.length);
    int last = index;

    if (index == last && index == _colors.length) index - 1;
    if (index == last && index == 0) index + 1;

    return _colors[index];
  }
}
