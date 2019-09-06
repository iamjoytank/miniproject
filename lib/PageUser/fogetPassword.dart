import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  final Widget child;

  ForgetPassword({Key key, this.child}) : super(key: key);

  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: widget.child,
    );
  }
}