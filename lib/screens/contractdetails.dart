import 'package:flutter/material.dart';
import '../widgets.dart';
import 'mycrib.dart';
import '../strings.dart';
import 'contractdetailsform.dart';
import 'package:criber/services/contract_management.dart';
import 'package:intl/intl.dart';

class ContractDetails extends StatefulWidget {
  Function callback;
  ContractDetails(this.callback);

  @override
  _contractDetailsState createState() => new _contractDetailsState();
}

class _contractDetailsState extends State<ContractDetails> {
  final contractManagement = new ContractManagement();

  String contractNumber;
  DateTime startdate;
  DateTime enddate;
  String formattedstartdate;
  String formattedsenddate;
  Duration dateDiff;
  String dateRemaining;

  @override
  initState(){  
      super.initState();
      dateRemaining = "0";
      contractNumber = "0";
      formattedstartdate = "";
      formattedsenddate = "";

      // contract
      contractManagement.getContractData().then((result){
        setState(() {
              contractNumber = result.contractNumber;
              // parse string into datetime
              startdate = DateTime.parse(result.startDate);
              enddate = DateTime.parse(result.endDate);

              // calculate the day between end date and today's date
              dateDiff = enddate.difference(DateTime.now());
              dateRemaining = (dateDiff.inDays).toString();

              // format date into human readable date
              formattedstartdate = DateFormat('yyy MMMM d').format(startdate);
              formattedsenddate = DateFormat('yyy MMMM d').format(enddate);
        });
      });

  }
  
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
        appBar: new ReusableWidgets().getAppBar(context, Strings.contractDetails, () => this.widget.callback(MyCribMenu(this.widget.callback))),
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
                              "Your contract expires in",
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                              )
                          ),
                          new Text (
                              "${dateRemaining}",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 82,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          new Text (
                              "days",
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
                      padding: EdgeInsets.only(left:24, top:16, bottom:8),
                      child: new Align(
                        alignment: Alignment.centerLeft,
                        child: new Text (
                            "Contract Details:",
                            style: new TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold

                            )
                        ),
                      ),
                    ),
                    new Container(
                      alignment: Alignment.topLeft,
                      width: 380,
                      padding: new EdgeInsets.all(16.0),
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Align(
                            alignment: Alignment.topLeft,
                            child: new Text("Duration: ${contractNumber} months", style: Theme.of(context).textTheme.body2,),
                          ),
                          new Align(
                            alignment: Alignment.topLeft,
                            child: new Text("Starting Date: ${formattedstartdate}", style: Theme.of(context).textTheme.body2,),
                          ),
                          new Align(
                            alignment: Alignment.topLeft,
                            child: new Text("Ending Date: ${formattedsenddate}", style: Theme.of(context).textTheme.body2,),
                          ),
                        ],

                      ),
                      decoration: new BoxDecoration (
                          borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          color: Colors.white
                      ),
                    ),
                    new Expanded(
                      child: new Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: new Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.circular(32.0),
                            elevation: 2.0,
                            child: new MaterialButton(
                              height: 40.0,
                              minWidth: 380.0,
                              textColor: Colors.white,
                              child: new Text (
                                "Extend My Contract",
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () => this.widget.callback(ContractDetailsForm(this.widget.callback)),
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