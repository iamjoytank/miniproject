import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_app/PageUser/UserHomePage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignUp extends StatefulWidget {
  final Widget child;

  GoogleSignUp({Key key, this.child}) : super(key: key);

  _GoogleSignUpState createState() => _GoogleSignUpState();
}

class _GoogleSignUpState extends State<GoogleSignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: widget.child,
    );
  }
}