// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Id _$IdFromJson(Map<String, dynamic> json) => Id(
      count: (json['count']).toDouble(),
      mean: (json['mean']).toDouble(),
      std: (json['std']).toDouble().roundToDouble(),
      min: (json['min']).toDouble(),
      twentyFive: (json['25%']).toDouble(),
      fifty: (json['50%']).toDouble(),
      seventyFive: (json['75%']).toDouble(),
      max: (json['max']).toDouble(),
    );

Map<String, dynamic> _$IdToJson(Id instance) => <String, dynamic>{
      'count': instance.count,
      'mean': instance.mean,
      'std': instance.std,
      'min': instance.min,
      'twentyFive': instance.twentyFive,
      'fifty': instance.fifty,
      'seventyFive': instance.seventyFive,
      'max': instance.max,
    };






//
// import 'dart:async';
// import 'dart:io';
// import 'dart:convert';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mush2/utils/colors.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter/widgets.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'dart:io' as io;
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:mush2/utils/colors.dart';
// import '../model/id.dart';
// import '../model/id.dart';
// import '../model/pdf.dart';
//
// class PdfApi {
//       static Future<io.File?> generateText(Pdf pdfi) async {
//             final datetime = DateFormat('MM-dd-yyyy KK:mm:ss a').format(DateTime.now());
//             final pdfs = pw.Document();
//
//             //final image = await imaegeFromAssestBundle('assets/image/png');
//             // document.pageSettings.margins.all = 50;
//             // pdfs.document.
//             // margin: const pw.EdgeInsets.only(top: 100),
//             pdfs.addPage(
//                 pw.Page(
//                       margin: pw.EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
//                       build: (pw.Context context) =>
//                           pw.Container(
//                                 margin: pw.EdgeInsets.zero,
//                                 padding: pw.EdgeInsets.all(15),
//                                 color:  PdfColors.grey,
//                                 child: pw.Column(
//                                     children: [
//                                           pw.SizedBox(height: 20),
//                                           pw.Container(
//                                                 // color: Color(Colors._redAccentValue),
//                                                 child: pw.Center(child: pw.Text("Mushroom Prediction", style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold))),
//                                           ),
//                                           pw.Text("Date generated: " + datetime.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//
//                                           pw.Container(
//                                                 color: PdfColors.grey,
//                                                 child: pw.Column(
//                                                       // mainAxisAlignment: pw.MainAxisAlignment.start,
//                                                       // crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                                       children: [
//                                                             pw.SizedBox(height: 30),
//                                                             pw.Text("Outcome: " + pdfi.prediction, style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Accuracy: " + pdfi.accuracy.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//
//                                                             pw.Row(
//                                                                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                                                                   children: [
//                                                                   ],
//                                                             ),
//                                                             pw.SizedBox(height: 40),
//                                                             pw.Text("Id Count: " + pdfi.id.count.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Id Mean: " + pdfi.id.mean.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Id STD: " + pdfi.id.std.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Id Min: " + pdfi.id.min.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Id 25%: " + pdfi.id.twentyFive.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Id 50%: " + pdfi.id.fifty.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Id 75%: " + pdfi.id.seventyFive.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Id Max: " + pdfi.id.max.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//
//                                                             pw.Text("BatchNumber Count: " + pdfi.batchNumber.count.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("BatchNumber Mean: " + pdfi.batchNumber.mean.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("BatchNumber STD: " + pdfi.batchNumber.std.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("BatchNumber Min: " + pdfi.batchNumber.min.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("BatchNumber 25%: " + pdfi.batchNumber.twentyFive.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("BatchNumber 50%: " + pdfi.batchNumber.fifty.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("BatchNumber 75%: " + pdfi.batchNumber.seventyFive.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("BatchNumber Max: " + pdfi.batchNumber.max.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//
//                                                             pw.Text("LightLevel Count: " + pdfi.lightLevel.count.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("LightLevel Mean: " + pdfi.lightLevel.mean.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("LightLevel STD: " + pdfi.lightLevel.std.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("LightLevel Min: " + pdfi.lightLevel.min.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("LightLevel 25%: " + pdfi.lightLevel.twentyFive.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("LightLevel 50%: " + pdfi.lightLevel.fifty.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("LightLevel 75%: " + pdfi.lightLevel.seventyFive.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("LightLevel Max: " + pdfi.lightLevel.max.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//
//                                                             pw.Text("RoomTemp Count: " + pdfi.roomTemp.count.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("RoomTemp Mean: " + pdfi.roomTemp.mean.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("RoomTemp STD: " + pdfi.roomTemp.std.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("RoomTemp Min: " + pdfi.roomTemp.min.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("RoomTemp 25%: " + pdfi.roomTemp.twentyFive.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("RoomTemp 50%: " + pdfi.roomTemp.fifty.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("RoomTemp 75%: " + pdfi.roomTemp.seventyFive.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("RoomTemp Max: " + pdfi.roomTemp.max.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//
//                                                             pw.Text("Humidity Count: " + pdfi.humidity.count.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Humidity Mean: " + pdfi.humidity.mean.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Humidity STD: " + pdfi.humidity.std.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Humidity Min: " + pdfi.humidity.min.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Humidity 25%: " + pdfi.humidity.twentyFive.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Humidity 50%: " + pdfi.humidity.fifty.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Humidity 75%: " + pdfi.humidity.seventyFive.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//                                                             pw.Text("Humidity Max: " + pdfi.humidity.max.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
//
//                                                             // pw.Text("Model's DataFrame " + pdfi.described, style: pw.TextStyle(fontSize: 15)),
//                                                       ],
//                                                 ),
//                                           ),
//                                     ]
//                                 ),
//                           ),
//
//                 ));
//
//             //print the document
//             await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfs.save());
//
//             //share the document to other apps
//             // await Printing.sharePdf(bytes: await pdfs.save(), filename: 'mydocument.pdf');
//
//             // save PDF with path_provider
//             final output = await getTemporaryDirectory();
//             print(output);
//             final f = io.File('${output.path}/mydocument.pdf');
//             print(f);
//             await f.writeAsBytes (await pdfs.save());
//             print("Done saving pdf");
//
//             // PdfDocument document = PdfDocument();
//
//             //Add a new page and draw text
//             // document.pages.add().graphics.drawString(
//             //     'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20),
//             //     // brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//             //     bounds: Rect.fromLTWH(0, 0, 500, 50));
//             //
//             // //Save the document
//             // List<int> bytes = await document.save();
//             //
//             // //Dispose the document
//             // document.dispose();
//
//       }
//
//       static Future<io.File?> pickFile() async{
//             final re = await FilePicker.platform.pickFiles(
//                   type: FileType.custom,
//                   allowedExtensions: ['pdf'],
//             );
//             if (re == null) return null;
//             return io.File(re.paths.first!);
//       }
//
//       static Future<io.File> saveDocument({
//             required String name,
//             required pw.Document pdfs
//       }) async {
//
//             String directory = (await getApplicationDocumentsDirectory()).path;
//             final pdfName = '$directory/recipet.pdf';
//             final io.File file = io.File(pdfName);
//             await file.writeAsBytes(await pdfs.save());
//
//             //
//             // final dir = await getApplicationDocumentsDirectory();
//             // // final path = dir.path;
//             // final file = File('${dir.path}/$name');
//             // await file.writeAsBytes(bytes);
//
//             print("Printing file: " + file.toString());
//
//             return file;
//
//
//
//             // final dirr = await getTemporaryDirectory();
//             // final pathh = "${dirr.path}/pdfname.pdf";
//             // final filee = await File(pathh).writeAsBytes( await pdfs.save());
//
//             // saveDocument(name: 'example.pdf', pdfs: pdfs);
//
//             // return filee;
//
//
//             // final bytes = await pdfs.save();
//             //
//             // final dir = await getApplicationDocumentsDirectory();
//             // // final path = dir.path;
//             // final file = File('${dir.path}/$name');
//             // await file.writeAsBytes(bytes);
//
//             // return filee;
//       }
//
//       static Future openFile(io.File file) async {
//             final String url = file.toString();
//             print("Trying to print url");
//             print(url);
//             await OpenFile.open(url);
//       }
// }
//
// //
// // final dir = await getApllicationDocumentsDirectory();
// // final file  File('${dir.path}/$name');
// // await file.writeAsBytes(bytes);
// //
// // return file;
// // }
// //
// // static Future openFile(File file) async{
// //   final url = file.path;
// //
// //   await OpenFile.open(url);
// // }
//