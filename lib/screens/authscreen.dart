import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dash/screens/homescreen.dart';
import 'package:flutter_dash/screens/playscreen.dart';
import 'package:flutter_dash/utils/authenticator.dart';

class Authscreen extends StatefulWidget {
  static String route = "/auth";

  @override
  _AuthscreenState createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  Authenticator _auth = Authenticator();

  Size _size;
  double _corr;
  String _userName = "";
  double _space = 0.025;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _size = Size(constraints.biggest.width, constraints.biggest.height);
        _corr = (_size.width + _size.height) / 2;
        return Scaffold(
          backgroundColor: Colors.grey.shade800,
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                  horizontal: _corr / 4, vertical: _corr / 10),
              children: <Widget>[
                _getImage("logo", "assets/img/logo.png"),
                SizedBox(height: _size.height * _space),
                Center(child: _getText(_userName, "Lato", color: Colors.grey),),
                SizedBox(height: _size.height * _space),
                _getTextFormField("Email"),
                SizedBox(height: _size.height * 0.025),
                _getTextFormField("Passord"),
                SizedBox(height: _size.height * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _getRaisedButton('back', _back),
                    SizedBox(width: _size.width * 0.025),
                    _getRaisedButton('login', _login),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // fontSize: _corr / 60
  _getTextFormField(String type) {
    return TextFormField(
      style: TextStyle(color: Colors.grey.shade800, fontFamily: "Lato"),
      textAlign: TextAlign.center,
      keyboardType:
          (type == "Email") ? TextInputType.emailAddress : TextInputType.text,
      initialValue: (type == "Email") ? "hello@dash.test" : "test1234",
      obscureText: (type == "Email") ? false : true,
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: type,
        contentPadding: EdgeInsets.all(_corr / 200),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }

  _getImage(String tag, String path) {
    return Hero(
      tag: tag,
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: _corr / 10,
          child: Image.asset(path)),
    );
  }

  _getRaisedButton(String label, VoidCallback callback) {
    return Expanded(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: _corr / 60),
          child: RaisedButton(
              hoverColor: (label == "login")
                  ? Colors.greenAccent.withAlpha(150)
                  : Colors.pinkAccent.withAlpha(150),
              splashColor: Colors.purple,
              highlightElevation: _corr,
              elevation: _corr / 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_corr / 25),
              ),
              onPressed: callback,
              padding: EdgeInsets.all(_corr / 75),
              color: Colors.lightBlueAccent,
              child: _getText(label, "Lato"))),
    );
  }

  _getText(String label, String familiy,{Color color}) {
    return Text(label,
        style: TextStyle(
            fontFamily: familiy,
            fontWeight: FontWeight.w200,
            fontSize: _corr / 50,
            color: color ?? Colors.white));
  }

  _login() {
    _auth.handleSignIn(() {
      //Navigator.pushNamed(context, Playscreen.route);
      setState(() {
        _userName = "Curent User:    ${_auth.user.email}";
        _space += _space;
      });
    });
  }

  _back() {
    Navigator.pushNamed(context, Homescreen.route);
  }
}
