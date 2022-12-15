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
    Get_Dataset();
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
                        icon: Icon(Icons.query_stats, color: textColor),
                        onPressed: () async {

                          final preprocess = Get_Dataset();

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

                          var data = {
                            'id' : userID,
                            'batchNumber': batchController.text,
                            'lightLevel': lightLevelController.text,
                            'roomTemp': roomTemperatureController.text,
                            'humidity': roomHumidityController.text,
                            'outcome': 'ewan',
                            'datetime': datetime,
                             // 'IDUser': batchController.text,
                             // 'profilePath':
                             // 'name',
                             // 'email',
                             // 'about',
                             // 'coverPath',
                             // 'lastMessageTime',
                          };

                          //Passing the data and the endpoint
                          var r = await CallApi().postData(data, 'predict');

                          // url = 'http://10.0.2.2:5000/api?query=' + value.toString();
                          // urls = 'http://127.0.0.1:5000/api?query=2';
                          // d = await fetchData(url);
                          // var decoded = jsonDecode(d);
                          // setState(() {
                          //   pred = decoded['output'];
                          // });



                          //final uid = await Provider.of(context).auth.getCurrentId();
                          //print(uid + "This is the uid bitch!");
                          //final user = User(batchNumber: double.parse(batchController.text), lightLevel: double.parse(lightLevelController.text), roomTemp: double.parse(roomTemperatureController.text), humidity: double.parse( roomHumidityController.text), outcome: productionController.text, datetime: datetime);
                          //final user = User(batchNumber: double.parse(_batchController.text), lightLevel: double.parse(_lightLevelController.text), roomTemp: double.parse(_roomTemperatureController.text), humidity: double.parse( _roomHumidityController.text), outcome: _productionController.text, datetime: datetime);
                          //final user = User( batchNumber: batchNumber, lightLevel: lightLevel, roomTemp: roomTemp, humidity: humidity, outcome: outcome, datetime: datetime);

                          // final dataFrame = await fromCsv('/Users/loutherolayres/mush2 9.10.15 AM trashing/assets/MyDataSetCSV2.csv',
                          //     columns: [2, 3, 5, 6, 7, 11]);

                          // final dataFrame = await fromCsv('/Users/loutherolayres/mush2 9.10.15 AM trashing/assets/MyDataSetCSV2.csv');
                          // print(dataFrame);
                          // final targetColumnName = 'outcome';
                          // final splits = splitData(dataFrame, [0.7]);
                          // final trainData = splits.first;
                          // final testData = splits.last;

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

                          // final interpreter = await Interpreter.fromAddress('.tflite');
                          // var input = [
                          //   [1.0,1.0,1.0]
                          // ];
                          // var output = List.filled(1, 0).reshape([1,1]);
                          // interpreter.run(input, output);



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

  Get_Dataset() async {
    final dataFrame2 = await fromCsv('MyDataSetCSV2.csv');
    // final dataFrame = getWineQualityDataframe();
    // final dataFrame = await fromCsv('/Users/loutherolayres/Documents/MyDataSetCSV2.csv.csv',
    //     columns: [2,3]);
    // final dataFrame = await fromCsv('/Users/loutherolayres/mush2 9.10.15 AM trashing/assets/MyDataSetCSV2.csv');
    // final dataFrame2 = await fromCsv('MyDataSetCSV2.csv');

    // final dataFrame = await fromCsv('assets/MyDataSetCSV2.csv');
    print(dataFrame2);
    final targetColumnName = 'outcome';
    final splits = splitData(dataFrame2, [0.7]);
    final splits2 = splitData(dataFrame2, [0.7]);
    final trainData = splits.first;
    final testData = splits.last;



  }

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
  final String _url = "http://127.0.0.1:5000/";

  postData(data, apiurl) async {
    var fullUrl = _url+apiurl;
    http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders(),
    );
  }

  _setHeaders() => {
    'Content-type':'application/json',
    'Accept': 'application/json',
  };


}

//class _inputstate



