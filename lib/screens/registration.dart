import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/splash.jpg"),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.7), BlendMode.srcOver),
              ),
            ),
          ),
          Center(
            child: new Container(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 250,
                    child: Image.asset("assets/icons/criber.png"),
                  ),
                  RegistrationForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final usersDatabaseReference =
      FirebaseDatabase.instance.reference().child('users');

  String name, email, password;

  bool isEmail(String email) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  validateEmailField(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    } else {
      if (!isEmail(email)) {
        return 'Invalid email address';
      }
    }
  }

  validateOnSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  registerUserInfo() {
    if (validateOnSave()) {
      return usersDatabaseReference.push().set({
        'name': name,
        'email': email,
        'current_address': 'Test test',
        'profile_photo':
            'https://firebasestorage.googleapis.com/v0/b/criber.appspot.com/o/2408605_0.jpg?alt=media&token=0983fdc6-c663-45d9-be28-a8220305ed1c',
        'workplace': 'Test test test',
        'birthday': 'February 1, 1990',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 50.0, right: 30.0, bottom: 20.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.body1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Username or Email',
                  errorStyle: new TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                validator: (value) => validateEmailField(value),
                onSaved: (value) => email = value,
              )),
          Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 0.5, right: 30.0, bottom: 20.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.body1,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Password',
                  errorStyle: new TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                validator: (value) =>
                    value.isEmpty ? 'Password is required' : null,
                onSaved: (value) => password = value,
              )),
          Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 0.5, right: 30.0, bottom: 20.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.body1,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    // width: 0.0 produces a thin "hairline" border
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Full name',
                  errorStyle: new TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                validator: (value) =>
                    value.isEmpty ? 'Full name is required' : null,
                onSaved: (value) => name = value,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: new MaterialButton(
              height: 40.0,
              minWidth: 350.0,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: new Text("SIGN UP"),
              onPressed: () => registerUserInfo().then((result) async {
                    FirebaseUser user = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: email, password: password);
                    // print('Registered user: ${user.uid}');
                    if (user.uid != '') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    }
                  }),
              splashColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
