import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mush2/model/mushroomData.dart';
import 'package:mush2/pdf_viewer.dart';
import 'package:http/http.dart' as http;
import 'package:mush2/utils/colors.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';


import 'package:flutter/services.dart' show rootBundle;


import 'package:google_maps_flutter/google_maps_flutter.dart'; // For google maps
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker/file_picker.dart';

import 'api/pdf_api.dart';
import 'model/ap.dart';
import 'model/pdf.dart';

//Before:
// final  rawCsvContent = await rootBundle.loadString('assets/diabetes.csv');

// Future<String> rawCsvContent = (await rootBundle.loadString('assets/diabetes.csv')) as Future<String>;
// Future<String> raw = rawCsvContent;
// final samples = DataFrame.fromRawCsv(raw);

//The Async function always returns Future Values.
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:io' as io;




void main() async {
  Future<String> stringFuture = _getMockData();
  String message = await stringFuture;
  print(message); // will print one on console.
}

Future<String> _getMockData() async{
  return Future.value("one");
}

class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {


  bool lightPassed = false;
  bool tempPassed = false;
  bool humidPassed = false;
  bool lightRecommend = false;
  bool tempRecommend  = false;
  bool humidRecommend  = false;

  String lightPassedString = "";
  String tempPassedString = "";
  String humidPassedString = "";


  var inputs;
  var values2;
  var jsndescription2ByIndiv;
  var jsonss;
  bool hasPdfBatch = false;
  bool hasPdfIndiv = false;
  List crazy = [];
  String shutaa = "";
  List <String> jsonObject = [];
  String hayop = "";
  int bota = 0;
  List <Mushi> mush = [];
  List id = [];
  List toJsn = [];
  List baliwan = [];
  List iyakan = [];
  List dat = [];
  var file_result;
  List rows = [];
  var described = '';
  var shuta = '';
  var acu = "";
  var acurat;
  var shutarat;
  List<List<dynamic>> _data = [];
  // List<List<dynamic>>? _data;
  String? filePath;
  String url = "";
  String urls = "";
  var data;
  var d;
  String output = 'Initial output';
  String pred = "Initial pred";
  FocusNode _focusNode = new FocusNode();
  final user = FirebaseAuth.instance.currentUser!;
  final String userID = FirebaseAuth.instance.currentUser!.uid;
  String greetings = '';
  final formKey = GlobalKey<FormState>();
  DateTime datetime = DateTime.now();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController lightLevelController = TextEditingController();
  final TextEditingController roomTemperatureController = TextEditingController();
  final TextEditingController roomHumidityController = TextEditingController();
  final TextEditingController productionController = TextEditingController();
  // final TextEditingController _dateController = TextEditingController();
  // String greetings = '';
  // String response = '';
  //
  // String final_response = "";
  // @override
  // void initState() {
  //   super.initState();
  //   _focusNode = FocusNode();
  // }

