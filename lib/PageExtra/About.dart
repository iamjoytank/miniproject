import 'package:flutter/material.dart';

class PageAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            Text("Life is a mobile application, Run by @ S.B Jain Institute of Technology Management and Research Our purpose is to provide the facility to compare the fees of the medical treatments as well as experience and ratings that is the success rate of that doctor which plays vital role at the time of operation.",
              style: TextStyle(fontSize: 20.0,),
                textAlign: TextAlign.start,
            ),
            
            Text("Eulogized by: - S.B Jain Institute of Technology Management and Research", style: TextStyle(fontSize: 20.0,),),
          ],
        )
      ),
    );
  }
}