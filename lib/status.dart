import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mush2/home.dart';
import 'package:mush2/pdf_viewer.dart';
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
import 'dart:io' as io;

import 'model/pdf.dart';


class Status extends StatefulWidget {

  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  final datetime = DateFormat('MM-dd-yyyy KK:mm:ss a').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        color: bgCard,
        height: getHeight(),
        child: Padding(
          padding: EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  icon: Icon(Icons.picture_as_pdf, color: textColor, size: 24,),
                  onPressed: () async {
                    // // final pdfContent = Pdf.getPrediction;
                    // final pdfFile = await PdfApi.generateText(pdf);
                    // PdfApi.openFile(pdfFile!);
                    // final fi = await PdfApi.pickFile();
                    //
                    // if (fi == null) return;
                    // openPDF(context,fi);

                  },

                  label: Text(
                    'Donwload PDF',
                    style: TextStyle(
                      fontSize: 24,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    shape: StadiumBorder(),
                    minimumSize: Size.fromHeight (40),
                    backgroundColor: bgCard,
                  ),

                ),
                  Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(0),
                      decoration: BoxDecoration(color: Colors.orange[100]),
                      child: Column(
                        children: [
                          Container(
                            // color: Color(Colors._redAccentValue),
                            child: Center(child: Text("Mushroom Prediction", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                          ),
                          Text("Date generated: " + datetime.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),

                        ],
                      )
                  ),
                  // buildTable(pdfi),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.all(5),
                        color:  Colors.orange[300],
                        child: Column(
                            children: [
                              // pw.SizedBox(height: 20),
                              Container(
                                color: Colors.orange[100],
                                child: Column(
                                  // mainAxisAlignment: pw.MainAxisAlignment.start,
                                  // crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Text("Outcome: " + pdfi.prediction, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    Text("Accuracy: " + pdfi.accuracy.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                      ],
                                    ),
                                    SizedBox(height: 10),



                                    Table(
                                      border: TableBorder.all(color: Colors.orange, width: 1.5),
                                      columnWidths: const {
                                        0: FlexColumnWidth(1.5),
                                        1: FlexColumnWidth(2),
                                        2: FlexColumnWidth(2),
                                        3: FlexColumnWidth(2),
                                        4: FlexColumnWidth(2),
                                        5: FlexColumnWidth(2),
                                      },
                                      children: [
                                        TableRow( children: [
                                          Text("", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black,),),
                                          Text("ID", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black,),),
                                          Text("Batch Number", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),),
                                          Text("Light Level", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),),
                                          Text("Room Temp", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),),
                                          Text("Humidity", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),),
                                        ]),
                                        TableRow(children: [


                                          Text("Count", textAlign: TextAlign.center ,style: TextStyle(fontSize: 15.0),),
                                          Text( pdfi.id.count.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text( pdfi.batchNumber.count.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text( pdfi.lightLevel.count.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text( pdfi.roomTemp.count.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text( pdfi.humidity.count.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),

                                        ]),
                                        TableRow(children: [
                                          Text("Mean", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.id.mean.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.batchNumber.mean.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.lightLevel.mean.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.roomTemp.mean.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.humidity.mean.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),

                                        ]),
                                        TableRow(children: [
                                          Text("STD", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.id.std.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.batchNumber.std.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.lightLevel.std.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.roomTemp.std.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.humidity.std.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),

                                        ]),
                                        TableRow(children: [
                                          Text("Min", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.id.min.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.batchNumber.min.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.lightLevel.min.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.roomTemp.min.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.humidity.min.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),

                                        ]),
                                        TableRow(children: [
                                          Text("Max", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.id.max.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.batchNumber.max.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.lightLevel.max.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.roomTemp.max.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.humidity.max.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),

                                        ]),
                                        TableRow(children: [
                                          Text("25%", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.id.twentyFive.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.batchNumber.twentyFive.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.lightLevel.twentyFive.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.roomTemp.twentyFive.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.humidity.twentyFive.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),

                                        ]),
                                        TableRow(children: [
                                          Text("50%", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.id.fifty.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.batchNumber.fifty.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.lightLevel.fifty.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.roomTemp.fifty.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.humidity.fifty.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),

                                        ]),
                                        TableRow(children: [
                                          Text("75%", textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.id.seventyFive.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.batchNumber.seventyFive.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.lightLevel.seventyFive.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.roomTemp.seventyFive.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),
                                          Text(pdfi.humidity.seventyFive.toString(), textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0),),

                                        ]),


                                      ],
                                    ),

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
                          pw.Container(
                            // color: Color(Colors._redAccentValue),
                            child: pw.Center(child: pw.Text("Mushroom", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))),
                          ),
                          pw.Text("Date generated: " + datetime.toString(), style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                          // pw.Text(context.pageNumber.toString()),
                        ],
                      )
                  ),


              ],
            ),
          ),
        ),

      ),
    );
  }

  double getHeight() {
    double siz = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    print(siz.toString() + " size without the appbar");
    return siz;
  }

  void openPDF(BuildContext context, io.File fi) =>
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: fi))
      );
}
