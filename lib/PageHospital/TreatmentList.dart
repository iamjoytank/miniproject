import 'package:firebase_database/firebase_database.dart';

class TreatmentList {
  String key;
  String treatment_name;
  String cost;
  String doctor_name;
  String city;

  TreatmentList(this.treatment_name, this.cost,this.doctor_name,this.city);

  TreatmentList.fromSnapshot(DataSnapshot snapshot) {
    this.key = snapshot.key;
    this.treatment_name = snapshot.value["treatment_name"];
    this.cost = snapshot.value["cost"];
    this.doctor_name =snapshot.value["doctor_name"];
    this.city =snapshot.value["city"];
  }

  String get getKey => key;
  String get getTreatmentName => treatment_name;
  String get getCost => cost;
  String get getDoctorName => doctor_name;
  String get getCity => city;

  toJson() {
    return {"key":key,"treatment_name": treatment_name, "cost": cost,"doctor_name":doctor_name,"city":city};
  }
}
