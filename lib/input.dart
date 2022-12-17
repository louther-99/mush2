import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mush2/model/mushroomData.dart';
import 'package:mush2/model/userData.dart';
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

//Before:
// final  rawCsvContent = await rootBundle.loadString('assets/diabetes.csv');

// Future<String> rawCsvContent = (await rootBundle.loadString('assets/diabetes.csv')) as Future<String>;
// Future<String> raw = rawCsvContent;
// final samples = DataFrame.fromRawCsv(raw);

//The Async function always returns Future Values.

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
  var shuta = '';
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
        color: bgCard,
        height: getHeight(),
        child: SingleChildScrollView(
          // clipBehavior: Clip.none,
          // reverse: true,
          child: Container(
            // color: Colors.blueGrey,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 235),
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    'Upload your CSV File',
                    textAlign: TextAlign.center,
                  style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                  ),

                ),
                OutlinedButton.icon(
                  icon: Icon(Icons.upload, color: textColor),
                  onPressed: () async {

                    _upload();
                    // final snackBar = SnackBar(content: Text("Data has been added."));
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  },

                  label: Text(
                    'Upload',
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
                SizedBox(height: 20),

              Container(
                // height: 300,
                // child: DataTable(
                //   columns: _data![0].map((e) => DataColumn(label: Text(e.toString()))).toList(),
                //   rows: _data!.map((e) => DataRow(cells: e.map((e) => DataCell(Text(e.toString(),),),).toList())).toList(),
                // ),



                // child: ListView.builder(
                //   itemCount: _data.length, //docs mean row
                //   // scrollDirection: Axis.vertical,
                //   shrinkWrap: true,
                //   itemBuilder: (context, index) {
                //     return Card(
                //       margin: const EdgeInsets.all(3),
                //       color: index == 0 ? Colors.blueGrey : Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(15.0),
                //       ),
                //       // color: pinkColor,
                //       // elevation: 10,
                //       child: ListTile(
                //         leading: Text(_data[index][0].toString(), textAlign: TextAlign.center,
                //           style: TextStyle(fontSize: index == 0? 18 : 15, fontWeight: index == 0? FontWeight.bold : FontWeight.normal, color: index == 0? Colors.red : Colors.black),),
                //         title: Text(_data[index][3].toString(), textAlign: TextAlign.center,
                //           style: TextStyle(fontSize: index == 0? 18 : 15, fontWeight: index == 0? FontWeight.bold : FontWeight.normal, color: index == 0? Colors.red : Colors.black)
                //       ),
                //         trailing: Text(_data[index][4].toString(), textAlign: TextAlign.center,
                //             style: TextStyle(fontSize: index == 0? 18 : 15, fontWeight: index == 0? FontWeight.bold : FontWeight.normal, color: index == 0? Colors.red : Colors.black)
                //         ),
                //       ),
                //     );
                //   },
                // ),


              ),
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
                          color: textColor,
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          // focusColor: textColor,
                          border: OutlineInputBorder(
                                borderSide: BorderSide(color: textColor, width: 32.0),
                                borderRadius: BorderRadius.circular(15.0)),
                            prefixIcon: Icon(
                                Icons.numbers,
                              color: textColor,
                            ),
                            labelText: "Batch Number",
                            labelStyle: TextStyle(
                                color: textColor,
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
                        cursorColor: textColor,
                        style: TextStyle(
                          color: textColor,
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
                              color: textColor,
                            ),
                            labelText: "Light Level(Lumens)",
                            labelStyle: TextStyle(
                          color: textColor,
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
                        cursorColor: textColor,
                        style: TextStyle(
                          color: textColor,
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
                              color: textColor,
                            ),
                            labelText: "Room Temperature",
                            labelStyle: TextStyle(
                              color: textColor,
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
                        cursorColor: textColor,
                        style: TextStyle(
                          color: textColor,
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
                                color: textColor,
                            ),
                            labelText: "Humidity(Milibar)",
                            labelStyle: TextStyle(
                              color: textColor,
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
                      RichText(
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

                      SizedBox(height: 20,),
                      OutlinedButton.icon(
                        icon: Icon(Icons.query_stats, color: textColor),
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


                          setState(() {
                            shuta = (json['Prediction'][0]);
                          });

                          // output = decoded['Prediction'];
                          // print(output);


                          // print(r.body.toString() + " is r.body");
                          // var bo = json.decode(json.encode(r.body));
                          // print(bo + " is bo");

                          createData(batchNumber: batchNumber, lightLevel: lightLevel, roomTemp: roomTemp, humidity: humidity, outcome: outcome, datetime: datetime);

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

                      SizedBox(height: 20),

                    ],
                  ),
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
    final file_result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if(file_result == null) return;
    print(file_result.files.first.name + " is file_result.files.first.name");
    filePath = file_result.files.first.path!;
    print(filePath.toString() + " is filePath");

    final inputs = File(filePath!).openRead();
    final fields = await inputs.transform(utf8.decoder).transform(const CsvToListConverter()).toList();
    print(fields.toString() + " is fields");
    print(fields[0].toString() + " is fields[0]");
    print(fields[0][1].toString() + " is fields[0][1]");
    print(fields[1].toString() + " is fields[1] ");

    setState(() {
      _data = fields;
    });

  }

  double getHeight() {
    double siz = MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight);
    print(siz.toString() + " size without the appbar");
    return siz;
  }

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


}

//class _inputstate

