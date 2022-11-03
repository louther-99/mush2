import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:mush2/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mush2/model/user.dart';

import 'package:mush2/utils/colors.dart';

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  State<Data> createState() => _DataState();

}

class _DataState extends State<Data> {

  Stream<List<Users>> readUser() => FirebaseFirestore.instance
      .collection('mushroom')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) =>Users.fromJson(doc.data())).toList());



  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // FirebaseUser user = await FirebaseAuth.instance.currentUser(); i
  final String userID = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser!;
  // final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  // final FirebaseUser user = await auth.currentUser();
  // FirebaseUser user = await FirebaseAuth.getInstance().getCurrentUser();
  // FirebaseUser user = await FirebaseAuth.instance.currentUser();

  final CollectionReference _mushroom = FirebaseFirestore.instance.collection('mushroom');
  DateTime datetime = DateTime(2022, 6, 26);
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _lightLevelController = TextEditingController();
  final TextEditingController _roomTemperatureController = TextEditingController();
  final TextEditingController _roomHumidityController = TextEditingController();
  final TextEditingController _productionController = TextEditingController();
  // final TextEditingController _dateController = TextEditingController();

//final CollectionReference _mushroom = FirebaseFirestore.instance.collection('mushroom');

  //await _mushroom.add({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.update({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.doc({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.doc(productId).delete();

  // Future <void> _create([DocumentSnapshot? documentSnapshot]) async {
  //   if(documentSnapshot != null){
  //     _batchController.text = documentSnapshot['batch'].toString();
  //     _lightLevelController.text = documentSnapshot['lightLevel'].toString();
  //     _roomTemperatureController.text = documentSnapshot['roomTemp'].toString();
  //     _roomHumidityController.text = documentSnapshot['humidity'].toString();
  //     _productionController.text = documentSnapshot['outcome'].toString();
  //     // _dateController.text = documentSnapshot['date'].toString();
  //   }
  //
  // } //Future void _create


  Future <void> _delete(String productId ) async {
    await _mushroom.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'You have successfully deleted a record'
        )));
  }

  Future <void> _update([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null){
      _batchController.text = documentSnapshot['batchNumber'].toString();
      _lightLevelController.text = documentSnapshot['lightLevel'].toString();
      _roomTemperatureController.text = documentSnapshot['roomTemp'].toString();
      _roomHumidityController.text = documentSnapshot['humidity'].toString();
      _productionController.text = documentSnapshot['outcome'].toString();
      // _dateController.text = documentSnapshot['date'].toString();

    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx){
          return Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                //prevent keyboard from covering the text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20
              ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  controller: _batchController,
                  decoration: const InputDecoration(labelText: "Batch"),
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  controller: _lightLevelController,
                  decoration: const InputDecoration(labelText: "Light Level"),
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  controller: _roomTemperatureController,
                  decoration: const InputDecoration(labelText: "Room Temperature"),
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  controller: _roomHumidityController,
                  decoration: const InputDecoration(labelText: "Humidity"),
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  controller: _productionController,
                  decoration: const InputDecoration(labelText: "Production"),
                ),
                ElevatedButton(
                  child: Text("Select Date"),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: datetime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),


                    );
                    if (newDate == null) return;

                    setState(() => datetime = newDate);
                  }

                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {

                    final int? batchNumber = int.tryParse(
                        _batchController.text);
                    final double? lightLevel = double.tryParse(
                        _lightLevelController.text);
                    final double? roomTemp = double.tryParse(
                        _roomTemperatureController.text);
                    final double? humidity = double.tryParse(
                        _roomHumidityController.text);
                    final String? outcome = (_productionController.text);

                    if(batchNumber != null){
                      await _mushroom.doc(documentSnapshot!.id).update({"batchNumber": batchNumber, "lightLevel": lightLevel, "roomTemp": roomTemp, "humidity": humidity, "outcome": outcome, "datetime": datetime });
                      _batchController.text = '';
                      _lightLevelController.text = '';
                      _roomTemperatureController.text = '';
                      _roomHumidityController.text = '';
                      _productionController.text = '';



                    }
                  },

                ),
              ],
            ),
          );
        }
    );
  } //Future update void



  //await _mushroom.add({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.update({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.doc({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });




  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;
    return Container(
      color: bgCard,
      // margin: EdgeInsets.fromLTRB(0, 0, 0, 115),

      // child: StreamBuilder(
      //   stream: readUser(),
      //   builder: (context, snapshot){ //streamSnapshot: all data available on the database
      //     if(snapshot.hasError) {
      //       return Text('${snapshot.error}');
      //     }
      //     else if(snapshot.hasData){
      //       final users = snapshot.data!;
      //
      //       return ListView(
      //       children: users.map(buildUser).toList(),
      //       );
      //
      //       }
      //     //widget build
      //       return const Center(
      //           child: CircularProgressIndicator(),
      //
      //     );
      //   },
      // ),


      child: StreamBuilder(
        // stream: _mushroom.snapshots(), //persistent connection to the database
        stream: FirebaseFirestore.instance.collection('mushroom')
              .where("id", isEqualTo: currentUser.currentUser!.uid)
              .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){ //streamSnapshot: all data available on the database
          if(streamSnapshot.hasData){
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length, //docs mean row
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  // date = documentSnapshot['date'].toString() as DateTime;
                  //DateTime myDateTime = DateTime.parse(date.toDate().toString());
                  return Card(
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      title: Wrap(
                        spacing: 32,
                        runSpacing: 32,
                        children: [
                          Center(
                            //padding: const EdgeInsets.all(8.0),
                            child: Text("Batch Number: " + documentSnapshot['batchNumber'].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          ),

                        ],
                      ),
                      subtitle: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Light Level: " + documentSnapshot['lightLevel'].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Room Temp: " + documentSnapshot['roomTemp'].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Humidity: " +documentSnapshot['humidity'].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Outcome: " +documentSnapshot['outcome'].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Date: " + documentSnapshot['datetime'].toString()),
                            ),

                          ],
                        )


                          ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _delete(documentSnapshot.id)),

                          ],
                        ),
                      ),

                    ),
                  );
                },
                );


          }//widget build
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),


    );
    // return Container(
    //   child: Text(user.uid),
    // );
  }
  // Widget buildUser (Users user ) => ListTile(
  //   leading: CircleAvatar(
  //     child: Text(
  //       '${user.id}',
  //     ),
  //   ),
  //   title: Text(
  //     '${user.batchNumber}',
  //   ),
  //   subtitle: Text(
  //     '${user.datetime}',
  //   ),
  // );
}
