

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io' as io;


class PdfApi {
  static Future<io.File?> generateText(String text) async {
    final pdfs = pw.Document();

    //final image = await imaegeFromAssestBundle('assets/image/png');

    pdfs.addPage(
        pw.Page(
          build: (pw.Context context) =>
              pw.Center(
                child: pw.Text(text, style: pw.TextStyle(fontSize: 48)),
          ),
    ));

    //print the document
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfs.save());

    //share the document to other apps
    await Printing.sharePdf(bytes: await pdfs.save(), filename: 'nmydocument.pdf');

    //save PDF with path_provider
    // final output = await getTemporaryDirectory();
    // print(output);
    // final f = io.File('${output.path}/example.pdf');
    // print(f);
    // await f.writeAsBytes (await pdfs.save());
    // print("Done saving pdf");


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