  // @override
  // void dispose() {
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    // Get_Dataset();
    super.initState();
  }

  @override
  void dispose(){ //Dispose the controller if not needed
    batchController.dispose();
    lightLevelController.dispose();
    roomTemperatureController.dispose();
    roomHumidityController.dispose();
    productionController.dispose();


    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        color: Colors.blueGrey,
        // height: 900,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          // reverse: true,
          child: Container(
            // height: ,
            // final RenderBox renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox;
            // final Size size = renderBox.size; // or _widgetKey.currentContext?.size
            // print('Size: ${size.width}, ${size.height}');
            // color: Colors.red,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                Container(
                  // color: Colors.green,
                  padding: EdgeInsets.all(20),
                  // padding: EdgeInsets.fromLTRB(40,20,40,40),
                  child: Center(
                    child: Text(
                      'BATCH UPLOAD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),

                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // SizedBox(height: 30),

                    SizedBox(height: 5),
                    OutlinedButton.icon(
                      icon: Icon(Icons.upload, color: Colors.blueGrey),
                      onPressed: () async {
                        // FirebaseAuth.instance.signOut();

                        _upload();


                        // final snackBar = SnackBar(content: Text("Data has been added."));
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      },

                      label: Text(
                        'Upload CSV',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size.fromHeight (40),
                        backgroundColor: brown,
                        side: BorderSide(color: outline),
                      ),

                    ),
                    SizedBox(height: 20),

                  Stack(
                    children: [Container(
                      height: 500,
                      // color: Colors.pink,
                      // child: DataTable(
                      //   columns: _data![0].map((e) => DataColumn(label: Text(e.toString()))).toList(),
                      //   rows: _data!.map((e) => DataRow(cells: e.map((e) => DataCell(Text(e.toString(),),),).toList())).toList(),
                      // ),

                      child: file_result == null ? Container(
                        // color: Colors.blue,
                        child: Stack(
                          children:  [SingleChildScrollView(
                            child: Column(
                              children: [
                                AnimatedTextKit(
                                  animatedTexts: [
                                    TypewriterAnimatedText('Upload', textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                        color: brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),),
                                    TypewriterAnimatedText('your', textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                        color: brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),),
                                    TypewriterAnimatedText('CSV', textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                        color: brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),),
                                    TypewriterAnimatedText('File', textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                        color: brown,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),),

                                  ],
                                  // 'Upload your CSV File',

                                ),
                                // Container(
                                //     height: 250,
                                //     child: Center(child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_komemhfl.json'))),
                                SizedBox(height: 10),
                                Container(
                                  // height: 00,
                                  // color: Colors.red,
                                  child: Column(
                                    children: [
                                      Lottie.network('https://assets5.lottiefiles.com/packages/lf20_komemhfl.json'),
                                      Lottie.network('https://assets7.lottiefiles.com/packages/lf20_rqo8mcum.json'),
                                    ],
                                  )),

                              ],

                            ),
                          ),
                            Positioned(
                              top: 455.0,
                              left: 300.0,
                              right: 0,
                              child: hasPdfBatch == true ? Visibility(
                                visible: true,
                                child: IconButton(

                                  icon: Icon(Icons.download_for_offline, color: Colors.white),
                                  color: Colors.white,
                                  iconSize: 50,
                                  onPressed: () async {
                                    final snackBar6 = SnackBar(content: Text("Batch report has been regenerated"));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar6);

                                    final lightMean = jsonss['Responde']['lightLevel']['mean'].round();
                                    final tempMean = jsonss['Responde']['roomTemp']['mean'].round();
                                    final humidMean = jsonss['Responde']['humidity']['mean'].round();

                                    print("Check here");
                                    print(lightMean);
                                    print(tempMean);
                                    print(humidMean);



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

                                    lightRecommend == true ? Text("Increase Light", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));
                                    tempRecommend == true ? Text("Increase Temperature", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));
                                    humidRecommend == true ? Text("Increase Humidity", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));



                                    print("hasPdfBatch == true ? Visibility Before Making pdf by batch");
                                    print(jsonss['Response']['yes']);
                                    print(jsonss['Response']['no']);
                                    print(jsonss['Response']['trueNegative']);
                                    print(jsonss['Response']['falsePositive']);
                                    print(jsonss['Response']['falseNegative']);
                                    print(jsonss['Response']['truePositive']);

                                    final pdff = new Pdf.fromJson(jsonss);
                                    final pdfFile = await PdfApi.generateText(pdff);





                                    // final snackBar = SnackBar(content: Text("Data has been added."));
                                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    setState(() {
                                      hasPdfBatch = false;

                                    });

                                  },
                                  //
                                  // style: OutlinedButton.styleFrom(
                                  //   // : BorderRadius.all( Radius.circular(10)),
                                  //   minimumSize: Size.fromHeight (20),
                                  //   backgroundColor: Colors.white,
                                  //   side: BorderSide(color: outline, width: 5),
                                  // ),


                                ),
                              ) :
                              Visibility(
                                visible: false,
                                child: OutlinedButton.icon(
                                  icon: Icon(Icons.download, color: Colors.blueGrey),
                                  onPressed: () async {
                                      print("visible: false, Before Making pdf by batch");
                                      print(jsonss['Response']['yes']);
                                      print(jsonss['Response']['nes']);

                                    final pdff = new Pdf.fromJson(jsonss);
                                    final pdfFile = await PdfApi.generateText(pdff);

                                    print("What now");
                                    // final snackBar = SnackBar(content: Text("Data has been added."));
                                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  },

                                  label: Text(
                                    'CSV',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    shape: StadiumBorder(),
                                    minimumSize: Size.fromHeight (40),
                                    backgroundColor: brown,
                                    side: BorderSide(color: outline),
                                  ),

                                ),
                              ),
                            ),],
                        )
                      ) : SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 300,
                              // color: Colors.purple,
                              child: ListView.builder(
                                itemCount: _data.length, //docs mean row
                                // scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Card(
                                    margin: const EdgeInsets.all(3),
                                    color: index == 0 ? pinkColor : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    // color: pinkColor,
                                    // elevation: 10,
                                    child: ListTile(
                                      leading: Text(_data[index][3].toString(), textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: index == 0? 18 : 15, fontWeight: index == 0? FontWeight.bold : FontWeight.normal, color: index == 0? textColor : Colors.black),),
                                      title: Text(_data[index][4].toString(), textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: index == 0? 18 : 15, fontWeight: index == 0? FontWeight.bold : FontWeight.normal, color: index == 0? textColor : Colors.black)
                                    ),
                                      trailing: Text(_data[index][5].toString() , textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: index == 0? 18 : 15, fontWeight: index == 0? FontWeight.bold : FontWeight.normal, color: index == 0? textColor : Colors.black)
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: Card(
                                margin: const EdgeInsets.fromLTRB(0,20,5,5),
                                // margin: EdgeInsets.fromLTRB(15, 15, 15, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: pinkColor,
                                elevation: 10,
                                child:  shutarat == null ? Visibility(
                                  visible: false,
                                  child: Column(
                                    children: [
                                      Container(
                                        // height: 40,
                                        padding: EdgeInsets.all(2),
                                        margin:  EdgeInsets.all(20),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Icon(Icons.info, size: 24, color: textColor,),
                                              ),
                                              TextSpan(
                                                text: shutarat == null ? " Outcome: " : " Outcome: " + shutarat.toString(),
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: textColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // height: 40,
                                        padding: EdgeInsets.all(2),
                                        margin:  EdgeInsets.all(20),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Icon(Icons.percent, size: 24, color: textColor,),
                                              ),
                                              TextSpan(
                                                text: acurat == null ? " Accuracy: " : " Accuracy: " + acurat.toString() + "%",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: textColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    :
                                Visibility(
                                  visible: true,
                                  child: Column(
                                    children: [
                                      Container(
                                        // height: 40,
                                        padding: EdgeInsets.all(2),
                                        margin:  EdgeInsets.all(20),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Icon(Icons.info, size: 24, color: textColor,),
                                              ),
                                              TextSpan(
                                                text: shutarat == null ? " Outcome: " : " Outcome: " + shutarat.toString(),
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: textColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // height: 40,
                                        padding: EdgeInsets.all(2),
                                        margin:  EdgeInsets.all(20),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Icon(Icons.percent, size: 24, color: textColor,),
                                              ),
                                              TextSpan(
                                                text: acurat == null ? " Accuracy: " : " Accuracy: " + acurat.toString() + "%",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: textColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      lightRecommend == true ? Visibility(
                                        visible: true,
                                        child: Container(
                                          // height: 40,
                                          padding: EdgeInsets.all(2),
                                          margin:  EdgeInsets.all(20),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(Icons.percent, size: 24, color: textColor,),
                                                ),
                                                TextSpan(
                                                    text: lightRecommend == true ?  "Increase Light" : "",
                                                    // text: tempRecommend == true ?  "Increase Temp" : "",
                                                    // text: humidRecommend == true ?  "Increase Humidity" : "",
                                                    // tempRecommend == true ? Text("Increase Temperature", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));
                                                    // humidRecommend == true ? Text("Increase Humidity", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));

                                                  // text: acurat == null ? " Accuracy: " : " Accuracy: " + acurat.toString() + "%",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: textColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ) : Visibility(
                                        visible: false,
                                        child: Container(
                                          // height: 40,
                                          padding: EdgeInsets.all(2),
                                          margin:  EdgeInsets.all(20),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(Icons.percent, size: 24, color: textColor,),
                                                ),
                                                TextSpan(
                                                  text: lightRecommend == true ?  "Increase Light" : "",
                                                  // text: tempRecommend == true ?  "Increase Temp" : "",
                                                  // text: humidRecommend == true ?  "Increase Humidity" : "",
                                                  // tempRecommend == true ? Text("Increase Temperature", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));
                                                  // humidRecommend == true ? Text("Increase Humidity", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));

                                                  // text: acurat == null ? " Accuracy: " : " Accuracy: " + acurat.toString() + "%",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: textColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),


                                      humidRecommend == true ? Visibility(
                                        visible: true,
                                        child: Container(
                                          // height: 40,
                                          padding: EdgeInsets.all(2),
                                          margin:  EdgeInsets.all(20),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(Icons.percent, size: 24, color: textColor,),
                                                ),
                                                TextSpan(
                                                  // text: lightRecommend == true ?  "Increase Light" : "",
                                                  // text: tempRecommend == true ?  "Increase Temp" : "",
                                                  text: humidRecommend == true ?  "Increase Humidity" : "",
                                                  // tempRecommend == true ? Text("Increase Temperature", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));
                                                  // humidRecommend == true ? Text("Increase Humidity", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));

                                                  // text: acurat == null ? " Accuracy: " : " Accuracy: " + acurat.toString() + "%",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: textColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ) : Visibility(
                                        visible: false,
                                        child: Container(
                                          // height: 40,
                                          padding: EdgeInsets.all(2),
                                          margin:  EdgeInsets.all(20),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(Icons.percent, size: 24, color: textColor,),
                                                ),
                                                TextSpan(
                                                  text: lightRecommend == true ?  "Increase Light" : "",
                                                  // text: tempRecommend == true ?  "Increase Temp" : "",
                                                  // text: humidRecommend == true ?  "Increase Humidity" : "",
                                                  // tempRecommend == true ? Text("Increase Temperature", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));
                                                  // humidRecommend == true ? Text("Increase Humidity", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));

                                                  // text: acurat == null ? " Accuracy: " : " Accuracy: " + acurat.toString() + "%",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: textColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),



                                      tempRecommend == true ? Visibility(
                                        visible: true,
                                        child: Container(
                                          // height: 40,
                                          padding: EdgeInsets.all(2),
                                          margin:  EdgeInsets.all(20),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(Icons.percent, size: 24, color: textColor,),
                                                ),
                                                TextSpan(
                                                  // text: lightRecommend == true ?  "Increase Light" : "",
                                                  text: tempRecommend == true ?  "Increase Temp" : "",
                                                  // text: humidRecommend == true ?  "Increase Humidity" : "",
                                                  // tempRecommend == true ? Text("Increase Temperature", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));
                                                  // humidRecommend == true ? Text("Increase Humidity", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));

                                                  // text: acurat == null ? " Accuracy: " : " Accuracy: " + acurat.toString() + "%",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: textColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ) : Visibility(
                                        visible: false,
                                        child: Container(
                                          // height: 40,
                                          padding: EdgeInsets.all(2),
                                          margin:  EdgeInsets.all(20),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Icon(Icons.percent, size: 24, color: textColor,),
                                                ),
                                                TextSpan(
                                                  text: lightRecommend == true ?  "Increase Light" : "",
                                                  // text: tempRecommend == true ?  "Increase Temp" : "",
                                                  // text: humidRecommend == true ?  "Increase Humidity" : "",
                                                  // tempRecommend == true ? Text("Increase Temperature", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));
                                                  // humidRecommend == true ? Text("Increase Humidity", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)) : Text("", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold));

                                                  // text: acurat == null ? " Accuracy: " : " Accuracy: " + acurat.toString() + "%",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    color: textColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),


                          ],

                        ),
                      ),



                    ),Positioned(
                      // top: 455.0,
                      // left: 300.0,
                      // right: 0,
                      top: 350.0,
                      left: 240.0,
                      right: 0,
                      child: hasPdfBatch == true ? Visibility(
                        visible: true,
                        child: IconButton(

                          icon: Icon(Icons.download_for_offline, color: Colors.white),
                          color: Colors.white,
                          iconSize: 100,
                          onPressed: () async {
                            final snackBar5 = SnackBar(content: Text("Batch report has been regenerated"));


                            ScaffoldMessenger.of(context).showSnackBar(snackBar5);

                            final lightMean = jsonss['Responde']['lightLevel']['mean'].round();
                            final tempMean = jsonss['Responde']['roomTemp']['mean'].round();
                            final humidMean = jsonss['Responde']['humidity']['mean'].round();

                            print("Check here again");
                            print(lightMean);
                            print(tempMean);
                            print(humidMean);


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



                            print("hasPdfBatch == true ? Before Making pdf by batch");
                            print(jsonss['Response']['no']);
                            print(jsonss['Response']['yes']);
                            print(jsonss['Response']['trueNegative']);
                            print(jsonss['Response']['falsePositive']);
                            print(jsonss['Response']['falseNegative']);
                            print(jsonss['Response']['truePositive']);

                            final pdff = new Pdf.fromJson(jsonss);
                            final pdfFile = await PdfApi.generateText(pdff);


                            setState(() {
                              hasPdfBatch = false;
                            });


                          },


                          //
                          // style: OutlinedButton.styleFrom(
                          //   // : BorderRadius.all( Radius.circular(10)),
                          //   minimumSize: Size.fromHeight (20),
                          //   backgroundColor: Colors.white,
                          //   side: BorderSide(color: outline, width: 5),
                          // ),


                        ),
                      ) :
                      Visibility(
                        visible: false,
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.download, color: Colors.blueGrey),
                          onPressed: () async {
                            print("Before Making pdf by batch");
                            final pdff = new Pdf.fromJson(jsonss);
                            final pdfFile = await PdfApi.generateText(pdff);
                            // final snackBar = SnackBar(content: Text("Data has been added."));
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },

                          label: Text(
                            'CSV',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            minimumSize: Size.fromHeight (40),
                            backgroundColor: brown,
                            side: BorderSide(color: outline),
                          ),

                        ),
                      ),
                    ),],
                  ),
                    SizedBox(height: 20,),





                    SizedBox(height: 100),
                    Stack(
                      children: [Container(
                      color: Colors.blueGrey,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              // color: green,
                              padding: EdgeInsets.all(20),
                              // padding: EdgeInsets.fromLTRB(40,20,40,40),
                              child: Center(
                                child: Text(
                                  'INDIVIDUAL UPLOAD',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: brown,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),

                              ),
                            ),
                            Center(
                              child: Container(
                                height: 90,
                                  child: Lottie.network('https://assets6.lottiefiles.com/packages/lf20_dvleacuf.json')),
                            ),

                            TextFormField(
                              // focusNode: _focusNode,
                              // onTap: _requestFocus,
                              controller: batchController,
                              cursorColor: textColor,
                              style: TextStyle(
                                color: brown,
                              ),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                // focusColor: textColor,
                                border: OutlineInputBorder(
                                      borderSide: BorderSide(color: brown, width: 32.0),
                                      borderRadius: BorderRadius.circular(15.0)),
                                  prefixIcon: Icon(
                                      Icons.numbers,
                                    color: brown,
                                  ),
                                  labelText: "Batch Number",
                                  labelStyle: TextStyle(
                                      color: brown,
                                  )
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Batch Number cannot be empty!";
                                }
                                else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              // focusNode: _focusNode,
                              // onTap: _requestFocus,
                              controller: lightLevelController,
                              cursorColor: brown,
                              style: TextStyle(
                                color: brown,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: textColor, width: 32.0),
                                      borderRadius: BorderRadius.circular(15.0)),
                                  prefixIcon: Icon(
                                    Icons.lightbulb,
                                    color: brown,
                                  ),
                                  labelText: "Light Level(Lumens)",
                                  labelStyle: TextStyle(
                                color: brown,
                              )
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Light Level cannot be empty!";
                                }
                                else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              // focusNode: _focusNode,
                              // onTap: _requestFocus,
                              controller: roomTemperatureController,
                              cursorColor: brown,
                              style: TextStyle(
                                color: brown,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: textColor, width: 32.0),
                                      borderRadius: BorderRadius.circular(15.0)),
                                  prefixIcon: Icon(
                                    Icons.thermostat,
                                    color: brown,
                                  ),
                                  labelText: "Room Temperature",
                                  labelStyle: TextStyle(
                                    color: brown,
                                  )
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Room Temperature cannot be empty!";
                                }
                                else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              // focusNode: _focusNode,
                              // onTap: _requestFocus,
                              controller: roomHumidityController,
                              cursorColor: brown,
                              style: TextStyle(
                                color: brown,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: textColor, width: 32.0),
                                      borderRadius: BorderRadius.circular(15.0)),
                                  prefixIcon: Icon(
                                      Icons.water_drop,
                                      color: brown,
                                  ),
                                  labelText: "Humidity(Milibar)",
                                  labelStyle: TextStyle(
                                    color: brown,
                                  )
                              ),
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return "Humidity cannot be empty!";
                                }
                                else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 10),


                            SizedBox(height: 20,),
                            OutlinedButton.icon(
                              icon: Icon(Icons.query_stats, color: Colors.blueGrey),
                              onPressed: () async {

                                // final preprocess = Get_Dataset();

                                final int batchNumber = int.parse(
                                    batchController.text);
                                final double lightLevel = double.parse(
                                    lightLevelController.text);
                                final double roomTemp = double.parse(
                                    roomTemperatureController.text);
                                final double humidity = double.parse(
                                    roomHumidityController.text);
                                final String outcome = (productionController.text);
                                final datetime = DateFormat('MM-dd-yyyy KK:mm:ss a').format(DateTime.now());

                                var datas = {
                                  // 'id' : userID,
                                  // 'batchNumber': batchController.text,
                                  'lightLevel': lightLevelController.text,
                                  'roomTemp': roomTemperatureController.text,
                                  'humidity': roomHumidityController.text,
                                  // 'outcome': 'ewan',
                                  // 'datetime': datetime,
                                };

                                print(datas.toString() + " is datas");
                                // Passing the data and the endpoint
                                var r = await CallApi().predictByIndiv(datas, 'predictByIndiv');
                                print("printing r.body below: ..");
                                print(r.body);
                                print("Done printing r.body");
                                final jsonpredictByIndiv = jsonDecode(r.body);
                                print("printing json below: ..");
                                print(jsonpredictByIndiv);
                                print("Done printing json");
                                // var decoded = jsonDecode(r);
                                // print("printing decoded below: ..");
                                // print(decoded);
                                print("printing json['Prediction'] ");
                                print(jsonpredictByIndiv['Prediction'][0]);

                                print("Responde: ");
                                // print(json['Responde']);
                                print("Done Responde");
                                print(jsonpredictByIndiv['Responde']['id']);
                                print(jsonpredictByIndiv['Responde']['batchNumber']);
                                print(jsonpredictByIndiv['Responde']['humidity']);
                                print(jsonpredictByIndiv['Responde']['lightLevel']);
                                print(jsonpredictByIndiv['Responde']['roomTemp']);
                                print(jsonpredictByIndiv['Responde']['accuracy']);
                                print(jsonpredictByIndiv['Responde']['prediction']);

                                final prediction = jsonpredictByIndiv['Prediction'][0];
                                print("Printing accuracy: below");
                                final accuracy = jsonpredictByIndiv['Accuracy'];
                                print(jsonpredictByIndiv['Accuracy']);
                                // print("json['Description']");
                                // print(json['Description']);
                                // described = json['Description'];
                                int a = (jsonpredictByIndiv['Accuracy'] * 100).toInt();
                                a.round();
                                print(a);

                                var values = {
                                  'prediction' : prediction,
                                  'accuracy' : a

                                };

                                var r2 = await CallApi().description2(values,'description2ByIndiv');

                                // json.decode(json.encode(response.databody);
                                print("Done printing rspns.body from description2");
                                jsndescription2ByIndiv = jsonDecode(r2.body);
                                print(jsndescription2ByIndiv.runtimeType);
                                print(jsndescription2ByIndiv);
                                // jsonss['Responde'].forEach((key, value) {
                                //   print(key);
                                //   print(value);
                                //
                                // });


                                // var newTae =  jsonEncode(values) + jsonss;
                                // print(newTae);
                                // final con = json.add(jsonss);
                                // print(con);
                                print(jsndescription2ByIndiv['Response']['accuracy']);
                                print(jsndescription2ByIndiv['Response']['prediction']); //
                                print(jsndescription2ByIndiv['Responde']['id']); // {count: 25.0, mean: 13.0, std: 7.3598007219, min: 1.0, 25%: 7.0, 50%: 13.0, 75%: 19.0, max: 25.0}
                                print(jsndescription2ByIndiv['Responde']['id']['count']);

                                print("Done with con");
                                print(jsndescription2ByIndiv);
                                print("Done");
                                final jsonss2 = jsonDecode(r2.body);
                                // final concat = jsonss2.concat(values);
                                print('concat');
                                // print(concat);
                                print(jsonss2);
                                print(jsndescription2ByIndiv['Responde']['id']['count']);
                                // Id idClass = Id.fromJson(jsonDecode(r2.body));
                                // BatchNumber BatchNumberClass = BatchNumber.fromJson(jsonDecode(r2.body));
                                // LightLevel LightLevelClass = LightLevel.fromJson(jsonDecode(r2.body));
                                // RoomTemp RoomTempClass = RoomTemp.fromJson(jsonDecode(r2.body));
                                // Humidity HumidityClass = Humidity.fromJson(jsonDecode(r2.body));

                                print("This is idClass.count");
                                // print(idClass.mean);
                                // print(BatchNumberClass.mean);
                                // print(LightLevelClass.mean);
                                // print(RoomTempClass.mean);
                                // print(HumidityClass.mean);
                                print("printing jsons below: ..");
                                print(Response);
                                // print(json['Responde']['id']); // {count: 25.0, mean: 13.0, std: 7.3598007219, min: 1.0, 25%: 7.0, 50%: 13.0, 75%: 19.0, max: 25.0}
                                // print(json['Responde']['id']['count']); // 25.0
                                // print(json['Responde']['id']['mean']);
                                // print(json['Responde']['id']['std']);
                                // print(json['Responde']['id']['min']);
                                // print(json['Responde']['id']['25%']);
                                // print(json['Responde']['id']['50%']);
                                // print(json['Responde']['id']['75%']);
                                // print(json['Responde']['id']['max']);
                                //
                                // print(json['Responde']['batchNumber']);
                                // print(json['Responde']['batchNumber']['count']);
                                // print(json['Responde']['batchNumber']['mean']);
                                // print(json['Responde']['batchNumber']['std']);
                                // print(json['Responde']['batchNumber']['min']);
                                // print(json['Responde']['batchNumber']['25%']);
                                // print(json['Responde']['batchNumber']['50%']);
                                // print(json['Responde']['batchNumber']['75%']);
                                // print(json['Responde']['batchNumber']['max']);
                                //
                                // print(json['Responde']['lightLevel']);
                                // print(json['Responde']['lightLevel']['count']);
                                // print(json['Responde']['lightLevel']['mean']);
                                // print(json['Responde']['lightLevel']['std']);
                                // print(json['Responde']['lightLevel']['min']);
                                // print(json['Responde']['lightLevel']['25%']);
                                // print(json['Responde']['lightLevel']['50%']);
                                // print(json['Responde']['lightLevel']['75%']);
                                // print(json['Responde']['lightLevel']['max']);
                                //
                                // print(json['Responde']['roomTemp']);
                                // print(json['Responde']['roomTemp']['count']);
                                // print(json['Responde']['roomTemp']['mean']);
                                // print(json['Responde']['roomTemp']['std']);
                                // print(json['Responde']['roomTemp']['min']);
                                // print(json['Responde']['roomTemp']['25%']);
                                // print(json['Responde']['roomTemp']['50%']);
                                // print(json['Responde']['roomTemp']['75%']);
                                // print(json['Responde']['roomTemp']['max']);
                                //
                                // print(json['Responde']['humidity']);
                                // print(json['Responde']['humidity']['count']);
                                // print(json['Responde']['humidity']['mean']);
                                // print(json['Responde']['humidity']['std']);
                                // print(json['Responde']['humidity']['min']);
                                // print(json['Responde']['humidity']['25%']);
                                // print(json['Responde']['humidity']['50%']);
                                // print(json['Responde']['humidity']['75%']);
                                // print(json['Responde']['humidity']['max']);



                                setState(() {
                                  shuta = (jsonpredictByIndiv['Prediction'][0]);
                                  acu = (a.toString());
                                  hasPdfIndiv = true;
                                  // described = json['Description'];
                                });



                                final snackBar2 = SnackBar(content: Text("Individual report has been regenerated"));

                                ScaffoldMessenger.of(context).showSnackBar(snackBar2);

                                // print("Hi");
                                // print(pdf.batchNumber);

                                // final pdf = new Pdf(
                                //   prediction: prediction,
                                //   accuracy: accuracy,
                                //   id: null,
                                //   batchNumber: null,
                                //   lightLevel: null,
                                //   roomTemp: null,
                                //   humidity: null,
                                //   // described: described,
                                // );


                                // final pdfFile = await PdfApi.generateText(pdf);
                                // PdfApi.openFile(pdfFile!);
                                // final fi = await PdfApi.pickFile();
                                // final fi = await PdfApi.pickFile();
                                //
                                // if (fi == null) return;
                                // openPDF(context,fi);

                                // output = decoded['Prediction'];
                                // print(output);


                                // print(r.body.toString() + " is r.body");
                                // var bo = json.decode(json.encode(r.body));
                                // print(bo + " is bo");

                                createData(batchNumber: batchNumber, lightLevel: lightLevel, roomTemp: roomTemp, humidity: humidity, outcome: shuta, datetime: datetime);

                                batchController.text = '';
                                lightLevelController.text = '';
                                roomTemperatureController.text = '';
                                roomHumidityController.text = '';
                                productionController.text = '';



                              },
                              label: Text(
                                'Predict',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: StadiumBorder(),
                                minimumSize: Size.fromHeight (40),
                                backgroundColor: brown,
                                side: BorderSide(color: outline),
                              ),
                            ),

                            Center(
                              child: Card(
                                margin: const EdgeInsets.fromLTRB(0,20,5,5),
                                // margin: EdgeInsets.fromLTRB(15, 15, 15, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: pinkColor,
                                elevation: 10,
                                child: acu == "" ? Visibility(
                                  visible: false,
                                  child: Column(
                                    children: [
                                      Container(
                                        // height: 40,
                                        padding: EdgeInsets.all(2),
                                        margin:  EdgeInsets.all(20),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Icon(Icons.info, size: 24, color: textColor,),
                                              ),
                                              TextSpan(
                                                text: " Outcome: " + shuta,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: textColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // height: 40,
                                        padding: EdgeInsets.all(2),
                                        margin:  EdgeInsets.all(20),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Icon(Icons.percent, size: 24, color: textColor,),
                                              ),
                                              TextSpan(
                                                text: acu == "" ? " Accuracy: " : " Accuracy: " + acu.toString() + "%",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: textColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                    :
                                Visibility(
                                  visible: true,
                                  child: Column(
                                    children: [
                                      Container(
                                        // height: 40,
                                        padding: EdgeInsets.all(2),
                                        margin:  EdgeInsets.all(20),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Icon(Icons.info, size: 24, color: textColor,),
                                              ),
                                              TextSpan(
                                                text: " Outcome: " + shuta,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: textColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // height: 40,
                                        padding: EdgeInsets.all(2),
                                        margin:  EdgeInsets.all(20),
                                        child: RichText(
                                          text: TextSpan(
                                            children: [
                                              WidgetSpan(
                                                child: Icon(Icons.percent, size: 24, color: textColor,),
                                              ),
                                              TextSpan(
                                                text: acu == "" ? " Accuracy: " : " Accuracy: " + acu.toString() + "%",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  color: textColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20),

                          ],
                        ),
                      ),
                        ),Positioned(
                      top: 540.0,
                      left: 240.0,
                      right: 0,
                      child: hasPdfIndiv == true ? Visibility(
                        visible: true,
                        child: IconButton(
                          icon: Icon(Icons.download_for_offline, color: Colors.white),
                          color: Colors.white,
                          iconSize: 100,
                          onPressed: () async {
                            print("Before Making pdf");
                            final pdf = new Pdf.fromJson(jsndescription2ByIndiv);
                            final pdfFile = await PdfApi.generateText(pdf);
                            // final snackBar = SnackBar(content: Text("Data has been added."));
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            setState(() {
                              hasPdfIndiv = false;
                            });
                          },
                          //
                          // style: OutlinedButton.styleFrom(
                          //   // : BorderRadius.all( Radius.circular(10)),
                          //   minimumSize: Size.fromHeight (20),
                          //   backgroundColor:
                          //   Colors.white,
                          //   side: BorderSide(color: outline, width: 5),
                          // ),


                        ),
                      ) :
                      Visibility(
                        visible: false,
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.download, color: Colors.blueGrey),
                          onPressed: () async {
                            print("Before Making pdf");
                            final pdf = new Pdf.fromJson(jsndescription2ByIndiv);
                            final pdfFile = await PdfApi.generateText(pdf);
                            // final snackBar = SnackBar(content: Text("Data has been added."));
                            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },

                          label: Text(
                            'CSV',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            minimumSize: Size.fromHeight (40),
                            backgroundColor: brown,
                            side: BorderSide(color: outline),
                          ),

                        ),
                      ),
                    ),],
                    ),


                  ],
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }

  Future createData({required int batchNumber, required double lightLevel, required double roomTemp, required double humidity, required String outcome, required String datetime}) async {
  //Future createData(User user) async {
  final docUser = FirebaseFirestore.instance.collection('mushroom').doc();

    // final json = {
    //   'batchNumber': batchNumber,
    //   'lightLevel': lightLevel,
    //   'roomTemp': roomTemp,
    //   'humidity': humidity,
    //   'outcome': outcome,
    //   'datetime': datetime,
    //
    // };
    // await docUser.set(json);

    final user  = MushroomData(
      id: userID,
      batchNumber: batchNumber,
      lightLevel: lightLevel,
      roomTemp: roomTemp,
      humidity: humidity,
      outcome: outcome,
      datetime: datetime,
    );

    final json = user.toJson();

    await docUser.set(json);
  }


  Future createReport({required int batchNumber, required double lightLevel, required double roomTemp, required double humidity, required String outcome, required String datetime}) async {
    //Future createData(User user) async {
    final docUser = FirebaseFirestore.instance.collection('mushroom').doc();

    // final json = {
    //   'batchNumber': batchNumber,
    //   'lightLevel': lightLevel,
    //   'roomTemp': roomTemp,
    //   'humidity': humidity,
    //   'outcome': outcome,
    //   'datetime': datetime,
    //
    // };
    // await docUser.set(json);

    final user  = MushroomData(
      id: userID,
      batchNumber: batchNumber,
      lightLevel: lightLevel,
      roomTemp: roomTemp,
      humidity: humidity,
      outcome: outcome,
      datetime: datetime,
    );

    final json = user.toJson();
    await docUser.set(json);
  }


  fetchData (String url) async{
    // #before
    // http.Response response = await http.get(Uri.parse(url));
    //after
    final response = await http.get(Uri.parse(url));
    return response.body;

  }

  void _upload() async {
    // inputs = null;

    setState(() {
      file_result = null;
      this.file_result = null;
      dat = [];
      jsonObject = [];
      this.jsonObject = [];
      values2 = [];
      inputs = null;
      _data = [];
      mush = [];
    });

    file_result = await FilePicker.platform.pickFiles(allowMultiple: false);

    //If null do return nothing
    if(file_result == null) return;

    //Printing the filename
    print(file_result.files.first.name + " is file_result.files.first.name");

    //Printing the file path
    filePath = file_result.files.first.path!;
    print(filePath.toString() + " is filePath\n");


    //Opening the file
    inputs = File(filePath!).openRead();

    //Converting csv to arrays
    final fields = await inputs.transform(utf8.decoder).transform(const CsvToListConverter()).toList();



    // mush =

    //Print fields
    print(fields);
    print("Fields: \n" + fields.toString());

    //Starting the loop for row 1
    for(int row = 1; row<fields.length; row++ ){

      //Adding row 1 to dat list of variable
      dat.add(fields[row]);
      // print(dat.length.toString() + " is dat.length");

      //This outputs : [1, 2, 2021-11-01, 40, 19, 50, No]
      // print(fields[row]);

      // print(fields.length.toString() + "is fields.length");
      // print("Counter is " +row.toString());

      //For the column
      for(int col = 0; col <fields[row].length; col++ ){

        // print("Done with fields[row][col]");
        iyakan.add(fields[row][col]);

      }

      for(int row = 0; row<iyakan.length; row++ ){

      }

    }

    for (int i = 0; i<iyakan.length; i++){
      // print(iyakan[i]);
      if (i == 6){

      }
    }


    var arr = {
      "title" : fields[0],
      "data" : dat,
    };
    print(dat.length.toString() + " is dat.length");
    for (int i = 0; i <dat.length; i++){

      // crazy.add(dat[i][3].toString() + dat[i][4].toString() + dat[i][5].toString());

      crazy.add("{" + dat[i][3].toString());
      crazy.add(dat[i][4].toString());
      crazy.add(dat[i][5].toString() + "}");


      mush.add (new Mushi(
        id: dat[i][0].toString(),
        batchNumber: dat[i][1].toString(),
        datetime: dat[i][2].toString(),
        lightLevel: dat[i][3].toString(),
        roomTemp: dat[i][4].toString(),
        humidity: dat[i][5].toString(),
        outcome: dat[i][6].toString(),

      )
      );



      for (int j = 0; j<dat[i].length; j++){
        // print(dat[i][j].toString() + " is dat["+i.toString()+"]["+j.toString()+ "] " + i.toString() + " is " + i.toString() + " j is " + j.toString());
        // print(dat[i][j].toString() + " is dat[i][j] " + i.toString() + " j is " + j.toString());
    //     hayop = dat[i][j+1].toString();

        // print(mush);
        // print("Done with loop");

      }

      // createData(batchNumber: int.parse(mush[i].batchNumber), lightLevel: double.parse(mush[i].lightLevel), roomTemp: double.parse(mush[i].roomTemp), humidity: double.parse(mush[i].humidity), outcome: mush[i].outcome, datetime: mush[i].datetime);

    }
    print("This is crazy: " + crazy.toString());
    print(mush.length.toString() + " is mush.length");
    for(int i = 0; i<mush.length; i++){
      print(mush[i].id);
      print(mush[i].batchNumber);
      print(mush[i].datetime);
      print(mush[i].lightLevel);
      print(mush[i].roomTemp);
      print(mush[i].humidity);
      print(mush[i].outcome);




    }
    print(mush.length.toString() + " is mush.length");
    print(mush[24].outcome.toString() + " is mush[24].outcome"); //No is mush[24].outcome
    print((mush[24]).toJson()) ; //{id: 25, batchNumber: 3, lightLevel: 76, roomTemp: 77, humidity: 13, outcome: No, datetime: 2021-11-25}
    print(jsonEncode(mush[24])) ; //{"id":"25","batchNumber":"3","lightLevel":"76","roomTemp":"77","humidity":"13","outcome":"No","datetime":"2021-11-25"}
    print(mush[24].toString()) ; //Instance of 'Mushi'
    print(mush.length);
    for (int i = 0; i<mush.length; i++){
          jsonObject.add((jsonEncode(mush[i])));
          shutaa+=mush[i].toString();
          print(mush[i].id); //1
          print(mush[i].toJson()); //{id: 1, batchNumber: 2, lightLevel: 40, roomTemp: 19, humidity: 50, outcome: No, datetime: 2021-11-01}
          print(mush[i].toString()); //Instance of 'Mushi'
          print(jsonEncode(mush[i]));  //{"id":"1","batchNumber":"2","lightLevel":"40","roomTemp":"19","humidity":"50","outcome":"No","datetime":"2021-11-01"}
          print(jsonObject[i]); //{id: 1, batchNumber: 2, lightLevel: 40, roomTemp: 19, humidity: 50, outcome: No, datetime: 2021-11-01}
    }
    print("Shuta is:");
    print(shutaa.toString() + " is shutaa");

    print(jsonObject.length.toString() + " is jsonObject.length.toString()");
    for(int q = 0; q<jsonObject.length; q++)
      {
        print(jsonObject[q]);
      }
    print(jsonObject[24].toString() +  " is jsonObject.toString()"); //{id: 25, batchNumber: 3, lightLevel: 76, roomTemp: 77, humidity: 13, outcome: No, datetime: 2021-11-25} is jsonObject.toString()
    var y = jsonEncode(mush);
    print(y[24].toString() + " y[24].toString()");
    print(mush[1].toString() + " is mush[1].toString()");
    print(jsonObject[24] + " is jsonObject[24] "); //{id: 25, batchNumber: 3, lightLevel: 76, roomTemp: 77, humidity: 13, outcome: No, datetime: 2021-11-25} is jsonObject[24] 
    // print(jsonObject[1]);
    // var decoded = jsonDecode(jsonObject);

    print("Printing decoded");
    // print(decoded.toString() + " is decoded");
    print("Done with decoded");


    var res = await CallApi().convertByBatch(jsonObject, 'convertByBatch');
    print("convertByBatch printing res.body below: ..");
    print(res.body);
    print("Done printing rspn.body");
    final jsons = jsonDecode(res.body);
    print("Con");

    print(jsons['Confusion']);
    print(jsons['TrueNegative']);
    print(jsons['FalsePositive']);
    print(jsons['FalseNegative']);
    print(jsons['TruePositive']);
    final TrueNegative = jsons['TrueNegative'];
    final FalsePositive = jsons['FalsePositive'];
    final FalseNegative = jsons['FalseNegative'];
    final TruePositive = jsons['TruePositive'];
    print("Yes/No");
    print(jsons['Yes']);
    print(jsons['No']);
    print("printing jsons below: ..");
    print(jsons);
    print(jsons['Yes']);
    print(jsons['No']);
    final yy = jsons['Yes'];
    final nn = jsons['No'];
    print("test shuta");
    print(jsons[24]);
    print(jsons['Prediction'][24]);
    print(jsons['Prediction'][24]['outcome']);
    print("Here's the accuracy for batch:");
    print(jsons['Accuracy']);
    print("Here's the outcome for batch:");
    print(jsons['Outcome']);

    setState(() {
      hasPdfBatch = true;
      if(jsons['Outcome'] < 80 )
      {
        shutarat = "No";
      }
      else{
        shutarat = 'Yes';
      }
    });

    print(jsons);
    print("Done printing jsons");
    print(jsons['Prediction'].length);
    print(jsons['Prediction'][0]['batchNumber']);
   print( jsons['Prediction'][0]['lightLevel']);
    for(int q = 0; q<jsons['Prediction'].length;q++){
      print(jsons['Prediction'][q]);
      createData(batchNumber: int.parse(jsons['Prediction'][q]['batchNumber']), lightLevel: double.parse(jsons['Prediction'][q]['lightLevel']), roomTemp: double.parse(jsons['Prediction'][q]['roomTemp']), humidity: double.parse(jsons['Prediction'][q]['humidity']), outcome: jsons['Prediction'][q]['outcome'], datetime: jsons['Prediction'][q]['datetime']);
    }
    int acc = (jsons['Accuracy'] * 100).toInt();
    acc.round();
    print(acc);
    setState(() {

      // shuta = (json['Prediction'][0]);
      acurat = (acc.toString());
      // described = json['Description'];
    });

    print("printing json['Prediction'] ");


     values2 = {
      'prediction' : shutarat,
      'accuracy' : acc,
      'trueNegative' : jsons['TrueNegative'],
      'falsePositive' : jsons['FalsePositive'],
      'falseNegative' : jsons['FalseNegative'],
      'truePositive' : jsons['TruePositive'],
      'yes' : jsons['Yes'],
      'no' : jsons['No'],

    };


    print("wakaru");
    var ress = await CallApi().descriptionByBatch(values2, 'descriptionByBatch');
    // json.decode(json.encode(response.databody);
    print("Done printing rspns.body from description");
    // final jsonss = jsonDecode(jsonEncode(ress.body));
    jsonss = jsonDecode(ress.body);
    print(jsonss['Response']['no']);
    print(jsonss['Response']['yes']);
    print(jsonss['Response']['trueNegative']);
    print(jsonss['Response']['falsePositive']);
    print(jsonss['Response']['falseNegative']);
    print(jsonss['Response']['truePositive']);

    print(jsonss);



    print(jsonss['Response']['accuracy']);
    print(jsonss['Response']['prediction']); //
    print(jsonss['Responde']['id']); // {count: 25.0, mean: 13.0, std: 7.3598007219, min: 1.0, 25%: 7.0, 50%: 13.0, 75%: 19.0, max: 25.0}
    print(jsonss['Responde']['id']['count']); // 25.0
    print(jsonss['Responde']['id']['mean']);
    print(jsonss['Responde']['id']['std']);
    print(jsonss['Responde']['id']['min']);
    print(jsonss['Responde']['id']['25%']);
    print(jsonss['Responde']['id']['50%']);
    print(jsonss['Responde']['id']['75%']);
    print(jsonss['Responde']['id']['max']);

    print(jsonss['Responde']['batchNumber']);
    print(jsonss['Responde']['batchNumber']['count']);
    print(jsonss['Responde']['batchNumber']['mean']);
    print(jsonss['Responde']['batchNumber']['std']);
    print(jsonss['Responde']['batchNumber']['min']);
    print(jsonss['Responde']['batchNumber']['25%']);
    print(jsonss['Responde']['batchNumber']['50%']);
    print(jsonss['Responde']['batchNumber']['75%']);
    print(jsonss['Responde']['batchNumber']['max']);

    print(jsonss['Responde']['lightLevel']);
    print(jsonss['Responde']['lightLevel']['count']);
    print(jsonss['Responde']['lightLevel']['mean']);
    print(jsonss['Responde']['lightLevel']['std']);
    print(jsonss['Responde']['lightLevel']['min']);
    print(jsonss['Responde']['lightLevel']['25%']);
    print(jsonss['Responde']['lightLevel']['50%']);
    print(jsonss['Responde']['lightLevel']['75%']);
    print(jsonss['Responde']['lightLevel']['max']);

    print(jsonss['Responde']['roomTemp']);
    print(jsonss['Responde']['roomTemp']['count']);
    print(jsonss['Responde']['roomTemp']['mean']);
    print(jsonss['Responde']['roomTemp']['std']);
    print(jsonss['Responde']['roomTemp']['min']);
    print(jsonss['Responde']['roomTemp']['25%']);
    print(jsonss['Responde']['roomTemp']['50%']);
    print(jsonss['Responde']['roomTemp']['75%']);
    print(jsonss['Responde']['roomTemp']['max']);

    print(jsonss['Responde']['humidity']);
    print(jsonss['Responde']['humidity']['count']);
    print(jsonss['Responde']['humidity']['mean']);
    print(jsonss['Responde']['humidity']['std']);
    print(jsonss['Responde']['humidity']['min']);
    print(jsonss['Responde']['humidity']['25%']);
    print(jsonss['Responde']['humidity']['50%']);
    print(jsonss['Responde']['humidity']['75%']);
    print(jsonss['Responde']['humidity']['max']);

    setState(() {
      _data = fields;
    });

    // for(int q = 0; q<jsonss['Prediction'].length;q++){
    //   print(jsons['Prediction'][q]);
    //   createData(batchNumber: int.parse(jsons['Prediction'][q]['batchNumber']), lightLevel: double.parse(jsons['Prediction'][q]['lightLevel']), roomTemp: double.parse(jsons['Prediction'][q]['roomTemp']), humidity: double.parse(jsons['Prediction'][q]['humidity']), outcome: jsons['Prediction'][q]['outcome'], datetime: jsons['Prediction'][q]['datetime']);
    // }





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

class CallApi {

  predictByIndiv(datas, apiurl) async {
    String _url = "http://10.0.2.2:5000/";
    // String _url = "https://mushie.herokuapp.com/";
    String fullUrl = _url + apiurl;
    print(fullUrl + " is full url");
    // print(fullUrl + " is full url");
    print(datas.toString() + "  is datas");
    var respo = await http.post(
        // Uri.parse(fullUrl),
        Uri.parse(fullUrl),
        body: jsonEncode(datas),
        headers: _setHeaders(),
    );
    print("done with respo");

    if(respo.statusCode == 200){
      var json = respo.body;
      print("This will print json because of 200 stat code");
      print("this is json: " + json + " is json");
    }
    print("done with post data");

    return respo;

  }

  _setHeaders() => {
    'Content-type':'application/json',
    'Accept': 'application/json',
  };

  convertByBatch(jsonObject, urls) async {
    print("Start of postDataAgian");
    List <String>ewan = [];
    print("Making sure that it has the last record");
    print(jsonObject[24]);

    print("Before printing shits");
    print(jsonObject.length.toString() + " is fields length");
    for(int i = 0; i<jsonObject.length; i++){
      ewan.insert(i,jsonObject[i]);
      // print(jsonObject[i]);
      print(ewan[i]);
    }
    print(ewan[24].toString() + " is ewan[24]");
    print("This is ewan: " + ewan.toString());
    print(ewan);
    print("Done printing shits");
    String _urls = "http://10.0.2.2:5000/";
    // String _urls = "https://mushie.herokuapp.com/";
    String fullUrls = _urls + urls;
    var resInPeace = await http.post(
      Uri.parse(fullUrls),
      // Uri.parse(urls),
      body: jsonObject.toString(),
      // body: ewan,

      headers: _setHeaders(),
    );
    print("Printing jsonEncode(fields)");
    print(jsonObject);
    print("done with resInPeace");
    if(resInPeace.statusCode == 200){
      var jsone = resInPeace.body;
      print("This will print jsone because of 200 stat code");
      print("this is json: " + jsone + " is jsone");
      print("End of statuscode 200");
    }
    print("End of postDataAgian");

    return resInPeace;
  }

  descriptionByBatch(values2, urlss) async {
    String _urls = "http://10.0.2.2:5000/";
    // String _urls = "https://mushie.herokuapp.com/";
    String fullUrls = _urls + urlss;
    var resInPeaces = await http.post(
      Uri.parse(fullUrls),
      // Uri.parse(urls),
      body: jsonEncode(values2),
      // body: ewan,
      headers: _setHeaders(),
    );
    return resInPeaces;
  }

  description2(values, urlss2) async {
    String _urls = "http://10.0.2.2:5000/";
    // String _urls = "https://mushie.herokuapp.com/";
    String fullUrls = _urls + urlss2;
    var resInPeaces2 = await http.post(
      Uri.parse(fullUrls),
      // Uri.parse(urls),
      body: jsonEncode(values),
      // body: ewan,
      headers: _setHeaders(),
    );
    return resInPeaces2;
  }


}

//class _inputstate

