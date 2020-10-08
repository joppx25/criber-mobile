import 'dart:convert';
import 'package:flutter/material.dart';
import '../strings.dart';
import 'home.dart';
import 'package:criber/models/support_item.dart';
import 'package:criber/services/support_management.dart';
import 'supportform.dart';
import 'supportdetails.dart';

class Support extends StatefulWidget {
  final Function callback;

  Support(this.callback);

  @override
  _supportState createState() => new _supportState();
}

class _supportState extends State<Support> {
  final SupportManagement _supportManagement = new SupportManagement();
  List<SupportItem> ongoingTickets = new List<SupportItem>();
  List<SupportItem> resolvedTickets = new List<SupportItem>();

  Future<bool> _onWillPop() {
    this.widget.callback(HomeMenu(this.widget.callback)) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: MaterialApp(
            theme: new ThemeData(brightness: Brightness.light, primaryColor: Theme.of(context).primaryColor),
            home: DefaultTabController(
                length: 2,
                child: Scaffold(
                  resizeToAvoidBottomPadding: false,
                  backgroundColor: const Color(0x7FCEDDEF),
                  appBar: AppBar(
                    leading: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => this.widget.callback(HomeMenu(this.widget.callback)),
                      ),
                    ),
                    title: Text(Strings.support,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 26
                        )
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add),
                        iconSize: 35,
                        onPressed: () => this.widget.callback(SupportForm(this.widget.callback)),
                      ),
                    ],
                    bottom: new PreferredSize(
                        child: new Material(
                          color: Colors.white,
                          child: TabBar(
                            indicatorColor: Theme.of(context).primaryColor,
                            labelColor: Theme.of(context).primaryColor,
                            labelStyle: new TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            tabs: [
                              Tab(text: "Ongoing",),
                              Tab(text: "Resolved",),
                            ],
                          ),
                        ),
                        preferredSize: new Size(double.infinity, kToolbarHeight)),
                  ),
                  body: FutureBuilder(
                      future: this._supportManagement.fetchTickets(),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          List<dynamic> result = json.decode(snapshot.data);
                          List<SupportItem> supportTickets = this._supportManagement.formatSupportItemJsonData(result);
                          ongoingTickets = supportTickets.where((data) => data.status == 2 || data.status == 3).toList();
                          resolvedTickets = supportTickets.where((data) => data.status == 4 || data.status == 5).toList();
                        }

                        return snapshot.hasData
                            ? TabBarView(
                          children: [
                            getList(ongoingTickets, "Ongoing"),
                            getList(resolvedTickets, "Resolved"),
                          ],
                        )
                            : new Center(child: new CircularProgressIndicator());
                      }
                  ),
                )
            )
        )
    );
  }

  getList(List<SupportItem> items, String tabName) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build
      itemCount: items.length,
      // Provide a builder function. This is where the magic happens! We'll
      // convert each item into a Widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];
        return new GestureDetector(
          onTap: () => this.widget.callback(SupportDetails(this.widget.callback, item.reportId)),
          child: new Padding(
            padding: new EdgeInsets.only(top:10, left:10, right:10),
            child: new Container(
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Colors.white
                ),
                alignment: Alignment.topLeft,
                width: 380,
                padding: new EdgeInsets.all(6.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Align(
                        alignment: FractionalOffset.centerLeft,
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Align(
                              alignment: Alignment.centerLeft,
                              child: new Text(
                                item.date,
                                style: new TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            new Align(
                              alignment: Alignment.centerLeft,
                              child: new Text(
                                "Report ID: " + item.reportId,
                                style: new TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            new Align(
                              alignment: Alignment.centerLeft,
                              child: new Text(
                                "Details: " + item.location,
                                style: new TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Expanded(
                      child: new Align(
                        alignment: FractionalOffset.centerRight,
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Align(
                              alignment: Alignment.centerRight,
                              child: new Text(
                                "Status: ",
                                textAlign: TextAlign.right,
                                style: new TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            new Align(
                              alignment: Alignment.centerRight,
                              child: new Text(
                                item.statusText,
                                textAlign: TextAlign.right,
                                style: new TextStyle(
                                  fontSize: 17,
                                  color: tabName == "Ongoing"
                                      ? Colors.orange
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
            ),
          ),
        );
      },
    );
  }
}