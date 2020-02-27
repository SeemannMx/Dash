import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeAuth extends StatefulWidget {
  HomeAuth({@required this.size});

  Size size;

  @override
  _HomeAuthState createState() => _HomeAuthState();
}

class _HomeAuthState extends State<HomeAuth> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return _getAuth();
  }

  _handleSignIn() async {
    print("login ...");
    AuthResult result = await _auth.signInWithEmailAndPassword(email: "hello@dash.test", password: "test1234").catchError((e)=> print(e));
    FirebaseUser user = result.user;
    print(user.email);
  }

  _getAuth(){
    return Container(
      height: widget.size.height * 0.3,
      width: widget.size.width * 0.3,
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