//child: StreamBuilder(
//         // stream: _mushroom.snapshots(), //persistent connection to the database
//         stream: FirebaseFirestore.instance.collection('mushroom')
//               .where("id", isEqualTo: currentUser.currentUser!.uid) //id should match the id field in the database
//               .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){ //streamSnapshot: all data available on the database
//           if(streamSnapshot.hasData){
//             return ListView.builder(
//                 itemCount: streamSnapshot.data!.docs.length, //docs mean row
//                 itemBuilder: (context, index) {
//                   final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
//                   // date = documentSnapshot['date'].toString() as DateTime;
//                   //DateTime myDateTime = DateTime.parse(date.toDate().toString());
//                   return Card(
//                     margin: const EdgeInsets.all(15),
//                     shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                     ),
//                   color: pinkColor,
//                   elevation: 10,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       ListTile(
//
//                         // leading: Icon(
//                         //   Icons.numbers,
//                         //   size: 50,
//                         //   color:  textColor,
//                         // ),
//                         title: RichText(
//                           text: TextSpan(
//                             //style: Theme.of(context).textTheme.body1,
//                             children: [
//                               // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
//                               WidgetSpan(
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                                   child: Icon(Icons.numbers, color: textColor, size: 30,),
//                                 ),
//                               ),
//                               TextSpan(text:  "Batch: " + documentSnapshot['batchNumber'].toString(),
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 30,
//                                   color: textColor,
//
//                                 ),),
//                             ],
//                           ),
//                         ),
//
//                           subtitle: Container(
//
//                             // padding: const EdgeInsets.all(12),
//                             // decoration: BoxDecoration(
//                             //   color: Colors.grey.shade200,
//                             //   borderRadius: BorderRadius.circular(20),
//                             //   border: Border.all(color: Colors.grey),
//                             // ),
//                             margin: EdgeInsets.fromLTRB(0, 0 , 0, 0),
//                             child: Column(
//
//                               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: 10),
//                                 Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: RichText(
//                                     text: TextSpan(
//                                       //style: Theme.of(context).textTheme.body1,
//                                       children: [
//                                         // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
//                                         WidgetSpan(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                                             child: Icon(Icons.lightbulb, color: textColor),
//                                           ),
//                                         ),
//                                         TextSpan(text: "Light Level: " + documentSnapshot['lightLevel'].toString(),
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.normal,
//                                             fontSize: 15,
//                                             color: textColor,
//                                           ),),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: RichText(
//                                     text: TextSpan(
//                                       //style: Theme.of(context).textTheme.body1,
//                                       children: [
//                                         // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
//                                         WidgetSpan(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                                             child: Icon(Icons.thermostat, color: textColor),
//                                           ),
//                                         ),
//                                         TextSpan(text: "Room Temp: " + documentSnapshot['roomTemp'].toString(),
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.normal,
//                                             fontSize: 15,
//                                             color: textColor,
//                                           ),),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: RichText(
//                                     text: TextSpan(
//                                       //style: Theme.of(context).textTheme.body1,
//                                       children: [
//                                         // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
//                                         WidgetSpan(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                                             child: Icon(Icons.water_drop, color: textColor),
//                                           ),
//                                         ),
//                                         TextSpan(text:   "Humidity: " +documentSnapshot['humidity'].toString(),
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.normal,
//                                             fontSize: 15,
//                                             color: textColor,
//                                           ),),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: RichText(
//                                     text: TextSpan(
//                                       //style: Theme.of(context).textTheme.body1,
//                                       children: [
//                                         // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
//                                         WidgetSpan(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                                             child: Icon(Icons.info, color: textColor),
//                                           ),
//                                         ),
//                                         TextSpan(text:   "Outcome: " +documentSnapshot['outcome'].toString(),
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.normal,
//                                             fontSize: 15,
//                                             color: textColor,
//                                           ),),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: RichText(
//                                     text: TextSpan(
//                                       //style: Theme.of(context).textTheme.body1,
//                                       children: [
//                                         // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
//                                         WidgetSpan(
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                                             child: Icon(Icons.date_range, color: textColor),
//                                           ),
//                                         ),
//                                         TextSpan(text:   "Date: " + documentSnapshot['datetime'].toString(),
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.normal,
//                                             fontSize: 15,
//                                             color: textColor,
//                                           ),),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//                               ],
//                             )
//
//                               ),//Subtitle
//
//                         ),
//                       Center(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ButtonBar(
//                               children: [
//                                 IconButton(
//                                     icon:  Icon(Icons.edit, color: textColor ),
//                                     onPressed: () => _update(documentSnapshot)),
//                                 IconButton(
//                                     icon:  Icon(Icons.delete, color: textColor),
//                                     onPressed: () => _delete(documentSnapshot.id)),
//
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                   );
//                 },
//                 );
//
//
//           }//widget build
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),


