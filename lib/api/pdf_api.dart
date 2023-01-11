
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mush2/utils/colors.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io' as io;
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:mush2/utils/colors.dart';
import '../model/pdf.dart';

class PdfApi {
  static Future<io.File?> generateText(Pdf pdfi) async {
    final datetime = DateFormat('MM-dd-yyyy KK:mm:ss a').format(DateTime.now());
    final pdfs = pw.Document();

    //final image = await imaegeFromAssestBundle('assets/image/png');
    // document.pageSettings.margins.all = 50;
    // pdfs.document.
    // margin: const pw.EdgeInsets.only(top: 100),
    pdfs.addPage(
        pw.Page(
          margin: pw.EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
          build: (pw.Context context) =>
              pw.Container(
                margin: pw.EdgeInsets.zero,
                padding: pw.EdgeInsets.all(15),
                color:  PdfColors.grey,
                child: pw.Column(
                    children: [
                      pw.SizedBox(height: 20),
                      pw.Container(
                        // color: Color(Colors._redAccentValue),
                        child: pw.Center(child: pw.Text("Mushroom Prediction", style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold))),
                      ),
                      pw.Text("Date generated: " + datetime.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),

                      pw.Container(
                        color: PdfColors.grey,
                        child: pw.Column(
                          // mainAxisAlignment: pw.MainAxisAlignment.start,
                          // crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 30),
                            pw.Text("Outcome: " + pdfi.prediction, style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
                            pw.Text("Accuracy: " + pdfi.accuracy.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),

                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                             ],
                            ),
                            pw.SizedBox(height: 40),
                            // pw.Text("Model's DataFrame " + pdfi.described, style: pw.TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ]
                ),
              ),

    ));

    //print the document
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfs.save());

    //share the document to other apps
    // await Printing.sharePdf(bytes: await pdfs.save(), filename: 'mydocument.pdf');

    // save PDF with path_provider
    final output = await getTemporaryDirectory();
    print(output);
    final f = io.File('${output.path}/mydocument.pdf');
    print(f);
    await f.writeAsBytes (await pdfs.save());
    print("Done saving pdf");

    // PdfDocument document = PdfDocument();

    //Add a new page and draw text
    // document.pages.add().graphics.drawString(
    //     'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20),
    //     // brush: PdfSolidBrush(PdfColor(0, 0, 0)),
    //     bounds: Rect.fromLTWH(0, 0, 500, 50));
    //
    // //Save the document
    // List<int> bytes = await document.save();
    //
    // //Dispose the document
    // document.dispose();

  }

  static Future<io.File?> pickFile() async{
    final re = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (re == null) return null;
    return io.File(re.paths.first!);
  }

  static Future<io.File> saveDocument({
    required String name,
    required pw.Document pdfs
      }) async {

    String directory = (await getApplicationDocumentsDirectory()).path;
    final pdfName = '$directory/recipet.pdf';
    final io.File file = io.File(pdfName);
    await file.writeAsBytes(await pdfs.save());

    //
    // final dir = await getApplicationDocumentsDirectory();
    // // final path = dir.path;
    // final file = File('${dir.path}/$name');
    // await file.writeAsBytes(bytes);

    print("Printing file: " + file.toString());

    return file;



    // final dirr = await getTemporaryDirectory();
    // final pathh = "${dirr.path}/pdfname.pdf";
    // final filee = await File(pathh).writeAsBytes( await pdfs.save());

    // saveDocument(name: 'example.pdf', pdfs: pdfs);

    // return filee;


    // final bytes = await pdfs.save();
    //
    // final dir = await getApplicationDocumentsDirectory();
    // // final path = dir.path;
    // final file = File('${dir.path}/$name');
    // await file.writeAsBytes(bytes);

    // return filee;
  }

  static Future openFile(io.File file) async {
    final String url = file.toString();
    print("Trying to print url");
    print(url);
    await OpenFile.open(url);
  }
}

//
// final dir = await getApllicationDocumentsDirectory();
// final file  File('${dir.path}/$name');
// await file.writeAsBytes(bytes);
//
// return file;
// }
//
// static Future openFile(File file) async{
//   final url = file.path;
//
//   await OpenFile.open(url);
// }