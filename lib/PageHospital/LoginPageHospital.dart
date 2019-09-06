import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_app/PageHospital/HospitalHomePage.dart';
import 'package:life_app/PageHospital/RegisterPageHospital.dart';

class LoginPageHospital extends StatefulWidget {
  final Widget child;

  LoginPageHospital({Key key, this.child}) : super(key: key);

  _LoginPageHospitalState createState() => _LoginPageHospitalState();
}

class _LoginPageHospitalState extends State<LoginPageHospital> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String message = 'Please Login';

  void validateAndState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Login Hospital"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top:30.0),
          decoration: BoxDecoration(color: Colors.white),
          child: new Form(
            autovalidate: true,
            key: _formkey,
            child: Container(
              padding: const EdgeInsets.all(55.0),
              child: Column(
                children: <Widget>[
                  Icon(Icons.person_add,color:Colors.red,size: 120.0,),
                  TextFormField(
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (input) => _email = input,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.email), labelText: 'Email'),
                  ),
                  TextFormField(
                    validator: _validatePassword,
                    obscureText: true,
                    onSaved: (input) => _password = input,
                    decoration: InputDecoration(
                        icon: const Icon(Icons.vpn_key),
                        labelText: 'Password'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0)),
                  Text(message,style:
                          new TextStyle(fontSize: 16.0, color: Colors.red)),                       
                  ButtonTheme(
                    minWidth: 250.0,
                    height: 40.0,
                    splashColor: Colors.lightBlue,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      color: Colors.blue,
                      onPressed: signIn,
                      child: Text("Login"),
                    ),
                  ),
                  // ButtonTheme(
                  //   minWidth: 250.0,
                  //   height: 40.0,
                  //   child: RaisedButton(
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(40.0)),
                  //     color: Colors.grey,
                  //     onPressed: signIn,
                  //     child: Text("Forgot Password"),
                  //   ),
                  // ),
                  ButtonTheme(
                    minWidth: 250.0,
                    height: 40.0,
                    splashColor: Colors.lightGreen,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        color: Colors.green,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPageHospital()),
                          );
                        },
                        child: Text("Sign Up")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print("Email: $_email password: $_password $user");
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HospitalHomePage(user: user)))
            .then((_) => _formkey.currentState.reset());
      } catch (e) {
        print("not sign in");
        setState(() {
          message = "Please Sign Up! Or check the Passsword!";
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
