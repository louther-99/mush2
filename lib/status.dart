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

import 'api/pdf_api.dart';


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
                    final pdfFile = await PdfApi.generateText("report");
                    PdfApi.openFile(pdfFile!);

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
}
