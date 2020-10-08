import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets.dart';
import 'home.dart';
import '../strings.dart';
import 'contractdetails.dart';
import 'changeMyCribInfo.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'pdfviewer.dart';

class MyCribMenu extends StatefulWidget {
  Function callback;
  MyCribMenu(this.callback);

  @override
  _myCribMenuState createState() => new _myCribMenuState();
}

class _myCribMenuState extends State<MyCribMenu> {

  Future<bool> _onWillPop() {
    this.widget.callback(HomeMenu(this.widget.callback))
        ?? false;
  }

  Future<File> createFileOfPdfUrl() async {
    final url = 'https://mozilla.github.io/pdf.js/web/compressed.tracemonkey-pldi-09.pdf';
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for the major Material Components.
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold (
        appBar: new ReusableWidgets().getAppBar(context, Strings.myCrib, () => this.widget.callback(HomeMenu(this.widget.callback))),
        body:
        new Padding(
          padding: EdgeInsets.all(16),
          child: new Row (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children : <Widget> [
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new ReusableWidgets().getMenuButton(context,"contract.png", Strings.contractDetails, () => this.widget.callback(ContractDetails(this.widget.callback))),
                    new ReusableWidgets().getMenuButton(context,"changemycrib.png", Strings.changeMyCrib, () => this.widget.callback(ChangeMyCribInfo(this.widget.callback))),
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new ReusableWidgets().getMenuButton(context,"agreement.png", Strings.tenancyAgreement, () async {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Downloading...'),
                          duration: Duration(days: 24),
                        ),
                      );

                      await createFileOfPdfUrl().then((f) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PdfViewer(f.path)),
                        );
                      });

                      Scaffold.of(context).hideCurrentSnackBar();
                    }),
                  ],
                )
              ]
          ),
        ),
      ),
    );

  }

}