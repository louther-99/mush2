import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta_meta.dart';
import 'package:mush2/model/mushroomData.dart';
import 'package:mush2/model/userData.dart';
import 'package:mush2/pdf_viewer.dart';
import 'package:provider/provider.dart';
import 'package:mush2/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:sklite/SVM/SVM.dart';
// import 'package:sklite/base.dart';
// import 'package:sklite/ensemble/forest.dart';
// import 'package:sklite/naivebayes/naive_bayes.dart';
// import 'package:sklite/neighbors/neighbors.dart';
// import 'package:sklite/neural_network/neural_network.dart';
// import 'package:sklite/pipeline/pipeline.dart';
// import 'package:sklite/tree/tree.dart';
// import 'package:sklite/utils/exceptions.dart';
// import 'package:sklite/utils/io.dart';
// import 'package:sklite/utils/mathutils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ml_preprocessing/ml_preprocessing.dart';
import 'package:mush2/utils/colors.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:ml_algo/ml_algo.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:ml_dataframe/ml_dataframe.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart'; // For google maps
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
//
// import 'package:sklite/SVM/SVM.dart';
// import 'package:sklite/base.dart';
// import 'package:sklite/ensemble/forest.dart';
// import 'package:sklite/naivebayes/naive_bayes.dart';
// import 'package:sklite/neighbors/neighbors.dart';
// import 'package:sklite/neural_network/neural_network.dart';
// import 'package:sklite/pipeline/pipeline.dart';
// import 'package:sklite/tree/tree.dart';
// import 'package:sklite/utils/exceptions.dart';
// import 'package:sklite/utils/io.dart';
// import 'package:sklite/utils/mathutils.dart';

