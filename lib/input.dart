import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

import 'package:ml_algo/ml_algo.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_preprocessing/ml_preprocessing.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:ml_dataframe/ml_dataframe.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart'; // For google maps

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
  FocusNode _focusNode = new FocusNode();
  final user = FirebaseAuth.instance.currentUser!;
  final String userID = FirebaseAuth.instance.currentUser!.uid;
  String greetings = '';
  final formKey = GlobalKey<FormState>();
  DateTime datetime = DateTime(2022, 6, 26);
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
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        child: SingleChildScrollView(
          // clipBehavior: Clip.none,
          // reverse: true,
          child: Container(
            color: bgCard,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 235),
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(height: 50),
                // Center(
                //   child: Text(
                //     "Enter your data",
                //     style: TextStyle(
                //       color: Color(0xffdbc791),
                //       fontWeight: FontWeight.bold,
                //       fontSize: 30,
                //     ),
                //
                //   ),
                // ),
                // Center(
                //   child: Text(
                //       //greetings,
                //     final_response,
                //     style: TextStyle(
                //       color: Color(0xffdbc791),
                //       fontWeight: FontWeight.bold,
                //       fontSize: 30,
                //     ),
                //   ),
                // ),
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

                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SizedBox(height: 50),
                      // Text(
                      //   'Greetings: ' + greetings,
                      //   style: TextStyle(
                      //     color: Color(0xffdbc791),
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 30,
                      //   ),
                      // ),
                      Container(
                        // child: (
                        // //start
                        //     ElevatedButton.icon(
                        //       style: ElevatedButton.styleFrom(
                        //           minimumSize: Size.fromHeight(50)),
                        //       icon: Icon(Icons.add),
                        //       label: Text(
                        //         'Press',
                        //         style: TextStyle(
                        //             fontSize: 24,
                        //             color: Colors.black
                        //         ),
                        //       ),
                        //       onPressed: () async {
                        //
                        //         try{
                        //           final url = 'http://127.0.0.1:53838/greet';
                        //           final response = await http.get(Uri.parse(url));
                        //           final decoded = json.decode(response.body) as Map<String, dynamic>;
                        //
                        //           setState(() {
                        //             greetings = decoded['greetings'];
                        //           });
                        //         }catch(err){
                        //           print(err);
                        //         }
                        //       },
                        //     )
                        // //end
                        // ),
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
                        icon: Icon(Icons.save, color: textColor),
                        onPressed: () async {

                          final int batchNumber = int.parse(
                              batchController.text);
                          final double lightLevel = double.parse(
                              lightLevelController.text);
                          final double roomTemp = double.parse(
                              roomTemperatureController.text);
                          final double humidity = double.parse(
                              roomHumidityController.text);
                          final String outcome = (productionController.text);
                          final DateTime datetime = DateTime.now();

                          //final uid = await Provider.of(context).auth.getCurrentId();
                          //print(uid + "This is the uid bitch!");
                          //final user = User(batchNumber: double.parse(batchController.text), lightLevel: double.parse(lightLevelController.text), roomTemp: double.parse(roomTemperatureController.text), humidity: double.parse( roomHumidityController.text), outcome: productionController.text, datetime: datetime);
                          //final user = User(batchNumber: double.parse(_batchController.text), lightLevel: double.parse(_lightLevelController.text), roomTemp: double.parse(_roomTemperatureController.text), humidity: double.parse( _roomHumidityController.text), outcome: _productionController.text, datetime: datetime);
                          //final user = User( batchNumber: batchNumber, lightLevel: lightLevel, roomTemp: roomTemp, humidity: humidity, outcome: outcome, datetime: datetime);
                          createData(batchNumber: batchNumber, lightLevel: lightLevel, roomTemp: roomTemp, humidity: humidity, outcome: outcome, datetime: datetime);

                          // final url = 'http://127.0.0.1:5000/name';
                          // final response = await http.post(url, body: json.encode({'name' : name}));
                          // final response = await http.get(url, body: json.encode({'name' : name}));
                          //
                          // final decode = json.decode(response.body) as Map<String, dynamic>;


                          //final response = await http.get('http://127.0.0.1:5000/name');
                          //final decoded = json.decode(response.body) as Map<String, dynamic>;

                          // setState((){
                          //   final_response = decoded['response'];
                          // });
                          //
                          // setState((){
                          //   greetings = decoded['greetings'];
                          // });
                          //var data = postData(batchNumber, lightLevel, roomTemp, humidity, outcome, datetime );

                          batchController.text = '';
                          lightLevelController.text = '';
                          roomTemperatureController.text = '';
                          roomHumidityController.text = '';
                          productionController.text = '';

                          final snackBar = SnackBar(content: Text("Data has been added."));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        },

                        label: Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 24,
                            color: textColor,
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

  Future createData({required int batchNumber, required double lightLevel, required double roomTemp, required double humidity, required String outcome, required DateTime datetime}) async {
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

    final user  = Users(
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

  // void _requestFocus() {
  //   setState(() {
  //     FocusScope.of(context).requestFocus(_focusNode);
  //   });
  // }
}//class _inputstate

class Users {
  final String id;
  final int batchNumber;
  final double lightLevel;
  final double roomTemp;
  final double humidity;
  final String outcome;
  final DateTime datetime;

  Users({
    required this.id,
    required this.batchNumber,
    required this.lightLevel,
    required this.roomTemp,
    required this.humidity,
    required this.outcome,
    required this.datetime,
});

  Map<String, dynamic> toJson() => { //Converts object to JSON
      'id': id,
      'batchNumber': batchNumber,
      'lightLevel': lightLevel,
      'roomTemp': roomTemp,
      'humidity': humidity,
      'outcome': outcome,
      'datetime': datetime,
  };

  static Users fromJson (Map<String, dynamic> json) => Users(
    id: json['id'],
    batchNumber: json['batchNumber'],
    lightLevel: json['lightLevel'],
    roomTemp: json['roomTemp'],
    humidity: json['humidity'],
    outcome: json['outcome'],
    datetime: json['datetime'],
  );//Converts object to JSON


  // Future<http.Response>postData(int batchNumber, double lightLevel, double roomTemp, double humidity, String outcome,DateTime datetime ){
  //   return http.post(
  //     'http://0.0.0.0:5000/',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'batchNumber': batchNumber,
  //       'lightLevel': lightLevel,
  //       'roomTemp': roomTemp,
  //       'humidity': humidity,
  //       'outcome': outcome,
  //       'datetime' : datetime,
  //     }),
  //   );
  // }

}

