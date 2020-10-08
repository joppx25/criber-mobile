import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets.dart';
import 'support.dart';
import '../strings.dart';
import 'package:criber/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:criber/models/user.dart';
import 'package:criber/services/user_management.dart';
import 'package:criber/services/support_management.dart';
import 'package:image_picker/image_picker.dart';

class SupportForm extends StatefulWidget {
  final Function callback;

  SupportForm(this.callback);

  @override
  _supportFormState createState() => new _supportFormState();
}

class _supportFormState extends State<SupportForm> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _userManagement = new UserManagement();
  final _supportManagement = new SupportManagement();

  String location;
  String description;

  List<File> _images = new List();

  Future getImage(from) async {
    var image = await ImagePicker.pickImage(source: from);

    if (image != null) {
      setState(() {
        _images.add(image);
      });
    }
  }

  void _settingModalBottomSheet(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera),
                    title: new Text('Take photo'),
                    onTap: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    }
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_album),
                  title: new Text('Select from gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  _showSnackBar(message) {
    final snackBar = new SnackBar(
      content: new Text(message),
      duration: Duration(seconds: 3),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  int _radioValue = -1;
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });

    if (_radioValue != 2) {
      List<String> defaultLocations = ["My Room", "Common Area"];
      location = defaultLocations[_radioValue];
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      if (_radioValue < 0) {
        _showSnackBar('Location is required!');
      } else {
        form.save();
      }
      return true;
    }
    return false;
  }

  validateOnSubmit(context) async {
    if (validateAndSave()) {
      FirebaseUser firebaseUser = await Auth().getCurrentUser();
      User currentUser = await _userManagement.getUserData();
      Object data = {"email": firebaseUser.email, "name": currentUser.name, "subject": location, "description": description, "status": 2, "priority": 2};
      String response = await _supportManagement.addTicket(data, _images);
      dynamic decodedResponse = json.decode(response);

      if (decodedResponse['id'] != null) {
        setState(() {
          _images.clear();
        });
        _formKey.currentState.reset();
        _showSnackBar('Ticket was successfully submitted!');
      } else {
        _showSnackBar(decodedResponse['description']);
      }
    }
  }

  Future<bool> _onWillPop() {
    this.widget.callback(Support(this.widget.callback)) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
      onWillPop: _onWillPop,
      // Build a Form widget using the _formKey we created above
      child: Form(
        key: _formKey,
        child: new Scaffold (
          resizeToAvoidBottomPadding: false,
          key: _scaffoldKey,
          appBar: new ReusableWidgets().getAppBar(context, Strings.supportForm, () => this.widget.callback(Support(this.widget.callback))),
          body: new Center(
            child: new Padding (
                padding: EdgeInsets.only(top:16, left:16, right:16),
                child: new Container(
                  child: new Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 600,
                          ),
                          child: IntrinsicHeight(
                              child: new Column(
                                children: <Widget>[
                                  new Align(
                                    alignment: Alignment.topLeft,
                                    child: new Text("Location", style: Theme.of(context).textTheme.body1,),
                                  ),
                                  new Align(
                                    alignment: Alignment.topLeft,
                                    child: new Row(
                                      children: <Widget>[
                                        new Radio(
                                          value: 0,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                        new Text("My Room", style: Theme.of(context).textTheme.body1,),
                                      ],
                                    ),
                                  ),
                                  new Align(
                                    alignment: Alignment.topLeft,
                                    child: new Row(
                                      children: <Widget>[
                                        new Radio(
                                          value: 1,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                        new Text("Common Area", style: Theme.of(context).textTheme.body1,),
                                      ],
                                    ),
                                  ),
                                  new Align(
                                    alignment: Alignment.topLeft,
                                    child: new Row(
                                      children: <Widget>[
                                        new Radio(
                                          value: 2,
                                          groupValue: _radioValue,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                        new Flexible(
                                          child: TextFormField(
                                            style: Theme.of(context).textTheme.body1,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                // width: 0.0 produces a thin "hairline" border
                                                borderRadius: BorderRadius.circular(20),
                                                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                              ),
                                              border: const OutlineInputBorder(),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'Type location...',
                                              errorStyle: new TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            validator: _radioValue == 2 ? ((value) => value.isEmpty ? _showSnackBar('Location is required!') : null) : null,
                                            onSaved: _radioValue == 2 ? ((value) => location = value) : null,
                                          ),
                                        )

                                      ],
                                    ),
                                  ),
                                  new Padding(
                                      padding: EdgeInsets.only(top:26, bottom: 16),
                                      child: new Align(
                                        alignment: Alignment.topLeft,
                                        child: new Text("Description", style: Theme.of(context).textTheme.body1,),
                                      )
                                  ),
                                  new Flexible(
                                    child: TextFormField(
                                      style: Theme.of(context).textTheme.body1,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          // width: 0.0 produces a thin "hairline" border
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                        ),
                                        border: const OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Type report description',
                                        errorStyle: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      validator: (value) => value.isEmpty ? _showSnackBar('Description is required!') : null,
                                      onSaved: (value) => description = value,
                                    ),
                                  ),
                                  new Padding(
                                    padding: EdgeInsets.only(top:26, bottom: 16),
                                    child:
                                    new Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Align(
                                          alignment: Alignment.centerLeft,
                                          child: new Text("Photo (Optional)", style: Theme.of(context).textTheme.body1,),
                                        ),
                                        new Align(
                                            alignment: Alignment.centerRight,
                                            child: Material(
                                              color: Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(32.0),
                                              elevation: 2.0,
                                              child: new MaterialButton(
                                                height: 5.0,
                                                minWidth: 5.0,
                                                textColor: Colors.white,
                                                child: new Text (
                                                  "Add..",
                                                  style: new TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                onPressed: (){_settingModalBottomSheet(context);},
                                                splashColor: Colors.greenAccent,
                                              ),
                                            )
                                        )

                                      ],
                                    ),
                                  ),
                                  _images.isEmpty? new Container(width: 0, height: 0) : getImages(_images),
                                ],
                              )),
                        ),
                      ),
                      new Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: new Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(32.0),
                            elevation: 2.0,
                            child: new MaterialButton(
                              height: 40.0,
                              minWidth: 40.0,
                              textColor: Colors.white,
                              child: new Text (
                                "Submit Report",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () => validateOnSubmit(context),
                              splashColor: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),

                    ],

                  ),
                )

            ),
          ),

        ),
      ),
    );

  }

}

Widget getImages(List<File> images)
{
  return new Column(children: images.map((item) => new Image.file(item)).toList());
}
