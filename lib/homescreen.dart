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

  @override
  Widget build(BuildContext context) => _getHomescreen();

  _getHomescreen() => Scaffold(
        body: _getBody(),
      );

  _getBody() {
    return StreamBuilder<Object>(
        stream: widget.timeStreamController.stream,
        builder: (context, snapshot) {
          _provider.run(widget.timeStreamController, 10, 2);

          return (snapshot.data != null)
              ? _getListBody(snapshot.data.toString())
              : Text("0");
        });
  }

  _getListBody(String nr) {
    List<String> chars = [];
    for (int i = 0; i < nr.length; i++) chars.add(nr[i]);

    double fontsize = _getFontsize(chars);
    double padding = fontsize * 0.25;

    return Align(
      alignment: Alignment.center,
      child: Container(
          height: fontsize,
          width: (fontsize - padding + (padding * 0.115)) * chars.length,
          color: Colors.indigoAccent,
          child: _getList(chars, fontsize, padding)),
    );
  }

  _getList(List<String> chars, double fontsize, double padding) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: chars.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: _getColor(index),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Text(
              chars[index],
              style: TextStyle(fontSize: fontsize / 2),
            ),
          );
        });
  }

  _getFontsize(List<String> chars) {
    return double.parse(chars[0]) < 8
        ? double.parse(chars[0]) * 50
        : widget.size.height / 2;
  }

  _getColor(int index) {
    List<Color> colors = [
      Colors.blueAccent,
      Colors.blueAccent[100],
      Colors.blue[200],
      Colors.pinkAccent
    ];

    Random random = Random();
    index = random.nextInt(colors.length);
    int last = index;

    if (index == last && index == colors.length) index - 1;
    if (index == last && index == 0) index + 1;

    return colors[index];
  }
}