// import 'package:tflite/tflite.dart';
import 'package:tflite/tflite.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:chaquopy/chaquopy.dart';
import 'package:csv/csv.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:http/http.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:open_file/open_file.dart';
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
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';


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
        height: getHeight(),
        child: SingleChildScrollView(
          // clipBehavior: Clip.none,
          // reverse: true,
          child: Container(
            color: Colors.blueGrey,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 235),
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children: [
                Container(
                  // color: green,
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

                  Container(
                    height: 350,
                    // color: Colors.blueGrey,
                    // child: DataTable(
                    //   columns: _data![0].map((e) => DataColumn(label: Text(e.toString()))).toList(),
                    //   rows: _data!.map((e) => DataRow(cells: e.map((e) => DataCell(Text(e.toString(),),),).toList())).toList(),
                    // ),

                    child: file_result == null ? Container(

                      child: SingleChildScrollView(
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
                            Lottie.network('https://assets5.lottiefiles.com/packages/lf20_komemhfl.json'),

                          ],
                        ),
                      )
                    ) : ListView.builder(
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
                    SizedBox(height: 20,),

                    Center(
                      child: Card(
                        margin: const EdgeInsets.fromLTRB(0,20,5,5),
                        // margin: EdgeInsets.fromLTRB(15, 15, 15, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: pinkColor,
                        elevation: 10,
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
                                      text: " Accuracy: " + acu.toString() + "%",
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

                    // OutlinedButton.icon(
                    //   icon: Icon(Icons.query_stats, color: textColor),
                    //   onPressed: () async {
                    //
                    //     // final preprocess = Get_Dataset();
                    //
                    //     final int batchNumber = int.parse(
                    //         batchController.text);
                    //     final double lightLevel = double.parse(
                    //         lightLevelController.text);
                    //     final double roomTemp = double.parse(
                    //         roomTemperatureController.text);
                    //     final double humidity = double.parse(
                    //         roomHumidityController.text);
                    //     final String outcome = (productionController.text);
                    //     final datetime = DateFormat('MM-dd-yyyy KK:mm:ss a').format(DateTime.now());
                    //
                    //     var datas = {
                    //       // 'id' : userID,
                    //       // 'batchNumber': batchController.text,
                    //       'lightLevel': lightLevelController.text,
                    //       'roomTemp': roomTemperatureController.text,
                    //       'humidity': roomHumidityController.text,
                    //       // 'outcome': 'ewan',
                    //       // 'datetime': datetime,
                    //     };
                    //
                    //     print(datas.toString() + " is datas");
                    //     // Passing the data and the endpoint
                    //     var r = await CallApi().postData(datas, 'predict');
                    //     print("printing r.body below: ..");
                    //     print(r.body);
                    //     print("Done printing r.body");
                    //     final json = jsonDecode(r.body);
                    //     print("printing json below: ..");
                    //     print(json);
                    //     print("Done printing json");
                    //     // var decoded = jsonDecode(r);
                    //     // print("printing decoded below: ..");
                    //     // print(decoded);
                    //     print("printing json['Prediction'] ");
                    //     print(json['Prediction'][0]);
                    //
                    //     print("Printing accuracy: below");
                    //     print(json['Accuracy']);
                    //     double a = json['Accuracy'] * 100;
                    //     print(a);
                    //
                    //     setState(() {
                    //       shuta = (json['Prediction'][0]);
                    //       acu = (a.toString());
                    //     });
                    //
                    //     // output = decoded['Prediction'];
                    //     // print(output);
                    //
                    //
                    //     // print(r.body.toString() + " is r.body");
                    //     // var bo = json.decode(json.encode(r.body));
                    //     // print(bo + " is bo");
                    //
                    //     createData(batchNumber: batchNumber, lightLevel: lightLevel, roomTemp: roomTemp, humidity: humidity, outcome: shuta, datetime: datetime);
                    //
                    //     batchController.text = '';
                    //     lightLevelController.text = '';
                    //     roomTemperatureController.text = '';
                    //     roomHumidityController.text = '';
                    //     productionController.text = '';
                    //
                    //
                    //
                    //     final snackBar = SnackBar(content: Text("Data has been added."));
                    //
                    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //
                    //   },
                    //   label: Text(
                    //     'Predict',
                    //     style: TextStyle(
                    //       fontSize: 24,
                    //       color: textColor,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    //   style: OutlinedButton.styleFrom(
                    //     shape: StadiumBorder(),
                    //     minimumSize: Size.fromHeight (40),
                    //     backgroundColor: bgCard,
                    //   ),
                    // ),



                    SizedBox(height: 20),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          SizedBox(height: 50),

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
                                return "Username cannot be empty!";
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
                                return "Password cannot be empty!";
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
                                return "Username cannot be empty!";
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
                                return "Username cannot be empty!";
                              }
                              else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 30),


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
                              var r = await CallApi().postData(datas, 'predict');
                              print("printing r.body below: ..");
                              print(r.body);
                              print("Done printing r.body");
                              final json = jsonDecode(r.body);
                              print("printing json below: ..");
                              print(json);
                              print("Done printing json");
                              // var decoded = jsonDecode(r);
                              // print("printing decoded below: ..");
                              // print(decoded);
                              print("printing json['Prediction'] ");
                              print(json['Prediction'][0]);
                              final prediction = json['Prediction'][0];
                              print("Printing accuracy: below");
                              final accuracy = json['Accuracy'];
                              print(json['Accuracy']);
                              print("json['Description']");
                              print(json['Description']);
                              // described = json['Description'];
                              double a = json['Accuracy'] * 100;
                              print(a);





                              setState(() {
                                shuta = (json['Prediction'][0]);
                                acu = (a.toString());
                                // described = json['Description'];
                              });

                              final snackBar2 = SnackBar(content: Text("Sample report has been regenerated"));

                              ScaffoldMessenger.of(context).showSnackBar(snackBar2);

                              final pdf = new Pdf(
                                prediction: prediction,
                                accuracy: accuracy,
                                // described: described,
                              );


                              final pdfFile = await PdfApi.generateText(pdf);
                              // PdfApi.openFile(pdfFile!);
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



                              final snackBar = SnackBar(content: Text("Data has been added."));

                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

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
                                            text: " Accuracy: " + acu.toString() + "%",
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

                          SizedBox(height: 20),

                        ],
                      ),
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

  // Get_Dataset() async {
  //   final dataFrame2 = await fromCsv('MyDataSetCSV2.csv');
  //   // final dataFrame = getWineQualityDataframe();
  //   // final dataFrame = await fromCsv('/Users/loutherolayres/Documents/MyDataSetCSV2.csv.csv',
  //   //     columns: [2,3]);
  //   // final dataFrame = await fromCsv('/Users/loutherolayres/mush2 9.10.15 AM trashing/assets/MyDataSetCSV2.csv');
  //   // final dataFrame2 = await fromCsv('MyDataSetCSV2.csv');
  //
  //   // final dataFrame = await fromCsv('assets/MyDataSetCSV2.csv');
  //   print(dataFrame2);
  //   final targetColumnName = 'outcome';
  //   final splits = splitData(dataFrame2, [0.7]);
  //   final splits2 = splitData(dataFrame2, [0.7]);
  //   final trainData = splits.first;
  //   final testData = splits.last;
  //
  // }

  fetchData (String url) async{
    // #before
    // http.Response response = await http.get(Uri.parse(url));
    //after
    final response = await http.get(Uri.parse(url));
    return response.body;

  }

  void _upload() async {
    file_result = await FilePicker.platform.pickFiles(allowMultiple: false);

    //If null do return nothing
    if(file_result == null) return;

    //Printing the filename
    print(file_result.files.first.name + " is file_result.files.first.name");

    //Printing the file path
    filePath = file_result.files.first.path!;
    print(filePath.toString() + " is filePath\n");


    //Opening the file
    final inputs = File(filePath!).openRead();

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
        // print([col].length.toString() + "is fields.length");
        // print("Counter is " + x.toString());

        //Prints 1
        // print(fields[row][col]);
        // if(col == 0){
        //   print(col);
        // }
        // print(fields[row][col]);
        // print("Done with fields[row][col]");
        // toJsn = ['id =' + [row][col].toString(), 'batchNumber =' + [row][col].toString(), 'datetime =' + [row][col].toString(), 'lightLevel =' + [row][col].toString(), 'roomTemp =' + [row][col].toString(), 'humidity =' + [row][col].toString(), 'outcome =' + [row][col].toString()];

        // print("Done with fields[row][col]");
        iyakan.add(fields[row][col]);

      }

      for(int row = 0; row<iyakan.length; row++ ){

      }
      // print("Printing toJsn");
      // print(toJsn);

      // dat.add(fields[i]);
      // for(int x = 1; x <=fields.length; x++){
      //   print(fields[i][i]);
      // }

      // dat.add("index " + i.toString() +  fields[i].toString());
      //  dat = {
      //   "id" :  fields[i][i],
      //   "batchNumber" : fields[i][i],
      //   "datetime" : fields[i][i],
      //   "lightLevel" : fields[i][i],
      //   "roomTemp" : fields[i][i],
      //   "humidity" : fields[i][i],
      //    "outcome" : fields[i][i],
      //
      // };
      // rows = rows.add(fields[i]);
      // rows = rows.insertAll(fields[i]);
      // rows = rows + fields[i];
    }
    // print("\nAfter the loop, baliwan is:");
    // print(baliwan);
    // print("\nAfter the loop, iyakan is:");
    // print(iyakan);

    for (int i = 0; i<iyakan.length; i++){
      // print(iyakan[i]);
      if (i == 6){

      }
    }
    // print("After the loop, dat is:");
    // print(dat);
    // print("Length of dat is " + dat.length.toString() );


    // print(fields.toString() + " is fields\n");

    var arr = {
      "title" : fields[0],
      "data" : dat,
    };
    print(dat.length.toString() + " is dat.length");
    for (int i = 0; i <dat.length; i++){
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

      createData(batchNumber: int.parse(mush[i].batchNumber), lightLevel: double.parse(mush[i].lightLevel), roomTemp: double.parse(mush[i].roomTemp), humidity: double.parse(mush[i].humidity), outcome: shuta, datetime: mush[i].datetime);

    }
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
    // print("\jsonObject is " + jsonObject);
    // print("\nDone with jsonObject");
    // print(decoded[0]);  //{id: 1, batchNumber: 2, lightLevel: 40, roomTemp: 19, humidity: 50, outcome: No, datetime: 2021-11-01}
    // print(decoded[24]); //{id: 25, batchNumber: 3, lightLevel: 76, roomTemp: 77, humidity: 13, outcome: No, datetime: 2021-11-25}
    // print(decoded[24]['id']);  //25
    // print("arr['title']");
    // print(arr['title']);
    // print("arr['data']");
    // print(arr['data']);
    // print("arr is");
    // print(arr);
    //
    // print(arr);
    // print(fields[0].toString() + " is fields[0]");
    // final title = fields[0].toString();
    // final title = fields[0];
    // print("Title: ");
    // print(title);
    // print("fields[1][1]");
    // print(fields[1][1]);

      // print(fields[1][1+1]);
      // "batchNumber" : fields[i][i+2],
      // "datetime" : fields[i][i+3],
      // "datetime" : fields[i][i+4],
      // "datetime" : fields[i][i+5],
      // "datetime" : fields[i][i+6],
      // "datetime" : fields[i][i+7],

    // print("Printing dat");
    // print(dat);
    // print("Printing rows");
    // print(rows);
    // print(fields[0][1].toString() + " is fields[0][1]");
    // print(fields[1].toString() + " is fields[1] ");
    //
    //
    //
    // print("dat is below");
    // print(dat);

    var res = await CallApi().postDataAgain(jsonObject, 'convert');
    print("printing res.body below: ..");
    print(res.body);
    print("Done printing rspn.body");
    final jsons = jsonDecode(res.body);
    print("printing jsons below: ..");
    print(jsons);
    print("test shuta");
    print(jsons[24]);
    print(jsons[24][1]);
    print(jsons[24]['outcome']);
    print("Done printing jsons");
    for(int q = 0; q<jsons.length;q++){
      print(jsons[q]);
    }
    // var decoded = jsonDecode(r);
    // print("printing decoded below: ..");
    // print(decoded);
    print("printing json['Prediction'] ");
    // print(json['Prediction'][0]);

    // fields = kl

    // fields

    setState(() {
      _data = fields;
    });

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

  // void _requestFocus() {
  //   setState(() {
  //     FocusScope.of(context).requestFocus(_focusNode);
  //   });
  // }
}

class CallApi {

  postData(datas, apiurl) async {
    String _url = "http://10.0.2.2:5000/";
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

  postDataAgain(jsonObject, urls) async {
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


}

//class _inputstate

