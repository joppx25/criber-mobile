import 'package:flutter/material.dart';
import '../widgets.dart';
import 'dreamboard.dart';
import '../strings.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:zefyr/zefyr.dart';

class DreamboardForm extends StatefulWidget {
  Function callback;
  DreamboardForm(this.callback);

  @override
  _dreamboardFormState createState() => new _dreamboardFormState();
}

class _dreamboardFormState extends State<DreamboardForm> {

  ZefyrController _expController;
  ZefyrController _groController;
  ZefyrController _conController;
  final FocusNode _expFocusNode = new FocusNode();
  final FocusNode _groFocusNode = new FocusNode();
  final FocusNode _conFocusNode = new FocusNode();

  final experiencesDoc = new NotusDocument();
  final growthDoc = new NotusDocument();
  final contributionDoc = new NotusDocument();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String location;
  String description;

  List<File> _images = new List();

  Future getImage(from) async {
    var image = await ImagePicker.pickImage(source: from);

    if (image != null) {
      if (_images == null) _images = new List();

      setState(() {
        _images.add(image);
      });
    }
  }

  Future<bool> _onWillPop() {
    this.widget.callback(DreamboardMenu(this.widget.callback))
        ?? false;
  }

  @override
  void initState() {
    super.initState();
    _expController = new ZefyrController(experiencesDoc);
    _groController = new ZefyrController(growthDoc);
    _conController = new ZefyrController(contributionDoc);
    _expFocusNode.unfocus();
    _groFocusNode.unfocus();
    _conFocusNode.unfocus();

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

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
      onWillPop: _onWillPop,
      // Build a Form widget using the _formKey we created above
      child: Form(
        key: _formKey,
        child: new Scaffold (
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          appBar: new ReusableWidgets().getAppBar(context, Strings.dreamboardForm, () => this.widget.callback(DreamboardMenu(this.widget.callback))),
          body: new Center(
              child: new Padding (
                  padding: EdgeInsets.only(top:16, left:16, right:16),
                  child: new Container(
                    child: new Stack(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 950,
                            ),
                            child: IntrinsicHeight(
                                child: new Column(
                                  children: <Widget>[
                                    new Padding(
                                        padding: EdgeInsets.only(top:16, bottom: 16),
                                        child: new Align(
                                          alignment: Alignment.topLeft,
                                          child: new Text("Experiences", style: Theme.of(context).textTheme.body1,),
                                        )
                                    ),
                                    new Container(
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight: 150,
                                        ),
                                        child: ZefyrScaffold(
                                          child: ZefyrEditor(
                                            controller: _expController,
                                            focusNode: _expFocusNode,
                                          ),
                                        )
                                      ),
                                      decoration: new BoxDecoration (
                                          borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          color: Colors.white
                                      ),
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.only(top:16, bottom: 16),
                                        child: new Align(
                                          alignment: Alignment.topLeft,
                                          child: new Text("Growth", style: Theme.of(context).textTheme.body1,),
                                        )
                                    ),
                                    new Container(
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxHeight: 150,
                                          ),
                                          child: ZefyrScaffold(
                                            child: ZefyrEditor(
                                              controller: _groController,
                                              focusNode: _groFocusNode,
                                            ),
                                          )
                                      ),
                                      decoration: new BoxDecoration (
                                          borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          color: Colors.white
                                      ),
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.only(top:16, bottom: 16),
                                        child: new Align(
                                          alignment: Alignment.topLeft,
                                          child: new Text("Contribution", style: Theme.of(context).textTheme.body1,),
                                        )
                                    ),
                                    new Container(
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxHeight: 150,
                                          ),
                                          child: ZefyrScaffold(
                                            child: ZefyrEditor(
                                              controller: _conController,
                                              focusNode: _conFocusNode,
                                            ),
                                          )
                                      ),
                                      decoration: new BoxDecoration (
                                          borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          color: Colors.white
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
                                            child: new Text("Add background photo", style: Theme.of(context).textTheme.body1,),
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
                                  Strings.dreamboardCtaButton,
                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () => debugPrint(contributionDoc.toString()), //TODO
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
