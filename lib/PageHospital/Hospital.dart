import 'package:firebase_database/firebase_database.dart';
import 'package:life_app/PageHospital/TreatmentList.dart';


class Hospital {
  String key;
  String _hospital_name;
  int _hospital_id;
  String _city;
  var _hospital_phno;
  String _hospital_address;
  String _hospital_email;


  Hospital(this._hospital_name,this._hospital_email,this._city,this._hospital_address,this._hospital_phno);

  String get gethospitalName => _hospital_name;
  String get gethospitalEmail => _hospital_email;
  String get gethospitalCity => _city;
  String get gethospitalAddress => _hospital_address;
  int get gethospitalPhno => _hospital_phno;

  // set sethospitalName(String hospital_name) => this.hospital_name = hospital_name;
  // set sethospitalEmail(String hospital_email) => this.hospital_email = hospital_email;
  // set sethospitalAddress(String hospital_address) => this.hospital_address = hospital_address;
  // set sethospitalPhno(String hospital_Phno) => this.hospital_phno = hospital_phno;

  Hospital.fromSnapshot(DataSnapshot snapshot){
    key = snapshot.key;
    _hospital_name = snapshot.value['hospital_name'];
    _hospital_email = snapshot.value['hospital_email'];
    _city = snapshot.value['city'];
    _hospital_address = snapshot.value['hospital_address'];
    _hospital_phno = snapshot.value['hospital_phno'];
  }
  
  // display() {
  //   print("Hospital Name: $_hospital_name");
  //   print("Hospital emailId: $_hospital_id");
  //   print("Hospital Phone number: $_hospital_phno");
  //   print("Hospital Address: $_hospital_address");
  // }
}