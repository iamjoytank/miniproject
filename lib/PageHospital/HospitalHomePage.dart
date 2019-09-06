import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:life_app/PageExtra/About.dart';
import 'package:life_app/PageExtra/ContactUs.dart';
import 'package:life_app/PageExtra/Setting.dart';
import 'package:life_app/PageHospital/TreatmentPage.dart';
import 'package:life_app/main.dart';

final mainReference1 =
    FirebaseDatabase.instance.reference();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
class HospitalHomePage extends StatefulWidget {
  final FirebaseUser user;
  const HospitalHomePage({Key key, this.user}) : super(key: key);
  @override
  _HospitalHomePageState createState() => _HospitalHomePageState();
}

class _HospitalHomePageState extends State<HospitalHomePage>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Row(
              children: <Widget>[
                Text('(+)Care'),
                //new Image.asset('images/LOGO_p2.png',fit: BoxFit.contain,height: 46.0,),
              ],
            ),
          ),
        ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text("Hello"),
                accountEmail: new Text('${widget.user.email}'),
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.white,
                ),
              ),
              new Divider(),
              new ListTile(
                  title: new Text("Setting"),
                  leading: Icon(Icons.settings, color: Colors.black),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PageSetting()))),
              new ListTile(
                  title: new Text("Contact Us"),
                  leading: Icon(Icons.contacts, color: Colors.black),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PageContact()))),
              new ListTile(
                  title: new Text("About"),
                  leading: Image(
                    image: AssetImage("images/about.png"),
                    height: 25.0,
                    width: 25.0,
                  ),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PageAbout()))),
              new ListTile(
                title: Text("Log out"),
                onTap: _signout,
                leading: Image(
                  image: AssetImage("images/logout_icon.png"),
                  height: 25.0,
                  width: 25.0,
                ),
              )
            ],
          ),
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Text("${widget.user.uid}"),key of hospital
                Padding(padding:const EdgeInsets.only(top:20.0)),
                ButtonTheme(
                  minWidth: 240.0,
                  height: 80.0,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TreatmentPage(widget.user)));
                    },
                    child: Text("Treatments",
                        style:
                            new TextStyle(fontSize: 24.0, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => new MyHomePage()))
        .then((_) => _formkey.currentState.reset());
  }
}
