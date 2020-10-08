import 'package:flutter/material.dart';
import '../widgets.dart';
import 'payment.dart';

class PaymentDetails extends StatefulWidget {
  Function callback;
  PaymentDetails(this.callback);

  @override
  _paymentDetailsState createState() => new _paymentDetailsState();
}

class _paymentDetailsState extends State<PaymentDetails> {

  Future<bool> _onWillPop() {
    this.widget.callback(Payment(this.widget.callback))
        ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold (
        backgroundColor: const Color(0x7FCEDDEF),
        appBar: new ReusableWidgets().getAppBar(context, 'Payment Details', () => this.widget.callback(Payment(this.widget.callback))),
        body: new Padding(
          padding: EdgeInsets.all(16),
          child: new Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Align(
                      alignment: Alignment.topLeft,
                      child: new Text(
                        "Date: 5 January 2018 1:15PM",
                        style: Theme.of(context)
                            .textTheme
                            .body1,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    new Align(
                      alignment: Alignment.topLeft,
                      child: new Text(
                        "Transaction ID: 00000021",
                        style: Theme.of(context)
                            .textTheme
                            .body1,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    new Align(
                      alignment: Alignment.topLeft,
                      child: new Text(
                        "Amount: RM4800",
                        style: Theme.of(context)
                            .textTheme
                            .body1,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    new Align(
                      alignment: Alignment.topLeft,
                      child: new Text(
                        "Details: 3 months deposit (RM2400)",
                        style: Theme.of(context)
                            .textTheme
                            .body1,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    new Center(
                      child: new IntrinsicWidth(
                          child: new Column(
                            children: <Widget>[
                              new Align(
                                alignment: Alignment.centerLeft,
                                child: new Text(
                                  "3 months rental",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1,
                                ),
                              ),
                              new Align(
                                alignment: Alignment.centerLeft,
                                child: new Text(
                                  "January 2018 (RM800)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1,
                                ),
                              ),
                              new Align(
                                alignment: Alignment.centerLeft,
                                child: new Text(
                                  "February 2018 (RM800)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1,
                                ),
                              ),
                              new Align(
                                alignment: Alignment.centerLeft,
                                child: new Text(
                                  "March 2018 (RM800)",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1,
                                ),
                              ),
                            ],
                          )
                      ),
                    ),

                  ],
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
                        "View Receipt",
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => {},
                      splashColor: Colors.greenAccent,
                    ),
                  ),
                ),
              ),
            ],
          )


        ),
      ),
    );

  }

}