import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:life_app/PageHospital/HospitalHomePage.dart';
import 'package:life_app/PageHospital/TreatmentList.dart';

final mainReference = FirebaseDatabase.instance.reference().child('hospitals/');
String uid;

class TreatmentEntry extends StatefulWidget {
  final TreatmentList treatmentlistentryToedit;
  String initialtreatment, initialcost,initialdoctorname;
  TreatmentEntry.add() : treatmentlistentryToedit = null;
  TreatmentEntry.edit(this.treatmentlistentryToedit) {
    this.initialtreatment = treatmentlistentryToedit.getTreatmentName;
    this.initialcost = treatmentlistentryToedit.getCost;
    this.initialdoctorname = treatmentlistentryToedit.getDoctorName;
  }
  TreatmentEntry.remove(this.treatmentlistentryToedit);
  _TreatmentEntryState createState() {
    if (treatmentlistentryToedit != null) {
      return new _TreatmentEntryState(treatmentlistentryToedit.treatment_name,
          treatmentlistentryToedit.cost,treatmentlistentryToedit.doctor_name);
    } else {
      return new _TreatmentEntryState(initialtreatment, initialcost,initialdoctorname);
    }
  }
}

class _TreatmentEntryState extends State<TreatmentEntry> {
  String treatmentName, cost,doctorName,city;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _textController;

  _TreatmentEntryState(String initialtreatment, String cost, String doctorname);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Add Treatment"),
          actions: <Widget>[
            FlatButton(
              onPressed: addSave,
              child: new Text('SAVE',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white)),
            ),
          ],
        ),
        body: Form(
          key: _formkey,
          child: new Column(children: [
            new ListTile(
              leading: new Icon(Icons.speaker_notes, color: Colors.grey[500]),
              title: new TextField(
                decoration: new InputDecoration(
                  labelText: "Treatment Name",
                  hintText: 'Enter treatment name',
                ),
                controller: _textController,
                onChanged: (value) => setState(() => treatmentName = value),
                onTap: () {},
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.speaker_notes, color: Colors.grey[500]),
              title: new TextField(
                decoration: new InputDecoration(
                  labelText: "Treatment Cost",
                  hintText: 'Enter cost of treatment name',
                ),
                controller: _textController,
                onChanged: (value) => setState(() => cost = value),
                onTap: () {},
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.speaker_notes, color: Colors.grey[500]),
              title: new TextField(
                decoration: new InputDecoration(
                  labelText: "Doctor Name",
                  hintText: 'Enter the name of doctor',
                ),
                controller: _textController,
                onChanged: (value) => setState(() => doctorName = value),
                onTap: () {},
              ),
            ),
                        new ListTile(
              leading: new Icon(Icons.speaker_notes, color: Colors.grey[500]),
              title: new TextField(
                decoration: new InputDecoration(
                  labelText: "City ",
                  hintText: 'Enter the name of city',
                ),
                controller: _textController,
                onChanged: (value) => setState(() => city = value),
                onTap: () {},
              ),
            )
          ]),
        ));
  }

  Future<void> addSave() async {
    Navigator.of(context).pop(new TreatmentList(treatmentName, cost,doctorName,city));
  }
}
