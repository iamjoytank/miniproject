import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:life_app/PageHospital/TreatmentEntry.dart';
import 'package:life_app/PageHospital/TreatmentList.dart';

final mainReference1 =
    FirebaseDatabase.instance.reference();
final mainReference2 =
    FirebaseDatabase.instance.reference().child('hospitals/');
ScrollController _listViewScrollController = new ScrollController();
final TextEditingController eCtrl = new TextEditingController();
FirebaseUser user;

class TreatmentPage extends StatefulWidget {
  TreatmentPage(FirebaseUser user1){
    user = user1;
  }

  _TreatmentPageState createState() => _TreatmentPageState();
}

class _TreatmentPageState extends State<TreatmentPage> {
  List<TreatmentList> treatmentlist = new List();

  _TreatmentPageState() {
    mainReference2.child('${user.uid}/treatments/').onChildAdded.listen(_onEntryAdded);
    mainReference2.child('${user.uid}/treatments/').onChildChanged.listen(_onEntryEdited);
  }
  _onEntryAdded(Event event) {
    if (mounted) {
      setState(() {
        eCtrl.clear();
        treatmentlist.add(new TreatmentList.fromSnapshot(event.snapshot));
      });
    }
  }

  _onEntryEdited(Event event) {
    var oldValue =
        treatmentlist.singleWhere((entry) => entry.key == event.snapshot.key);
    if (mounted) {
      setState(() {
        eCtrl.clear();
        treatmentlist[treatmentlist.indexOf(oldValue)] =
            new TreatmentList.fromSnapshot(event.snapshot);
      });
    }
  }

  // _onEntryRemoved(Event event) {
  //   setState(() {
  //     print(event.snapshot.value['doctor_name']);
  //     TreatmentList.remove(event.snapshot.value['treatment_name']);
  //   });
  // }
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                color: Colors.red,
                onPressed: _onAddEntry,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Icon(Icons.add,size: 24.0,color: Colors.white),
                    Text(
                      "Add Treatment +",
                      style: new TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
              //Text("${user.uid}"),//parent key
              new ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  controller: _listViewScrollController,
                  itemCount: treatmentlist.length,
                  itemBuilder: (buildContext, index) {
                    var listtile = ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.white))),
                        child: Icon(Icons.local_hospital, color: Colors.white),
                      ),
                      title: Text(
                        "Treatment Name: ${treatmentlist[index].getTreatmentName}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      key: Key(treatmentlist[index].getKey),
                      subtitle: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                          Icon(Icons.attach_money,
                              color: Colors.yellowAccent, size: 16.0),
                          Text(
                              " Treatment Cost:${treatmentlist[index].getCost}",
                              style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          Row(children: <Widget>[
                          Icon(Icons.person,
                              color: Colors.yellowAccent, size: 16.0),                            
                          Text("Doctor Name: ${treatmentlist[index].getDoctorName}",
                          style: TextStyle(color: Colors.white))
                          ],)
                        ],
                      ),
                      trailing: Icon(Icons.delete_forever,
                          color: Colors.white, size: 22.0),
                      onTap: () => _onRemove(treatmentlist[index].getKey,index),
                    );
                    return Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                          decoration: BoxDecoration(color: Colors.red),
                          child: listtile),
                    );
                  }),
            ],
          ),
        ));
  }

  _onAddEntry() async {
    TreatmentList treatmententry =
        await Navigator.of(context).push(new MaterialPageRoute<TreatmentList>(
      builder: (BuildContext context) {
        return TreatmentEntry.add();
      },
    ));
    if (treatmententry != null) {
      print(treatmententry.getTreatmentName);
      mainReference1.child('hospitals/${user.uid}/treatments/').push().update(treatmententry.toJson());
    }
  }

  // _onEditEntry(treatmentlist) async {
  //   await Navigator.of(context).push(new MaterialPageRoute<TreatmentList>(
  //     builder: (BuildContext context) {
  //       return TreatmentEntry.edit(treatmentlist);
  //     },
  //   )).then((TreatmentList newentry) {
  //     if (newentry != null) {
  //       dynamic path;
  //       path = "hospitals/treatments";
  //       mainReference1
  //           .orderByChild('hospitaluid')
  //           .equalTo(user.uid)
  //           .once()
  //           .then((DataSnapshot snapshot) {
  //         final db =
  //             FirebaseDatabase.instance.reference().child("hospitals/${user.uid}/treatments/");
  //         db.push().set(newentry.toJson());
  //       });
  //     }
  //   });
  // }

  _onRemove(treatmentlistKey,index)async{
    mainReference1.reference().child("hospitals/${user.uid}/${treatmentlistKey}/").remove().then((_){
      setState(() {
        eCtrl.clear();
        treatmentlist.removeAt(index);
      });
    });

  }
}
