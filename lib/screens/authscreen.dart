import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                SizedBox(height: _size.height * 0.1),
                _getTextFormField("Email"),
                SizedBox(height: _size.height * 0.025),
                _getTextFormField("Passord"),
                SizedBox(height: _size.height * 0.025),
                _getRaisedButton('Log In', _login),
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
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: RaisedButton(
            highlightElevation: _corr,
            elevation: _corr / 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: callback,
            padding: EdgeInsets.all(12),
            color: Colors.lightBlueAccent,
            child: _getText(label, "Lato")));
  }

  _getText(String label, String familiy) {
    return Text(label,
        style: TextStyle(
            fontFamily: familiy,
            fontWeight: FontWeight.w200,
            fontSize: _corr / 50,
            color: Colors.white));
  }

  _login() {
    _auth.handleSignIn(() {
      Navigator.pushNamed(context, Playscreen.route);
    });
  }
}
