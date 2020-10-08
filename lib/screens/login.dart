import 'package:flutter/material.dart';
import 'package:criber/base_auth.dart';
import 'package:criber/auth.dart';
import 'landing.dart';
import 'registration.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                  LoginForm(auth: new Auth())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({this.auth});

  final BaseAuth auth;

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Define a corresponding State class. This class will hold the data related to
// the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

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

  // TODO:Improve this function for better authentication approach
  validateOnSubmit() async {
    if (validateAndSave()) {
      return await widget.auth.signInWithEmailAndPassword(email, password);
    }
  }

  void moveToRegistration() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Registration()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, top: 50.0, right: 30.0, bottom: 20.0),
              child: TextFormField(
                initialValue: "test@test.com",
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
                initialValue: "password",
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
          FlatButton(
            child: Text('Have an existing account? Sign up',
                style: TextStyle(fontSize: 16.0, color: Colors.white)),
            onPressed: moveToRegistration,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: new MaterialButton(
              height: 40.0,
              minWidth: 350.0,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: new Text("LOG IN"),
              onPressed: () => validateOnSubmit().then((userId) {
                    try {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Landing()),
                      );
                    } catch (e) {
                      throw (e);
                    }
                  }).catchError((error) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                  }),
              splashColor: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
