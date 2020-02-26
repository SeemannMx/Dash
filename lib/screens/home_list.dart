import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/screens/startscreen.dart';
import 'package:flutter_dash/utils/provider.dart';

class HomeList extends StatefulWidget {
  Size size;

  HomeList({@required this.size});

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  StreamController _timeStreamController = StreamController();
  Provider _provider = Provider();

  double _fontsize, _padding;
  List<String> _chars = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _provider.clear();
        Navigator.pushNamed(context, Startscreen.route);
      },
      child: StreamBuilder<Object>(
          stream: _timeStreamController.stream,
          builder: (context, snapshot) {
            _chars.clear();
            _provider.run(_timeStreamController, 10, 2);

            return (snapshot.data != null)
                ? _getContent(_getListBody(snapshot.data.toString()))
                : _getContent(_getProgress());
          }),
    );
  }

  @override
  dispose() {
    _provider.clear();
    super.dispose();
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
          child: _getList()),
    );
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
          color: _provider.getColor(index),
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

  _getProgress() {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.pink,
    ));
  }

  _getFontsize() {
    return double.parse(_chars[0]) < 8
        ? double.parse(_chars[0]) * 50
        : widget.size.height / 2;
  }
}
