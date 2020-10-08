import 'package:flutter/material.dart';
import 'home.dart';
import 'dreamboard.dart';
import 'announcements.dart';

class Landing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingState();
  }
}


class _LandingState extends State<Landing> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  getContent() {
    switch (_currentIndex) {
      case 0:
        return new Home();
        break;

      case 1:
        return new Dreamboard();
        break;

      case 2:
        return new Announcements();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new Scaffold (
      resizeToAvoidBottomPadding: false,
      body: getContent(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.cloud),
            title: new Text('Dreamboard'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.announcement),
              title: Text('Announcements')
          )
        ],
      ),
    );

  }

}

