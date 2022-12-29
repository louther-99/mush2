import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mush2/home.dart';
import 'package:mush2/profile.dart';
import 'package:mush2/utils/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie/lottie.dart';
// import 'package:pdfx/pdfx.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:printing/printing.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'api/pdf_api.dart';

import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io' as io;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:mush2/utils/colors.dart';

class PDFViewerPage extends StatefulWidget {
  final io.File file;
  const PDFViewerPage({Key? key, required this.file}) : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  @override
  Widget build(BuildContext context) {
    final name = (widget.file.path);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
        ),
      ),
      body: PDFView(
        filePath: widget.file.path,
      ),
    );
  }
}
