import 'package:flutter/material.dart';
import '../widgets.dart';
import 'home.dart';
import '../strings.dart';
import 'paymentdetails.dart';

class Payment extends StatefulWidget {
  Function callback;
  Payment(this.callback);

  @override
  _paymentState createState() => new _paymentState();
}

class _paymentState extends State<Payment> {

  Future<bool> _onWillPop() {
    this.widget.callback(HomeMenu(this.widget.callback))
        ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold (
        appBar: new ReusableWidgets().getAppBar(context, Strings.payment, () => this.widget.callback(HomeMenu(this.widget.callback))),
        body: new Center(
          child: new Padding (
              padding: EdgeInsets.only(top: 16),
              child: new Container(
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      width: 380,
                      padding: new EdgeInsets.all(16.0),
                      child: new Column(
                        children: <Widget>[
                          new Text (
                              "Outstanding Payment",
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                              )
                          ),
                          new Text (
                              "RM800",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 82,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          new Text (
                              "Due Date: 8 April 2019",
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                              )
                          ),
                        ],

                      ),
                      decoration: new BoxDecoration (
                          borderRadius: new BorderRadius.all(new Radius.circular(40.0)),
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                    new Padding(
                      padding: EdgeInsets.only(top:12, left:16, right:16),
                      child: new Center(
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            new Container(
                              width: 170,
                              padding: new EdgeInsets.all(16.0),
                              child: new Align(
                                alignment: Alignment.center,
                                child: new Text (
                                  "Pay via\n"
                                      "Debit/Credit Card",
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              decoration: new BoxDecoration (
                                  borderRadius: new BorderRadius.all(new Radius.circular(40.0)),
                                  color: Theme.of(context).primaryColor
                              ),
                            ),
                            new Container(
                              width: 170,
                              padding: new EdgeInsets.all(16.0),
                              child: new Align(
                                alignment: Alignment.center,
                                child: new Text (
                                  "Pay via\n"
                                      "Bank Transfer",
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              decoration: new BoxDecoration (
                                  borderRadius: new BorderRadius.all(new Radius.circular(40.0)),
                                  color: Theme.of(context).primaryColor
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Padding(
                        padding: EdgeInsets.only(top:26, bottom: 16, left:24, right:24),
                        child: new Align(
                          alignment: Alignment.topLeft,
                          child: new Text("Payment History", style: Theme.of(context).textTheme.body1,),
                        )
                    ),
                    new Padding(
                        padding: new EdgeInsets.only(left:16, right:16),
                        child: new GestureDetector(
                          onTap: () => this.widget.callback(PaymentDetails(this.widget.callback)), // @TODO: Call fetchTicketDetails(ticket id) and then display the full ticket info in details page
                          child: new Container(
                            decoration: new BoxDecoration (
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
                                          child: new Text("January 2018", style: new TextStyle(fontSize: 17,),
                                          ),
                                        ),
                                        new Align(
                                          alignment: Alignment.centerLeft,
                                          child: new Text("Transaction ID: 000012", style: new TextStyle(fontSize: 14,),
                                          ),
                                        ),
                                        new Align(
                                          alignment: Alignment.centerLeft,
                                          child: new Text("Details: Deposit + 3 Months Rental", style: new TextStyle(fontSize: 14,),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                new Expanded(
                                  child: new Align(
                                    alignment: FractionalOffset.centerRight,
                                    child: new Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: new Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          new Align(
                                            alignment: Alignment.centerRight,
                                            child: new Text("RM4800", style: new TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          new Align(
                                            alignment: Alignment.centerRight,
                                            child: new Text("1 January 2018", style: new TextStyle(fontSize: 17,),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
    );

  }

}