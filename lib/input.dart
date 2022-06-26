
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
import 'package:ml_preprocessing/ml_preprocessing.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:ml_algo/ml_algo.dart';



class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final formKey = GlobalKey<FormState>();
  DateTime datetime = DateTime(2022, 6, 26);
  final TextEditingController batchController = TextEditingController();
  final TextEditingController lightLevelController = TextEditingController();
  final TextEditingController roomTemperatureController = TextEditingController();
  final TextEditingController roomHumidityController = TextEditingController();
  final TextEditingController productionController = TextEditingController();
  // final TextEditingController _dateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 120),
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(height: 50),
            Center(
              child: Text(
                "Enter your data",
                style: TextStyle(
                  color: Color(0xffdbc791),
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),

              ),
            ),
            SizedBox(height: 20),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  TextFormField(
                    controller: batchController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Batch Number"
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
                    controller: lightLevelController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Light Level(Lumens)"
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
                    controller: roomTemperatureController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Room Temperature"
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
                    controller: roomHumidityController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        labelText: "Humidity(Milibar)"
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

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    icon: Icon(Icons.add),
                    label: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black
                      ),
                    ),
                    onPressed: () async {

                      final double batchNumber = double.parse(
                          batchController.text);
                      final double lightLevel = double.parse(
                          lightLevelController.text);
                      final double roomTemp = double.parse(
                          roomTemperatureController.text);
                      final double humidity = double.parse(
                          roomHumidityController.text);
                      final String outcome = (productionController.text);
                      final DateTime datetime = DateTime.now();
                      //final user = User(batchNumber: double.parse(batchController.text), lightLevel: double.parse(lightLevelController.text), roomTemp: double.parse(roomTemperatureController.text), humidity: double.parse( roomHumidityController.text), outcome: productionController.text, datetime: datetime);
                      //final user = User(batchNumber: double.parse(_batchController.text), lightLevel: double.parse(_lightLevelController.text), roomTemp: double.parse(_roomTemperatureController.text), humidity: double.parse( _roomHumidityController.text), outcome: _productionController.text, datetime: datetime);
                      final user = User(batchNumber: batchNumber, lightLevel: lightLevel, roomTemp: roomTemp, humidity: humidity, outcome: outcome, datetime: datetime);
                      createData(batchNumber: batchNumber, lightLevel: lightLevel, roomTemp: roomTemp, humidity: humidity, outcome: outcome, datetime: datetime);


                        batchController.text = '';
                        lightLevelController.text = '';
                        roomTemperatureController.text = '';
                        roomHumidityController.text = '';
                        productionController.text = '';

                    },
                  ),
                  SizedBox(height: 20),

                ],
              ),
            ),

          ],
        ),

      ),
    );
  }

  Future createData({required double batchNumber, required double lightLevel, required double roomTemp, required double humidity, required String outcome, required DateTime datetime}) async {
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

    final user  = User(
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
}//class _inputstate

class User {
  final double batchNumber;
  final double lightLevel;
  final double roomTemp;
  final double humidity;
  final String outcome;
  final DateTime datetime;

  User({
    required this.batchNumber,
    required this.lightLevel,
    required this.roomTemp,
    required this.humidity,
    required this.outcome,
    required this.datetime,
});

  Map<String, dynamic> toJson() => {
      'batchNumber': batchNumber,
      'lightLevel': lightLevel,
      'roomTemp': roomTemp,
      'humidity': humidity,
      'outcome': outcome,
      'datetime': datetime,
  };


}

