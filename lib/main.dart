import 'package:flutter/material.dart';
import 'package:life_app/CustomShapeClipper.dart';
import 'package:life_app/PageUser/LoginPageUser.dart';
import 'package:life_app/PageHospital/LoginPageHospital.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {  
    return MaterialApp(
      title: '(+)Care_App',
      theme: new ThemeData(
        primaryColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.red),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top:80.0),
          child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               Text("+Care",style: TextStyle(fontSize:  50.0,color: Colors.white)),
                Padding(padding: const EdgeInsets.only(top:20.0)),
                Container(
                      height: 160.0,
                      width: 160.0,
                      child: RawMaterialButton(
                        fillColor: Colors.white,
                        splashColor: Colors.red,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.account_circle,size:50.0,color: Colors.red,),
                            Text("User",style: new TextStyle(fontSize: 26.0,color: Colors.red),)
                          ],
                        ),
                        onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPageUser()),);},
                      ),
                    ),
                Divider(height: 50.0,),
                Container(
                      height: 160.0,
                      width: 160.0,
                      child: RawMaterialButton(
                        //elevation: 8.0,
                        fillColor: Colors.white,
                        splashColor: Colors.red,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(100.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.local_hospital,size:50.0,color: Colors.red,),
                            Text("Hospital",style: new TextStyle(fontSize: 26.0,color: Colors.red),)
                          ],
                        ),
                        onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPageHospital()),);},
                      ),
                    ),
              ],
            ),
          ],
          ),
        ),
      ),
    );
  }
}

                    
