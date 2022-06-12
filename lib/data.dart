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
  }
  //await _mushroom.add({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.update({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.doc({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });


  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _mushroom.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          if(streamSnapshot.hasData){
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                );
          }
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
