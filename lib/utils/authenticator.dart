import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class Authenticator {
  Authenticator._internal() {}
  static Authenticator _authenticator = Authenticator._internal();

  factory Authenticator() => _authenticator;

  FirebaseAuth _fire = FirebaseAuth.instance;
  FirebaseUser _user;
  AuthResult _result;

  handleSignIn(VoidCallback callback) async {
    print("login ...");
    await _fire
        .signInWithEmailAndPassword(email: "hello@dash.test", password: "test1234")
        .then((AuthResult response){
          print(response.user.email);
          callback.call();
        }).catchError((e) => print(e));
  }
}
