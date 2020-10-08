import 'package:flutter/material.dart';
import '../strings.dart';
import '../homebar.dart';
import 'dreamboardform.dart';
import 'dreamboardgallery.dart';

class Dreamboard extends StatefulWidget {
  @override
  _dreamboardState createState() => new _dreamboardState();
}
class _dreamboardState extends State<Dreamboard> {
  DreamboardMenu homeMenu;
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    homeMenu = DreamboardMenu(this.callback);

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

class DreamboardMenu extends StatefulWidget {
  Function callback;
  DreamboardMenu(this.callback);

  @override
  _dreamboardMenuState createState() => new _dreamboardMenuState();
}

class _dreamboardMenuState extends State<DreamboardMenu> {

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new Scaffold (
      resizeToAvoidBottomPadding: false,
      appBar: new PreferredSize(child: new HomeBar(Strings.dreamboard, true, () => this.widget.callback(DreamboardForm(this.widget.callback))), preferredSize: new Size(double.infinity, kToolbarHeight)),
      body:
      new Padding(
        padding: EdgeInsets.all(16),
        child:
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            getMenuButton(context, 'Experiences'),
            getMenuButton(context, 'Growth'),
            getMenuButton(context, 'Contribution'),
          ],
        ),
      ),
    );

  }

  Map<String, String> menuItem = {'Experiences': 'experiences.jpg', 'Growth': 'growth.jpg', 'Contribution': 'contributions.jpg'};
  double buttonWidth = 350;
  double buttonHeight = 150;

  getMenuButton(BuildContext context, String type) {
    return new Padding(
      padding: EdgeInsets.only(top: 16),
      child: new InkWell(
        onTap: () => this.widget.callback(DreamboardGallery(type, this.widget.callback)),
        child: new Align(
          alignment: Alignment.center,
          child: new Container(
            width: buttonWidth,
            height: buttonHeight,
            child: new Padding(
              padding: EdgeInsets.only(top: 110),
              child: new Container(
                  width: buttonWidth,
                  height: buttonHeight/2,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(18.0), bottomRight: Radius.circular(18.0)),
                    color: Colors.white,
                  ),
                  child: new Padding(
                    padding: EdgeInsets.only(top:5),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Center(
                          child: new Padding(
                            child: new Text(type, style: Theme.of(context).textTheme.body1,),
                            padding: EdgeInsets.only(bottom:12),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage("assets/images/" + menuItem[type]),
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
          ),
        ),
      ),
    );
  }
}

