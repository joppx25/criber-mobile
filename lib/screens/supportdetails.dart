import 'package:flutter/material.dart';
import '../widgets.dart';
import 'support.dart';
import 'dart:convert';
import 'package:criber/services/support_management.dart';
import 'package:criber/models/support_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SupportDetails extends StatefulWidget {
  final Function callback;
  final String reportId;

  SupportDetails(this.callback, this.reportId);

  @override
  _supportDetailsState createState() => new _supportDetailsState();
}

class _supportDetailsState extends State<SupportDetails> {
  final SupportManagement _supportManagement = new SupportManagement();
  SupportItem supportTicket;
  List<SupportConvo> supportConvo = new List<SupportConvo>();
  List<SupportItemAttachments> supportItemAttachments = new List<SupportItemAttachments>();
  String convoLogs;

  Future<bool> _onWillPop() {
    this.widget.callback(Support(this.widget.callback)) ?? false;
  }

  Future<String> getTicketDetails() {
    return this._supportManagement.fetchTicketDetails(widget.reportId);
  }

  Future<String> getTicketConvo() {
    return this._supportManagement.fetchTicketConversations(widget.reportId);
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
            backgroundColor: const Color(0x7FCEDDEF),
            appBar: new ReusableWidgets().getAppBar(context, 'Report Details', () => this.widget.callback(Support(this.widget.callback))),
            body: new FutureBuilder(
                future: Future.wait([getTicketDetails(), getTicketConvo()]).then((response) => new SupportDetailWithConvo(detail: response[0], convo: response[1])),
                builder: (BuildContext context, AsyncSnapshot<SupportDetailWithConvo> snapshot) {
                  if (snapshot.hasData) {
                    final detailResult = json.decode(snapshot.data.detail);
                    final convoResult = json.decode(snapshot.data.convo);
                    supportTicket = new SupportItem.fromJson(detailResult);
                    supportConvo = this._supportManagement.formatSupportConvoJsonData(convoResult);
                    convoLogs = supportConvo.map((convo) {
                      return convo.date + " - " + convo.bodyText;
                    }).join("\n");

                    if (supportTicket.attachments != null) {
                      supportItemAttachments = this._supportManagement.formatSupportItemAttachmentsJsonData(supportTicket.attachments);
                    }
                  }

                  return snapshot.hasData
                      ? new Padding(
                          padding: EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: new Column(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Align(
                                  alignment: Alignment.topLeft,
                                  child: new Text(
                                    "Date: " + supportTicket.date,
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                new Align(
                                  alignment: Alignment.topLeft,
                                  child: new Text(
                                    "Report ID: " + supportTicket.reportId,
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                new Align(
                                  alignment: Alignment.topLeft,
                                  child: new Text(
                                    "Location: " + supportTicket.location,
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                new Align(
                                  alignment: Alignment.topLeft,
                                  child: new Text(
                                    "Status: " + supportTicket.statusText,
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                new Align(
                                  alignment: Alignment.topLeft,
                                  child: new Text(
                                    "Remarks: " + supportTicket.details,
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                new Align(
                                  alignment: Alignment.topLeft,
                                  child: new Text(
                                    "Progress Updates:",
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ),
                                new Align(
                                  alignment: Alignment.topLeft,
                                  child: new Text(
                                    convoLogs,
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                new Align(
                                  alignment: Alignment.topLeft,
                                  child: new Text(
                                    "Attachments:",
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                new Align(
                                  child: supportItemAttachments.isEmpty ? new Container(height: 0.0, width: 0.0) : getImages(supportItemAttachments),
                                ),
                                SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        )
                      : new Center(child: new CircularProgressIndicator());
                }
            )
        )
    );
  }
}

Widget getImages(List<SupportItemAttachments> images)
{
  return new Column(
    children: images.map((item) => new CachedNetworkImage(
      imageUrl: item.attachmentUrl,
      placeholder: new CircularProgressIndicator(),
      errorWidget: new Icon(Icons.error),
    )).toList()
  );
}