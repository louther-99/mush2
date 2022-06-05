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
                        onPressed: () {}
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
}
