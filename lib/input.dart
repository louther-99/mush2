import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final formKey = GlobalKey<FormState>();
  final batchController = TextEditingController();
  final lightLevelController = TextEditingController();
  final roomTemperatureController = TextEditingController();
  final roomHumidityController = TextEditingController();
  final productionController = TextEditingController();
  String name = "";
  String outcome = 'none';
  DateTime date = DateTime.now();
  
  final CollectionReference _mushroom = FirebaseFirestore.instance.collection('mushroom');

  //await _mushroom.add({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.update({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.doc({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        padding: const EdgeInsets.only(left:40, right: 40),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
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
              SizedBox(height: 50),
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
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                      SizedBox(height: 20),

                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight (50)),
                        icon: Icon(Icons.lock),
                        label: Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black
                          ),
                        ),
                        onPressed: () {
                          //final user = User(name: co)
                          //createUser();
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight (50)),
                          icon: Icon(Icons.lock),
                          label: Text(
                            'Reset',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black
                            ),
                          ),
                          onPressed: () {}
                      ),

                    ],
                  )
              ),

            ],
          ),
        )

    );
  }

  Future createUser() async{
    final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');

    // final json = { //a map
    //   'name': name,
    //   'age': 21,
    //   'birthday': DateTime(2001,7,28),
    // };

    final user = User(
      id: docUser.id,
      name: name,
      age: 21,
      birthday: DateTime(2001,7,28),
    );
    final json = user.toJson();

    //Create document and write data to firebase
    await docUser.set(json);

  }//createUser()
}

class User{
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
});

  //To convert to json
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'age': age,
    'birthday': birthday,
  };
}
