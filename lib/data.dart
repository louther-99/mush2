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
  final batchController = TextEditingController();
  final lightLevelController = TextEditingController();
  final roomTemperatureController = TextEditingController();
  final roomHumidityController = TextEditingController();
  final productionController = TextEditingController();
  String name = "";
  String outcome = 'none';
  DateTime date = DateTime.now();

  final CollectionReference _mushroom = FirebaseFirestore.instance.collection('mushroom');

  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _lightLevelController = TextEditingController();
  final TextEditingController _roomTemperatureController = TextEditingController();
  final TextEditingController _roomHumidityController = TextEditingController();
  final TextEditingController _productionController = TextEditingController();
  String _name = "";
  String _outcome = 'none';
  DateTime _date = DateTime.now();

  Future <void> _update([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null){
      _batchController.text = documentSnapshot['batch'].toString();
      _lightLevelController.text = documentSnapshot['lightLevel'].toString();
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
                  decoration: const InputDecoration(labelText: "Batch"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    //final double batchnumber = _batchController.text;
                    final double? batchnumber = double.tryParse(_batchController.text);
                    final double? price = double.tryParse(_lightLevelController.text);
                    if(batchnumber != null){
                      await _mushroom.doc(documentSnapshot!.id).update({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
                    _batchController.text = '';
                    _lightLevelController.text = '';
                    }
                  },

                ),
              ],
            ),
          );
        }
    );
  } //Future update void

  Future <void> _create([DocumentSnapshot? documentSnapshot]) async {
    if(documentSnapshot != null){
      _batchController.text = documentSnapshot['batch'].toString();
      _lightLevelController.text = documentSnapshot['lightLevel'].toString();
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
                  decoration: const InputDecoration(labelText: "Batch"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    //final double batchnumber = _batchController.text;
                    final double? batchnumber = double.tryParse(_batchController.text);
                    final double? price = double.tryParse(_lightLevelController.text);
                    if(batchnumber != null){
                      await _mushroom.add({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
                    _batchController.text = '';
                    _lightLevelController.text = '';
                  }
                  },

                )
              ],
            ),
          );
        }
    );
  } //Future void _create
  Future <void> _delete(String productId ) async {
    await _mushroom.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'You have successfully deleted a product'
        )));
  }

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
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['batch'].toString()),
                      subtitle: Text(documentSnapshot['lightLevel'].toString()),
                      trailing: SizedBox(
                        width: 10,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _update(documentSnapshot)),
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

  // _update(DocumentSnapshot<Object?> documentSnapshot) {
  //
  // }
}
