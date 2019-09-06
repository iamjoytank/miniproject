import 'dart:async';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_app/PageExtra/About.dart';
import 'package:life_app/PageExtra/ContactUs.dart';
import 'package:life_app/PageExtra/Setting.dart';
import 'package:life_app/PageHospital/TreatmentList.dart';
import 'package:life_app/PageUser/HospitalDetailPage.dart';
import 'package:life_app/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:life_app/PageHospital/Hospital.dart';

final mainReference1 =
    FirebaseDatabase.instance.reference().child("hospitals/");
final TextEditingController eCtrl = new TextEditingController();

class HospitalDetails {
  String _hospital_name;
  int _hospital_id;
  String _city;
  var _hospital_phno;
  String _hospital_address;
  String _hospital_email;
  String _treatment_name;
  String _cost;
  String _doctor_name;

  HospitalDetails(
      this._hospital_name,
      this._hospital_email,
      this._city,
      this._hospital_address,
      this._hospital_phno,
      this._doctor_name,
      this._treatment_name,
      this._cost);

  String get getHospitalName => _hospital_name;
  String get getHospitalEmail => _hospital_email;
  String get getHospitalCity => _city;
  String get getHospitalAddress => _hospital_address;
  int get getHospitalPhno => _hospital_phno;
  String get getHDoctorName => _doctor_name;
  String get getHTreatmentName => _treatment_name;
  String get getTCost => _cost;
}

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  ScrollController _listViewScrollController = new ScrollController();

  List<String> _citys = <String>['Mumbai', 'Nagpur'];
  List<String> _treatments = <String>["eye", "xray", "MRI"];
  String _city, _nameofTreatment;

  // List<Hospital> hospitaldata = new List();
  // List<DoctorList> doctordata = new List();
  // List<TreatmentList> treatmentdata = new List();
  List<HospitalDetails> hospitaldata = new List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      new BoxShadow(
                        color: Colors.red,
                        blurRadius: 10.0,
                      ),
                    ]),
                    height: 340.0,
                    width: 350.0,
                    child: Form(
                      key: _formkey,
                      child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                            ),
                            Container(
                                width: 320.0,
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        icon: const Icon(Icons.location_city),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                      ),
                                      isEmpty: _city == null,
                                      child: new SingleChildScrollView(
                                        child: new DropdownButton<String>(
                                          hint: Text(" Enter City name   "),
                                          value: _city,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _city = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items: _citys.map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                            ),
                            Container(
                                width: 320.0,
                                child: FormField<String>(
                                  builder: (FormFieldState<String> state) {
                                    return InputDecorator(
                                      decoration: InputDecoration(
                                        icon: const Icon(Icons.location_city),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                      ),
                                      isEmpty: _nameofTreatment == null,
                                      child: new SingleChildScrollView(
                                        child: new DropdownButton<String>(
                                          hint:
                                              Text(" Enter Treatment name   "),
                                          value: _nameofTreatment,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _nameofTreatment = newValue;
                                              state.didChange(newValue);
                                            });
                                          },
                                          items:
                                              _treatments.map((String value) {
                                            return new DropdownMenuItem<String>(
                                              value: value,
                                              child: new Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                            ),
                            Center(
                                child: Row(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                              ),
                              RaisedButton(
                                // minWidth: 300.0,
                                // height: 40.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60)),
                                color: Colors.blue,
                                onPressed: _getData,
                                child: Text("Submit"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50.0),
                              ),
                              RaisedButton(
                                // minWidth: 300.0,
                                // height: 40.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60)),
                                color: Colors.blue,
                                onPressed: onClear,
                                child: Text("Clear"),
                              ),
                            ])),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  new ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      controller: _listViewScrollController,
                      itemCount: hospitaldata.length,
                      itemBuilder: (buildContext, index) {
                        return Card(
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                              decoration: BoxDecoration(color: Colors.red),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(
                                              width: 1.0,
                                              color: Colors.white))),
                                  child: Icon(Icons.local_hospital,
                                      color: Colors.white),
                                ),
                                title: Text(
                                  "${hospitaldata[index].getHospitalName}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    Text(" Cost: Rs",
                                        style: TextStyle(color: Colors.white)),
                                    Text("${hospitaldata[index].getTCost}(approx.)",
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right,
                                    color: Colors.white, size: 30.0),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HospitalDetailPage(
                                                  hospitaldata[index])));
                                },
                              )),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, new MaterialPageRoute(builder: (context) => new MyHomePage()));
    //googleSignIn.signOut();
  }

  _getData() {
    mainReference1.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key1, values1) {
        print("key1---$key1");
        Hospital hospital = new Hospital(
            values1['hospital_name'],
            values1['hospital_email'],
            values1['city'],
            values1['hospital_address'],
            values1['hospital_phno']);
        values1.forEach((key2, values2) {
          if (key2 == "treatments") {
            values2.forEach((key3, values3) {
              TreatmentList treatment = new TreatmentList(
                  values3["treatment_name"],
                  values3["cost"],
                  values3["doctor_name"],
                  values3["city"]);
              if (_nameofTreatment == treatment.getTreatmentName &&
                  _city == hospital.gethospitalCity) {
                HospitalDetails hospitaldetail = new HospitalDetails(
                    hospital.gethospitalName,
                    hospital.gethospitalEmail,
                    hospital.gethospitalCity,
                    hospital.gethospitalAddress,
                    hospital.gethospitalPhno,
                    treatment.getDoctorName,
                    treatment.getTreatmentName,
                    treatment.getCost);
                print(hospitaldetail.getHospitalName);

                hospitaldata.add(hospitaldetail);
              }
              setState(() {
                eCtrl.clear();
              });
            });
          }
        });
      });
    });
  }

  onClear() {
    setState(() {
      eCtrl.clear();
      hospitaldata.clear();
    });
  }
}
