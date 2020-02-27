import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Authscreen extends StatefulWidget {

  static String route ="/auth";

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
        return _getAuth();
      },
    );
  }

  _handleSignIn() async {
    print("login ...");
    AuthResult result = await _auth.signInWithEmailAndPassword(email: "hello@dash.test", password: "test1234").catchError((e)=> print(e));
    FirebaseUser user = result.user;
    print(user.email);
    Navigator.pop(context);

  }

  _getAuth(){
    return Container(
      height: _size.height * 0.3,
      width: _size.width * 0.3,
      color: Colors.amber.shade900,
      child: Column(
        children: <Widget>[
          MaterialButton(
            child: Text("login"),
            onPressed: () {
              _handleSignIn();
            },
          ),
        ],
      ),

    );
  }
}
