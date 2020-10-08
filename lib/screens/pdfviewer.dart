import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import '../widgets.dart';
import '../strings.dart';

class PdfViewer extends StatelessWidget {
  String pathPDF = "";
  PdfViewer(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: new ReusableWidgets().getAppBar(context, Strings.tenancyAgreement, () => Navigator.pop(context)),
        path: pathPDF);
  }
}