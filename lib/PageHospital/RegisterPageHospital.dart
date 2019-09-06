import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_app/PageHospital/LoginPageHospital.dart';
import 'package:firebase_database/firebase_database.dart';
class RegisterPageHospital extends StatefulWidget {
  @override
  _RegisterPageHospitalState createState() => _RegisterPageHospitalState();
}

class _RegisterPageHospitalState extends State<RegisterPageHospital> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String message = 'Please Enter details';

  String _hospital_name;
  int _hospital_id;
  var _hospital_phno;
  String _city;
  String _hospital_address;
  String _hospital_email;
  String _password;

  toJson(newkey) {
    return {
      "key":newkey,
      "hospitalId": _hospital_id,
      "hospital_name": _hospital_name,
      "hospital_phno": _hospital_phno,
      "city":_city,
      "hospital_address": _hospital_address,
      "hospital_email": _hospital_email
    };
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: SingleChildScrollView(
          child: Form(
            autovalidate: true,
            key: _formkey,
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(message,style:
                          new TextStyle(fontSize: 16.0, color: Colors.red)),                      TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Enter hospital Id';
                      }
                    },
                    onSaved: (input) => _hospital_id = int.parse(input),
                    decoration: InputDecoration(
                      icon: const Icon(Icons.perm_identity),
                      labelText: 'Enter hospital Id',
                    ),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return 'Enter hospital name';
                      }
                    },
                    onSaved: (input) => _hospital_name = input,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.perm_identity),
                      labelText: 'Enter hospital name',
                    ),
                  ),
                  TextFormField(
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (input) => _hospital_email = input,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.email), labelText: 'Email'),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.length < 10) {
                        return 'Enter mobile number';
                      }
                    },
                    onSaved: (input) => _hospital_phno = int.tryParse(input),
                    decoration: InputDecoration(
                      icon: const Icon(Icons.phone),
                      labelText: 'Enter mobile number',
                    ),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return "Enter City name";
                      }
                    },
                    onSaved: (input) => _city = input,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.location_city),
                      labelText: "Enter City name",
                    ),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input.isEmpty) {
                        return "Enter hospital's address";
                      }
                    },
                    onSaved: (input) => _hospital_address = input,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.location_on),
                      labelText: "Enter hospital's complete address",
                    ),
                  ),
                  TextFormField(
                    validator: _validatePassword,
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.vpn_key), labelText: 'Password'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),
                  ButtonTheme(
                    minWidth: 320.0,
                    height: 40.0,
                    splashColor: Colors.lightBlue,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      color: Colors.blue,
                      onPressed: signUp,
                      child: Text("Sign Up"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> signUp() async {
    final formState = _formkey.currentState;
    final mainReference =
        FirebaseDatabase.instance.reference();

    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _hospital_email, password: _password);
        print("Email: $_hospital_email password: $_password $user ");
        mainReference.child("hospitals/${user.uid}").set(toJson(user.uid));
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginPageHospital()));
      } catch (e) {
        print(e);
        setState(() {
          message = e.message;
        });
      }
    }
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      // The form is empty
      return "Enter email address";
    }
    // This is just a regular expression for email addresses
    String string = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(string);

    if (regExp.hasMatch(value)) {
      // So, the email is valid
      return null;
    }
    // The pattern of the email didn't match the regex above.
    return 'Email is not valid';
  }

  String _validatePassword(String input) {
    if (input.length < 6) {
      return "Your password needs to be atleast 6 charactors";
    }
  }
}
