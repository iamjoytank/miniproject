import 'package:flutter/material.dart';

class PageSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Text("Edit Detail Option"),
      ),
    );
  }
}