import 'package:flutter/material.dart';
import '../widgets.dart';
import 'contractdetails.dart';
import '../strings.dart';
import 'package:intl/intl.dart';
import 'package:criber/services/contract_management.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:criber/auth.dart';

class ContractDetailsForm extends StatefulWidget {
  Function callback;
  ContractDetailsForm(this.callback);

  @override
  _contractDetailsFormState createState() => new _contractDetailsFormState();
}

class _contractDetailsFormState extends State<ContractDetailsForm> {
  final contractManagement = new ContractManagement();

  String contractNumber;
  String formattedstartdate;
  String formattedsenddate;
  String formattedAddedDate;
  String resStartDate;
  String dateRemaining;

  DateTime dateFromNow;
  DateTime startdate;
  DateTime enddate;
  Duration dateDiff;

  var today = new DateTime.now();

  @override
  initState(){
    super.initState();
    dateRemaining = "0";
    contractNumber = "Loading...";
    formattedstartdate = "Loading...";
    formattedsenddate = "Loading...";
    formattedAddedDate = "Loading...";
    dateRemaining = "Loading...";

    // contract
    contractManagement.getContractData().then((result){
      setState(() {
        contractNumber = result.contractNumber;
        resStartDate = result.startDate;
        // parse string into datetime
        startdate = DateTime.parse(result.startDate);
        enddate = DateTime.parse(result.endDate);

        // detault 3 months
        dateFromNow = enddate.add(new Duration(days: 91));

        // calculate the day between end date and today's date
        dateDiff = dateFromNow.difference(today);
        dateRemaining = (dateDiff.inDays).toString();

        formattedAddedDate = DateFormat('yyy MMMM d').format(dateFromNow);

        // format date into human readable date
        formattedstartdate = DateFormat('yyy MMMM d').format(startdate);
        formattedsenddate = DateFormat('yyy MMMM d').format(enddate);
      });
    });

  }

  // state variable
  int _result = 0;
  int _radioValue = -1;
  int months = 3;
  String originalDate = "";

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      if (enddate != null)
        switch (_radioValue) {
          case 0:
            _result = 91; // 3 months
            months = 3;
            dateFromNow = enddate.add(new Duration(days: _result));

            // calculate the day between end date and today's date
            dateDiff = dateFromNow.difference(today);
            dateRemaining = (dateDiff.inDays).toString();
            formattedAddedDate = DateFormat('yyy MMMM d').format(dateFromNow);
            originalDate = new DateFormat('yyyy-MM-dd').format(dateFromNow);
            break;
          case 1:
            _result = 183; // 6 months
            months = 6;
            dateFromNow = enddate.add(new Duration(days: _result));

            // calculate the day between end date and today's date
            dateDiff = dateFromNow.difference(today);
            dateRemaining = (dateDiff.inDays).toString();
            formattedAddedDate = DateFormat('yyy MMMM d').format(dateFromNow);
            originalDate = new DateFormat('yyyy-MM-dd').format(dateFromNow);

            break;
          case 2:
            _result = 274; // 9 months
            months = 9;
            dateFromNow = enddate.add(new Duration(days: _result));

            // calculate the day between end date and today's date
            dateDiff = dateFromNow.difference(today);
            dateRemaining = (dateDiff.inDays).toString();
            formattedAddedDate = DateFormat('yyy MMMM d').format(dateFromNow);
            originalDate = new DateFormat('yyyy-MM-dd').format(dateFromNow);
            break;
          case 3:
            _result = 365; // 1 year
            months = 12;
            dateFromNow = enddate.add(new Duration(days: _result));

            // calculate the day between end date and today's date
            dateDiff = dateFromNow.difference(today);
            dateRemaining = (dateDiff.inDays).toString();
            formattedAddedDate = DateFormat('yyy MMMM d').format(dateFromNow);
            originalDate = new DateFormat('yyyy-MM-dd').format(dateFromNow);
            break;
        }

    });
  }

  // create contract record
  final auth = new Auth();

  void createRecord() async {
    FirebaseUser authUser = await auth.getCurrentUser();

    // here you write the codes to input the data into firestore
    final contractDatabaseReference = FirebaseDatabase.instance.reference().child("contract");

    contractDatabaseReference.child("user").child(authUser.uid).set({
      'amount': '120', // no source of payment yet
      'contract_number':  int.tryParse(contractNumber) + months,
      'end_date': originalDate,
      'start_date': resStartDate,
    });
  }

  Future<bool> _onWillPop() {
    this.widget.callback(ContractDetails(this.widget.callback))
        ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold (
        resizeToAvoidBottomPadding: false,
        appBar: new ReusableWidgets().getAppBar(context, Strings.contractDetails, () => this.widget.callback(ContractDetails(this.widget.callback))),
        body: new Center(
          child: new Padding (
              padding: EdgeInsets.only(top: 16, left:16, right:16),
              child: new Container(
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Align(
                      alignment: Alignment.topLeft,
                      child: new Text("I would like to extend my stay for:", style: Theme.of(context).textTheme.body1,),
                    ),
                    new Align(
                      alignment: Alignment.topLeft,
                      child: new Row(
                        children: <Widget>[
                          new Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text("3 months", style: Theme.of(context).textTheme.body1,),
                        ],
                      ),
                    ),
                    new Align(
                      alignment: Alignment.topLeft,
                      child: new Row(
                        children: <Widget>[
                          new Radio(
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text("6 months", style: Theme.of(context).textTheme.body1,),
                        ],
                      ),
                    ),
                    new Align(
                      alignment: Alignment.topLeft,
                      child: new Row(
                        children: <Widget>[
                          new Radio(
                            value: 2,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text("9 months", style: Theme.of(context).textTheme.body1,),
                        ],
                      ),
                    ),
                    new Align(
                      alignment: Alignment.topLeft,
                      child: new Row(
                        children: <Widget>[
                          new Radio(
                            value: 3,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text("12 months", style: Theme.of(context).textTheme.body1,),
                        ],
                      ),
                    ),
                    new Container(
                      alignment: Alignment.topLeft,
                      width: 380,
                      padding: new EdgeInsets.all(6.0),
                      child: new Center(
                        child: new Text("This will extend your stay to ${formattedAddedDate} (${dateRemaining} days)", style: Theme.of(context).textTheme.body1,),
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
                              onPressed: () {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(

                                    content: Text('Contract extended successfully!'),
                                    duration: Duration(milliseconds: 2000),
                                  ),
                                );

                                createRecord();
                              },
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