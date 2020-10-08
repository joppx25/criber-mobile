import 'package:flutter/material.dart';
import '../widgets.dart';
import 'mycrib.dart';
import 'support.dart';
import '../strings.dart';
import '../homebar.dart';
import 'payment.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}
class _HomeState extends State<Home> {
  HomeMenu homeMenu;
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    homeMenu = HomeMenu(this.callback);

    currentPage = homeMenu;
  }

  void callback(Widget nextPage) {
    setState(() {
      this.currentPage = nextPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: currentPage
    );
  }
}

class HomeMenu extends StatefulWidget {
  Function callback;
  HomeMenu(this.callback);

  @override
  _homeMenuState createState() => new _homeMenuState();
}

class _homeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new Scaffold (
      resizeToAvoidBottomPadding: false,
      appBar: new PreferredSize(child: new HomeBar("Home", false, () => {}), preferredSize: new Size(double.infinity, kToolbarHeight)),
      body:
      new Padding(
        padding: EdgeInsets.all(16),
        child: new Row (
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children : <Widget> [
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new ReusableWidgets().getMenuButton(context,"mycrib.png", Strings.myCrib, () => this.widget.callback(MyCribMenu(this.widget.callback))),
                  new ReusableWidgets().getMenuButton(context,"support.png", Strings.support, () => this.widget.callback(Support(this.widget.callback))),
                ],
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new ReusableWidgets().getMenuButton(context,"payment.png", Strings.payment, () => this.widget.callback(Payment(this.widget.callback))),
                ],
              )
            ]
        ),
      ),
    );

  }

}