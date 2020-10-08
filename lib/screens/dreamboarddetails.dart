import 'package:flutter/material.dart';
import '../widgets.dart';
import '../strings.dart';
import 'dreamboardgallery.dart';
import 'profile.dart';

class DreamboardDetails extends StatefulWidget {
  Function callback;
  String boardType;
  DreamBoardItem dreamBoardItem;
  DreamboardDetails(this.dreamBoardItem, this.boardType, this.callback);

  @override
  _dreamboardDetailsState createState() => new _dreamboardDetailsState();
}

class _dreamboardDetailsState extends State<DreamboardDetails> {

  Future<bool> _onWillPop() {
    this.widget.callback(DreamboardGallery(this.widget.boardType, this.widget.callback))
        ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold (
        appBar: new ReusableWidgets().getAppBar(context, this.widget.boardType, () => this.widget.callback(DreamboardGallery(this.widget.boardType, this.widget.callback))),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              height:400,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(this.widget.dreamBoardItem.image),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.srcOver),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: new Text ( this.widget.dreamBoardItem.content,
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        wordSpacing: 3,
                        letterSpacing: 2,
                        height: 1.5,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 5.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ],
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Align(
                    alignment: Alignment.centerLeft,
                    child: new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                          size: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Text('Anonymous',
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Align(
                      alignment: Alignment.centerRight,
                      child: Material(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(32.0),
                        child: new MaterialButton(
                          height: 5.0,
                          minWidth: 5.0,
                          textColor: Colors.white,
                          child: new Text (
                            "Connect",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 18
                            ),
                          ),
                          onPressed: () => {},
                          splashColor: Colors.greenAccent,
                        ),
                      )
                  )

                ],

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text('Tags:',
                      style: new TextStyle(
                          color: Colors.grey,
                          fontSize: 16
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:3.0),
                    child: Text('#cooking',
                      style: new TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 16
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:3.0),
                    child: Text('#climbing',
                      style: new TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 16
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:3.0),
                    child: Text('#running',
                      style: new TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 16
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

      ),
    );

  }

}