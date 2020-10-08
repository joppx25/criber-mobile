import 'package:flutter/material.dart';
import '../widgets.dart';
import 'dreamboard.dart';
import 'dreamboarddetails.dart';

class DreamboardGallery extends StatefulWidget {
  Function callback;
  String boardType;
  DreamboardGallery(this.boardType, this.callback);

  @override
  _dreamboardGalleryState createState() => new _dreamboardGalleryState();
}

class _dreamboardGalleryState extends State<DreamboardGallery> {

  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  Widget appBarTitle;
  List<DreamBoardItem> _list;

  bool _IsSearching;
  String _searchText = "";
  final TextEditingController _searchQuery = new TextEditingController();

  _dreamboardGalleryState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }


  @override
  void initState() {
    appBarTitle = new Text(widget.boardType,
        style: new TextStyle(
            color: Colors.white,
            fontSize: 26
        )
    );
    _IsSearching = false;
    init();
  }

  void init() {
    _list = List<DreamBoardItem>.generate(
      30,
          (i) => DreamBoardItem.random(),
    );
  }

  Future<bool> _onWillPop() {
    this.widget.callback(DreamboardMenu(this.widget.callback))
        ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold (
        appBar: getAppBar(context, widget.boardType, () => this.widget.callback(DreamboardMenu(this.widget.callback))),
        body: new Center(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(1.0),
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            crossAxisCount: 3,
            children: List.generate(_buildSearchList().length, (index) {
              return new ReusableWidgets().getDreamboardThumbnailLayout(_buildSearchList()[index], () => this.widget.callback(DreamboardDetails(_buildSearchList()[index], this.widget.boardType, this.widget.callback)));
            }),
          ),
        ),

      ),
    );

  }

  Widget getAppBar(BuildContext context, String title, VoidCallback onBackPressed) {
    return new AppBar(
        leading: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: onBackPressed,
          ),
        ),
        titleSpacing: 0.0,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = new TextField(
                  controller: _searchQuery,
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 26
                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
        ]
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text(widget.boardType,
          style: new TextStyle(
              color: Colors.white,
              fontSize: 26
          )
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  List<DreamBoardItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list;
    }
    else {
      List<DreamBoardItem> _searchList = List();
      for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i).content;
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(_list.elementAt(i));
        }
      }
      return _searchList;
    }
  }

}