import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/screens/startscreen.dart';
import 'package:flutter_dash/utils/provider.dart';

class Homescreen extends StatefulWidget {
  static String route = "/home";

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  StreamController _timeStreamController = StreamController();

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
  Size _size;
  Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      this._size = Size(constraints.biggest.width, constraints.biggest.height);
      return Scaffold(backgroundColor: Colors.black54, body: _getBody());
    });
  }

  @override
  dispose() {
    _provider.clear();
    super.dispose();
  }

  _getBody() {
    _provider.chatbot();

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Startscreen.route),
      child: Container(
        child: StreamBuilder<Object>(
            stream: _timeStreamController.stream,
            builder: (context, snapshot) {
              _chars.clear();
              _provider.run(_timeStreamController, 10, 2);

              return (snapshot.data != null)
                  ? _getContent(_getListBody(snapshot.data.toString()))
                  : _getContent(_getProgress());
            }),
      ),
    );
  }

  _getContent(Widget content) {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      child: content,
    );
  }

  _getListBody(String nr) {
    for (int i = 0; i < nr.length; i++) _chars.add(nr[i]);

    _fontsize = _getFontsize();
    _padding = _fontsize * 0.25;

    return Align(
      alignment: Alignment.center,
      child: Container(
          height: _fontsize,
          width: (_fontsize - _padding + (_padding * 0.2)) * _chars.length,
          //color: Colors.black54,
          child: _getList()),
    );
  }

  _getProgress() {
    return Center(child: CircularProgressIndicator());
  }

  _getList() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _chars.length,
        itemBuilder: (BuildContext context, int index) {
          return _getListItem(index);
        });
  }

  _getListItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: _getColor(index),
          borderRadius: BorderRadius.all(Radius.circular(_padding / 2)),
          border: Border.all(color: Colors.pinkAccent, width: 1)),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: _padding),
      child: Text(
        _chars[index],
        style: TextStyle(fontSize: _fontsize / 2),
      ),
    );
  }

  _getFontsize() {
    return double.parse(_chars[0]) < 8
        ? double.parse(_chars[0]) * 50
        : this._size.height / 2;
  }

  _getColor(int index) {
    index = _random.nextInt(_colors.length);
    int last = index;

    if (index == last && index == _colors.length) index - 1;
    if (index == last && index == 0) index + 1;

    return _colors[index];
  }
}
