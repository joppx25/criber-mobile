import 'package:flutter/material.dart';
import '../widgets.dart';
import 'mycrib.dart';
import '../strings.dart';
import 'changeMyCribLocation.dart';

class ChangeMyCribInfo extends StatefulWidget {
  Function callback;
  ChangeMyCribInfo(this.callback);

  @override
  _changeMyCribInfoState createState() => new _changeMyCribInfoState();
}

class _changeMyCribInfoState extends State<ChangeMyCribInfo> {

  final String info = 'At Criber, we understand that our members value their mobility and flexibility. Hence, members are allowed to move freely to anywhere within the network of Criber residences up to 2 times a year!\n\n'
      'The following terms have to be met to:\n'
      '1. If a member upgrades their room to a more expensive room, they are allowed to continue with their current contract.\n'
      '2. If a member downgrades their room to a cheaper or equivalently priced room, their contract is automatically renewed for another year.\n'
      '3. The duration of a year is calculated from the starting date of a member\'s contract with Criber.\n'
      '4. If a member passes the quota of 2 changes a year, any extra changes are considered as a termination of contract.\n';

  Future<bool> _onWillPop() {
    this.widget.callback(MyCribMenu(this.widget.callback))
        ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold (
        appBar: new ReusableWidgets().getAppBar(context, Strings.changeMyCrib, () => this.widget.callback(MyCribMenu(this.widget.callback))),
        body: new Center(
          child: new Padding (
              padding: EdgeInsets.only(top:16, left:16, right:16),
              child: new Container(
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                        new ConstrainedBox(
                            constraints: new BoxConstraints(),
                            child: new Column(
                              children: <Widget>[
                                new Text(info,
                                  style: Theme.of(context).textTheme.body1,),
                              ],
                            )
                        ),
                    new Expanded(
                      child: new Align(
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
                                "Continue",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () => this.widget.callback(ChangeMyCribLocation(this.widget.callback)),
                              splashColor: Colors.greenAccent,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],

                ),
              )

          ),
        ),

      ),
    );

  }

}