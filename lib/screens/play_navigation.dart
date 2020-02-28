import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBootomNavigationBar extends StatefulWidget {

  CustomBootomNavigationBar(
      {@required this.corr, @required this.result, @required this.sliderConfig, @required this.sliderCallback});

  double corr;
  var sliderCallback;
  var result;
  Map sliderConfig;

  @override
  _CustomBootomNavigationBarState createState() =>
      _CustomBootomNavigationBarState();
}

class _CustomBootomNavigationBarState extends State<CustomBootomNavigationBar> {

  double _navBarHeight;

  @override
  void initState() {
    this._navBarHeight = widget.corr / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: _navBarHeight,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              _getScore(),
              _getControllbar()
            ],
          )
        ],
      ),
    );
  }

  _getScore() {
    return Container(
        width: _navBarHeight * 2,
        padding: EdgeInsets.only(top: _navBarHeight / 7, bottom: _navBarHeight / 16),
        decoration: BoxDecoration(
            color: Colors.grey.withAlpha(50),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.corr / 50),
                topRight: Radius.circular(widget.corr / 50)
            )
        ),
        child: Center(
            child: _getText(
                "Score ${widget.result[0]} / ${widget.result[1]}",
                fontsize: _navBarHeight / 4,
                color: Colors.white.withAlpha(150)
            )
    )
    );
  }

  _getControllbar() {
    return Expanded(
      child: Container(
        color: Colors.grey.withAlpha(150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _getText("back"),
            _getSlider(),
            _getText("next"),
          ],
        ),
      ),
    );
  }

  _getSlider() {
    return Slider(
        min: 1,
        max: widget.sliderConfig["maxLevel"],
        value: widget.sliderConfig["level"],
        activeColor: !(widget.sliderConfig["started"])
            ? Colors.pinkAccent
            : Colors.grey,
        inactiveColor: !(widget.sliderConfig["started"])
            ? Colors.yellowAccent
            : Colors.black54,
        onChanged: widget.sliderCallback
    );
  }

  _getText(String text, { double fontsize, Color color }) {
    return Text(
        text,
        style: TextStyle(
          fontSize: fontsize,
          fontFamily: "Elite",
          color: color,
        ));
  }
}