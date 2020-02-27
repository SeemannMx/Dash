import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authscreen extends StatefulWidget {
  static String route = "/auth";

  @override
  _AuthscreenState createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Size _size;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _size = Size(constraints.biggest.width, constraints.biggest.height);
        return Scaffold(
          backgroundColor: Colors.grey.shade800,
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                _getImage("logo", "assets/img/logo.png"),
                SizedBox(height: 48.0),
                _getTextFormField("Email"),
                SizedBox(height: 8.0),
                _getTextFormField("Passord"),
                SizedBox(height: 24.0),
                _getRaisedButton('Log In', _handleSignIn),
              ],
            ),
          ),
        );
      },
    );
  }

  _handleSignIn() async {
    print("login ...");
    AuthResult result = await _auth
        .signInWithEmailAndPassword(
            email: "hello@dash.test", password: "test1234")
        .catchError((e) => print(e));
    FirebaseUser user = result.user;
    print(user.email);
    Navigator.pop(context);
  }

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
        contentPadding: EdgeInsets.all(5),
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
        radius: 48.0,
        child: Image.asset(path),
      ),
    );
  }

  _getRaisedButton(String label, VoidCallback callback) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: callback,
          /**
              onPressed: () {
              _handleSignIn();
              },
           **/
          padding: EdgeInsets.all(12),
          color: Colors.lightBlueAccent,
          child: Text(label, style: TextStyle(color: Colors.white))),
    );
  }
}
