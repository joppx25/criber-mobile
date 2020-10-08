import 'package:flutter/material.dart';
import '../widgets.dart';
import '../homebar.dart';

class Announcements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new Scaffold (
        resizeToAvoidBottomPadding: false,
        appBar: new PreferredSize(child: new HomeBar("Announcements", false, () => {}), preferredSize: new Size(double.infinity, kToolbarHeight)),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Image.asset('assets/images/dream02.jpeg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,),
              title: Text('Lorem ipsum dolor sit amet, cursus vestibulum sit diam adipiscing', style: new TextStyle(
                  fontSize: 16
              )),
              contentPadding: EdgeInsets.all(8.0),
              subtitle: Text('8 hours ago', style: new TextStyle(
                  fontSize: 14
              )
              ),
            ),
            ListTile(
              leading: Image.asset('assets/images/dream08.jpeg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,),
              title: Text('Lorem ipsum dolor sit amet, cursus vestibulum sit diam adipiscing', style: new TextStyle(
                  fontSize: 16
              )),
              contentPadding: EdgeInsets.all(8.0),
              subtitle: Text('28 February 2019', style: new TextStyle(
                  fontSize: 14
              )
              ),
            ),
            ListTile(
              leading: Image.asset('assets/images/dream06.jpeg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,),
              title: Text('Lorem ipsum dolor sit amet, cursus vestibulum sit diam adipiscing', style: new TextStyle(
                  fontSize: 16
              )),
              contentPadding: EdgeInsets.all(8.0),
              subtitle: Text('16 February 2019', style: new TextStyle(
                  fontSize: 14
              )
              ),
            ),
            ListTile(
              leading: Image.asset('assets/images/dream12.jpeg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,),
              title: Text('Lorem ipsum dolor sit amet, cursus vestibulum sit diam adipiscing', style: new TextStyle(
                  fontSize: 16
              )),
              contentPadding: EdgeInsets.all(8.0),
              subtitle: Text('31 January 2019', style: new TextStyle(
                  fontSize: 14
              )
              ),
            ),
            ListTile(
              leading: Image.asset('assets/images/dream16.jpeg',
                width: 50,
                height: 50,
                fit: BoxFit.cover,),
              title: Text('Lorem ipsum dolor sit amet, cursus vestibulum sit diam adipiscing', style: new TextStyle(
                  fontSize: 16
              )),
              contentPadding: EdgeInsets.all(8.0),
              subtitle: Text('15 December 2018', style: new TextStyle(
                  fontSize: 14
              )
              ),
            ),
          ],
        )
    );

  }

}