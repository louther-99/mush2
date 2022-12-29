import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
