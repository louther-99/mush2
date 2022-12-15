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
import 'package:tflite_flutter/tflite_flutter.dart';
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
import 'package:tflite_flutter/tflite_flutter.dart';

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
import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:chaquopy/chaquopy.dart';
import 'package:csv/csv.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:http/http.dart';

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
        // height: ,
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
                    'Input Data',
                    textAlign: TextAlign.center,
                  style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                  ),

                ),
                SizedBox(height: 20),
                Center(
                  child: TextField(
                    onChanged: (value) {
                      // url = 'http://127.0.0.1:5000/api?query=' + value.toString();
                      url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                    },
                  ),

                ),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      data = await fetchData(url);
                      var decoded = jsonDecode(data);
                      setState(() {
                        output = decoded['output'];
                      });
                    },
                    child: Text("Fetch Api Value"),
                  ),
                ),
                Center(
                  child: Text(
                    output,
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SizedBox(height: 50),
                      Text(
                        'Greetings: ' + greetings,
                        style: TextStyle(
                          color: Color(0xffdbc791),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Container(
                        child: (
                        //start
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(50)),
                              icon: Icon(Icons.add),
                              label: Text(
                                'Press',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black
                                ),
                              ),
                              onPressed: () async {

                                try{
                                  final String urlp = "http://10.0.2.2:5000/print";
                                  final responses = await http.get(Uri.parse(urlp));
                                  print(responses.body + " is body bitch!");
                                  // final url = 'http://127.0.0.1:5000/print';
                                  // final response = await http.get(Uri.parse(url));

                                  final decoded = json.decode(json.encode(responses.body));// as Map<String, dynamic>;
                                  print(decoded + " is decoded");

                                  setState(() {
                                    greetings = decoded;
                                    // decoded;
                                  });
                                }catch(err){
                                  print(err);
                                }
                              },
                            )
                        //end
                        ),
                      ),

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
                            'id' : userID,
                            'batchNumber': batchController.text,
                            'lightLevel': lightLevelController.text,
                            'roomTemp': roomTemperatureController.text,
                            'humidity': roomHumidityController.text,
                            'outcome': 'ewan',
                            'datetime': datetime,
                          };
                          
                          

                          
                          // var c = await http.get(
                          //   // Uri.parse(fullUrl),
                          //   Uri.parse("http://127.0.0.1:5000/print"),
                          //   // body: jsonEncode(datas),
                          //   // headers: _setHeaders(),
                          // );
                          //
                          // if(c.statusCode == 200){
                          //   var json = c.body;
                          //   print(json);
                          // }

                          //Passing the data and the endpoint
                          // var r = await CallApi().postData(datas, 'try');
                          // var bo = json.decode(r.body);
                          // print(r);

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

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(Icons.percent, size: 24, color: textColor),
                                        ),
                                        TextSpan(
                                          text: " Accuracy:",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                          child: Icon(Icons.info, size: 24, color: textColor,),
                                        ),
                                        TextSpan(
                                          text: " Outcome:",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: textColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
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

  // void _requestFocus() {
  //   setState(() {
  //     FocusScope.of(context).requestFocus(_focusNode);
  //   });
  // }
}

class CallApi {

  postData(datas, apiurl) async {
    String _url = "http://127.0.0.1:5000/";
    String fullUrl = _url + apiurl;
    print(fullUrl + " is full url");
    var respo = await http.post(
        // Uri.parse(fullUrl),
        Uri.parse("http://127.0.0.1:5000/print"),
        body: jsonEncode(datas),
        headers: _setHeaders(),
    );

    if(respo.statusCode == 200){
      var json = respo.body;
      // print(json );
    }

  }

  _setHeaders() => {
    'Content-type':'application/json',
    'Accept': 'application/json',
  };


}

//class _inputstate

