import 'dart:math';
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
import '../model/id.dart';
import '../model/id.dart';
import '../model/pdf.dart';
import '../model/pdf2.dart';

class PdfApi2 {
  static Future<io.File?> generateText(Pdf2 pdfi) async {

    final datetime = DateFormat('MM-dd-yyyy KK:mm:ss a').format(DateTime.now());
    final pdfs = pw.Document();

    final lightMean = pdfi.lightLevel.mean.round();
    final tempMean  = pdfi.roomTemp.mean.round();
    final humidMean = pdfi.humidity.mean.round();

    bool lightPassed = false;
    bool tempPassed = false;
    bool humidPassed = false;
    bool lightRecommend = false;
    bool tempRecommend  = false;
    bool humidRecommend  = false;

    String lightPassedString = "";
    String tempPassedString = "";
    String humidPassedString = "";

    if(lightMean >= 50 && lightMean <= 100){
      lightPassed = true;
      lightPassedString = "within the threshold value.";
    }
    else{
      lightPassedString = "outside the threshold value.";
      lightRecommend = true;
    }
    if(tempMean >= 22 && tempMean <= 30){
      tempPassed = true;
      tempPassedString = "within the threshold value.";

    }
    else{
      tempPassedString = "outside the threshold value.";
      tempRecommend = true;
    }
    if(humidMean >= 70 && humidMean <= 85){
      humidPassed = true;
      humidPassedString = "within the threshold value.";
    }
    else{
      humidPassedString = "outside the threshold value.";
      humidRecommend = true;
    }





    //final image = await imaegeFromAssestBundle('assets/image/png');
    // document.pageSettings.margins.all = 50;
    // pdfs.document.
    // margin: const pw.EdgeInsets.only(top: 100),
    pdfs.addPage(
      pw.MultiPage(
        margin: pw.EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
        build: (pw.Context context) =>
        <pw.Widget>[
          pw.Header(
              padding: pw.EdgeInsets.all(10),
              margin: pw.EdgeInsets.all(0),
              decoration: pw.BoxDecoration(color: PdfColors.orange100),
              child: pw.Column(
                children: [
                  pw.Container(
                    // color: Color(Colors._redAccentValue),
                    child: pw.Center(child: pw.Text("Mushroom Prediction", style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold))),
                  ),
                  pw.Text("Date generated: " + datetime.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),

                ],
              )
          ),
          // buildTable(pdfi),
          pw.Column(
            children: [
              pw.Container(
                margin: pw.EdgeInsets.zero,
                padding: pw.EdgeInsets.all(5),
                color:  PdfColors.orange300,
                child: pw.Column(
                    children: [
                      // pw.SizedBox(height: 20),
                      pw.Container(
                        color: PdfColors.orange100,
                        child: pw.Column(
                          // mainAxisAlignment: pw.MainAxisAlignment.start,
                          // crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.SizedBox(height: 10),
                            pw.Text("Outcome: " + pdfi.prediction, style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
                            pw.Text("Accuracy: " + pdfi.accuracy.toString(), style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),

                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                              ],
                            ),
                            pw.SizedBox(height: 10),



                            pw.Table(
                              border: pw.TableBorder.all(color: PdfColors.orange400, width: 1.5),
                              columnWidths: const {
                                0: pw.FlexColumnWidth(1.5),
                                1: pw.FlexColumnWidth(2),
                                2: pw.FlexColumnWidth(2),
                                3: pw.FlexColumnWidth(2),
                                4: pw.FlexColumnWidth(2),
                                5: pw.FlexColumnWidth(2),
                              },
                              children: [
                                pw.TableRow( children: [
                                  pw.Text("", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0, fontWeight: pw.FontWeight.bold, color: PdfColors.black,),),
                                  pw.Text("ID", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0, fontWeight: pw.FontWeight.bold, color: PdfColors.black,),),
                                  pw.Text("Batch Number", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0, fontWeight: pw.FontWeight.bold, color: PdfColors.black),),
                                  pw.Text("Light Level", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0, fontWeight: pw.FontWeight.bold, color: PdfColors.black),),
                                  pw.Text("Room Temp", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0, fontWeight: pw.FontWeight.bold, color: PdfColors.black),),
                                  pw.Text("Humidity", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0, fontWeight: pw.FontWeight.bold, color: PdfColors.black),),
                                ]),
                                pw.TableRow(children: [
                                  pw.Text("Count", textAlign: pw.TextAlign.center ,style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text( pdfi.id.count.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text( pdfi.batchNumber.count.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text( pdfi.lightLevel.count.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text( pdfi.roomTemp.count.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text( pdfi.humidity.count.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),

                                ]),
                                pw.TableRow(children: [
                                  pw.Text("Mean", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.id.mean.round().toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.batchNumber.mean.round().toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.lightLevel.mean.round().toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.roomTemp.mean.round().toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.humidity.mean.round().toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),

                                ]),
                                pw.TableRow(children: [
                                  pw.Text("STD", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.id.std.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.batchNumber.std.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.lightLevel.std.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.roomTemp.std.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.humidity.std.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),

                                ]),
                                pw.TableRow(children: [
                                  pw.Text("Min", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.id.min.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.batchNumber.min.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.lightLevel.min.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.roomTemp.min.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.humidity.min.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),

                                ]),
                                pw.TableRow(children: [
                                  pw.Text("Max", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.id.max.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.batchNumber.max.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.lightLevel.max.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.roomTemp.max.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.humidity.max.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),

                                ]),
                                pw.TableRow(children: [
                                  pw.Text("25%", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.id.twentyFive.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.batchNumber.twentyFive.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.lightLevel.twentyFive.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.roomTemp.twentyFive.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.humidity.twentyFive.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),

                                ]),
                                pw.TableRow(children: [
                                  pw.Text("50%", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.id.fifty.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.batchNumber.fifty.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.lightLevel.fifty.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.roomTemp.fifty.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.humidity.fifty.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),

                                ]),
                                pw.TableRow(children: [
                                  pw.Text("75%", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.id.seventyFive.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.batchNumber.seventyFive.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.lightLevel.seventyFive.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.roomTemp.seventyFive.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.humidity.seventyFive.toString(), textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0),),

                                ]),

                              ],
                            ),


                            pw.SizedBox(height: 20),
                            pw.Text("Confusion Matrix", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),

                            pw.Table(
                              border: pw.TableBorder.all(color: PdfColors.orange400, width: 1.5),
                              columnWidths: const {
                                0: pw.FlexColumnWidth(2),
                                1: pw.FlexColumnWidth(2),
                                2: pw.FlexColumnWidth(2),

                              },
                              children: [
                                pw.TableRow( children: [
                                  // pw.Text("N = " + (pdfi.yes + pdfi.no).toString() , textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0, fontWeight: pw.FontWeight.bold, color: PdfColors.black,),),
                                  pw.Text("Predicted - ", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0, fontWeight: pw.FontWeight.bold, color: PdfColors.black,),),
                                  pw.Text("Predicted + ", textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 15.0, fontWeight: pw.FontWeight.bold, color: PdfColors.black),),
                                ]),
                                pw.TableRow(children: [
                                  pw.Text("Actual - ", textAlign: pw.TextAlign.center ,style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.trueNegative.toString(), textAlign: pw.TextAlign.center ,style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.falsePositive.toString(), textAlign: pw.TextAlign.center ,style: pw.TextStyle(fontSize: 15.0),),

                                ]),
                                pw.TableRow(children: [
                                  pw.Text("Actual + ", textAlign: pw.TextAlign.center ,style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.falseNegative.toString(), textAlign: pw.TextAlign.center ,style: pw.TextStyle(fontSize: 15.0),),
                                  pw.Text(pdfi.truePositive.toString(), textAlign: pw.TextAlign.center ,style: pw.TextStyle(fontSize: 15.0),),

                                ]),


                              ],
                            ),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(height: 20),
                                pw.Text("Interpretation for confusion matrix: " , style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                                pw.Text("N is the total number of records including yes and no as predicted values ", style: pw.TextStyle(fontSize: 12,)),
                                pw.Text("With 20% test data, " + pdfi.trueNegative.toString() + " is the number of actual data that has NO outcome and correctly predicted as No", style: pw.TextStyle(fontSize: 12, )),
                                pw.Text("With 20% test data, " + pdfi.falsePositive.toString() + " is the number of actual data that has NO outcome and incorrectly predicted as YES", style: pw.TextStyle(fontSize: 12, )),
                                pw.Text("With 20% test data, " + pdfi.falseNegative.toString() + " is the number of actual data that has YES outcome and incorrectly predicted as NO", style: pw.TextStyle(fontSize: 12, )),
                                pw.Text("With 20% test data, " + pdfi.truePositive.toString() + " is the number of actual data that has YES outcome and incorrectly predicted as YES", style: pw.TextStyle(fontSize: 12, )),

                                pw.SizedBox(height: 20),
                                pw.Text("Threshold Value:", style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                                pw.Text("Light Level Threshold Value: 50-100", style: pw.TextStyle(fontSize: 12,)),
                                pw.Text("Temperature Threshold Value: 22-30", style: pw.TextStyle(fontSize: 12,)),
                                pw.Text("Humidity Threshold Value: 70-85", style: pw.TextStyle(fontSize: 12,)),

                                pw.SizedBox(height: 20),
                                // pw.Text("Total Record: " + (pdfi.yes + pdfi.no).toString() , style: pw.TextStyle(fontSize: 12,)),
                                // pw.Text("Total Predicted Value as No: " + pdfi.no.toString(), style: pw.TextStyle(fontSize: 12,)),
                                // pw.Text("Total Predicted Value as Yes: " + pdfi.yes.toString(), style: pw.TextStyle(fontSize: 12,)),
                                pw.Text("The average Light Level is : " + pdfi.lightLevel.mean.round().toString() + " which is " + lightPassedString, style: pw.TextStyle(fontSize: 12, )),
                                pw.Text("The average Room Temperature is : " + pdfi.roomTemp.mean.round().toString() + " which is " + tempPassedString , style: pw.TextStyle(fontSize: 12,)),
                                pw.Text("The average Humidity is : " + pdfi.humidity.mean.round().toString() + " which is " + humidPassedString, style: pw.TextStyle(fontSize: 12,)),

                              ],
                            )
                          ],
                        ),
                      ),
                    ]
                ),
              ),
            ],
          ),
          pw.Footer(
              padding: pw.EdgeInsets.all(10),
              margin: pw.EdgeInsets.all(0),
              decoration: pw.BoxDecoration(color: PdfColors.orange200),
              title: pw.Column(
                children: [
                  // pw.Container(
                  //   // color: Color(Colors._redAccentValue),
                  //   child: pw.Center(child: pw.Text("Recommendation", style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold))),
                  // ),
                  // lightRecommend == true ? pw.Text("Increase Light", style: pw.TextStyle(fontSize: 20, color: PdfColors.red, fontWeight: pw.FontWeight.bold)) : pw.Text("", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  // tempRecommend == true ? pw.Text("Increase Temperature", style: pw.TextStyle(fontSize: 20, color: PdfColors.red, fontWeight: pw.FontWeight.bold)) : pw.Text("", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  // humidRecommend == true ? pw.Text("Increase Humidity", style: pw.TextStyle(fontSize: 20, color: PdfColors.red, fontWeight: pw.FontWeight.bold)) : pw.Text("", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),

                  pw.Container(
                    // color: Color(Colors._redAccentValue),
                    child: pw.Center(child: pw.Text("", style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold))),
                  ),
                  lightRecommend == true ? pw.Text("", style: pw.TextStyle(fontSize: 20, color: PdfColors.red, fontWeight: pw.FontWeight.bold)) : pw.Text("", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  tempRecommend == true ? pw.Text("", style: pw.TextStyle(fontSize: 20, color: PdfColors.red, fontWeight: pw.FontWeight.bold)) : pw.Text("", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  humidRecommend == true ? pw.Text("", style: pw.TextStyle(fontSize: 20, color: PdfColors.red, fontWeight: pw.FontWeight.bold)) : pw.Text("", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),

                  // pw.Text(context.pageNumber.toString()),
                ],
              )
          ),
        ],



      ),


    );

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
//
// static Future openFile(io.File file) async {
//   final String url = file.toString();
//   print("Trying to print url");
//   print(url);
//   await OpenFile.open(url);
// }
//
// static pw.Widget buildTable(Pdf pdfi) {
//
//   return pw.Table(
//     border: pw.TableBorder.all(),
//     children: [
//     buildRow(['ID', 'Batch Number', 'Light Level', 'Room Temp', 'Humidity'])
//     ],
//   );

// final headers = [
//   'ID',
//   'Batch Number',
//   'Date',
//   'Light Level',
//   'Room Temp',
//   'Humidity'
// ];
// final data = pdfi.prediction.map((item) => item).toList();
// return pw.Table.fromTextArray(
//     headers: headers,
//     data: data,
//     border: null,
//     headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
//     headerDecoration: pw.BoxDecoration(color: PdfColors.teal),
// );
// }

// static pw.TableRow buildRow(List<String> cells) {
//   return pw.TableRow(children: cells.map((e) {
//     pw.Padding(
//         padding: const EdgeInsets.all(12),
//         child: Center (
//           child: Text(e),
//         ))
//   }));
// }
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