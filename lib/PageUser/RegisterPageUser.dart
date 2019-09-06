import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_app/PageUser/LoginPageUser.dart';

class RegisterPageUser extends StatefulWidget {
  final Widget child;

  RegisterPageUser({Key key, this.child}) : super(key: key);
  @override
  _RegisterPageUserState createState() => _RegisterPageUserState();
}

class _RegisterPageUserState extends State<RegisterPageUser> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String passwordcf, emailId, password;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordcfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Form(
              autovalidate: true,
              key: _formkey,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                    ),
                    TextFormField(
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (input) => emailId = input,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.email), labelText: 'Email'),
                    ),
                    // TextFormField(
                    //   validator:(input){
                    //     if(input.length < 10 ){ return 'Enter mobile number';}
                    //   } ,
                    //   onSaved: (input)=>_mobileNo =int.tryParse(input),
                    //   decoration: InputDecoration(icon:const Icon(Icons.phone),labelText:'Enter mobile number',),
                    // ),
                    TextFormField(
                      validator: _validatePassword,
                      onSaved: (input) => password = input,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.vpn_key),
                          labelText: 'Password'),
                      obscureText: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    ButtonTheme(
                      minWidth: 300.0,
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
          ),
        ));
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

  Future<void> signUp() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: emailId, password: password);
        print("Email: $emailId password: $password $user");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPageUser()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
