import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:mush2/Utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  State<Data> createState() => _DataState();

}

class _DataState extends State<Data> {

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
            'You have successfully deleted a product'
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

                    final double? batchNumber = double.tryParse(
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
    return Container(
      child: StreamBuilder(
        stream: _mushroom.snapshots(), //persistent connection to the database
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){ //streamSnapshot: all data available on the database
          if(streamSnapshot.hasData){
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length, //docs mean row
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                  // date = documentSnapshot['date'].toString() as DateTime;
                  //DateTime myDateTime = DateTime.parse(date.toDate().toString());
                  return Card(
                    margin: const EdgeInsets.all(10),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Light Level: " + documentSnapshot['lightLevel'].toString()),
                            Text("Room Temp: " + documentSnapshot['roomTemp'].toString()),
                            Text("Humidity: " +documentSnapshot['humidity'].toString()),
                            Text("Outcome: " +documentSnapshot['outcome'].toString()),
                            Text("Date: " + documentSnapshot['datetime'].toString()),
                            // Text("Date: "  + date ),
                          ],

                        )


                          ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
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
  }




}
