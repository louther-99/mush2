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
import 'package:mush2/model/mushroomData.dart';
import 'package:mush2/searchWidget.dart';
import 'package:mush2/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  State<Data> createState() => _DataState();

}

class _DataState extends State<Data> {
  FocusNode _focus = FocusNode();
  bool hasFocus = false;
  bool hasData = false;
  var count = 0;
  int bitch = 0;
  late int passMe = 0;

  Stream<List<MushroomData>> readUser() => FirebaseFirestore.instance
      .collection('mushroom')
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) =>MushroomData.fromJson(doc.data())).toList());



  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // FirebaseUser user = await FirebaseAuth.instance.currentUser(); i
  final String userID = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser!;

  // final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  // final FirebaseUser user = await auth.currentUser();
  // FirebaseUser user = await FirebaseAuth.getInstance().getCurrentUser();
  // FirebaseUser user = await FirebaseAuth.instance.currentUser();

  final CollectionReference _mushroom = FirebaseFirestore.instance.collection('mushroom');
  final TextEditingController _batchController = TextEditingController();
  final TextEditingController _lightLevelController = TextEditingController();
  final TextEditingController _roomTemperatureController = TextEditingController();
  final TextEditingController _roomHumidityController = TextEditingController();
  final TextEditingController _productionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  DateTime datetime = DateTime.now();
  DateTime newDated = DateTime.now();
  String s = "";


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

  Future <void> _update([DocumentSnapshot? documentSnapshot]) async { //Function to update
    if(documentSnapshot != null){
      _batchController.text = documentSnapshot['batchNumber'].toString();
      _lightLevelController.text = documentSnapshot['lightLevel'].toString();
      _roomTemperatureController.text = documentSnapshot['roomTemp'].toString();
      _roomHumidityController.text = documentSnapshot['humidity'].toString();
      _productionController.text = documentSnapshot['outcome'].toString();
      _dateController.text = documentSnapshot['datetime'].toString();

    }

    await showModalBottomSheet( //Modal for updating, deleting
        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.only(topLeft:
          Radius.circular(24),topRight:Radius.circular(24) ),),
        isScrollControlled: true,
        context: context,
        backgroundColor: bgCard,
        builder: (BuildContext ctx){
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);

              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Padding(
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
                      cursorColor: textColor,style: TextStyle(
                      color: textColor,
                    ),
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
                    ),
                    SizedBox(height: 20),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      controller: _lightLevelController,
                      cursorColor: textColor,
                      style: TextStyle(
                        color: textColor,
                      ),
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
                    ),
                    SizedBox(height: 20),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      controller: _roomTemperatureController,
                      cursorColor: textColor,
                      style: TextStyle(
                        color: textColor,
                      ),
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
                    ),
                    SizedBox(height: 20),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      controller: _roomHumidityController,
                      cursorColor: textColor,
                      style: TextStyle(
                        color: textColor,
                      ),
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
                    ),
                    SizedBox(height: 20),
                    TextField(
                      readOnly: true,
                      enabled: false,
                      cursorColor: textColor,
                      style: TextStyle(
                        color: textColor,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      controller: _productionController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor, width: 32.0),
                              borderRadius: BorderRadius.circular(15.0)),
                          prefixIcon: Icon(
                            Icons.info,
                            color: textColor,
                          ),
                          labelText: "Production",
                          labelStyle: TextStyle(
                            color: textColor,
                          )
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      // readOnly: true,
                      // enabled: false,
                      cursorColor: textColor,
                      style: TextStyle(
                        color: textColor,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      controller: _dateController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor, width: 32.0),
                              borderRadius: BorderRadius.circular(15.0)),
                          prefixIcon: Icon(
                            Icons.date_range,
                            color: textColor,
                          ),
                          labelText: "Date",
                          labelStyle: TextStyle(
                            color: textColor,
                          )
                      ),
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: datetime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );

                        final dat = DateFormat('MM-dd-yyyy KK:mm:ss a').format(newDate!);
                        s = dat;
                        if (s == null)
                          {
                            s = _dateController.text;
                          }


                        setState((){
                          _dateController.text = dat;
                        });
                      },
                    ),
                    SizedBox(height: 30),

                    // OutlinedButton.icon(
                    //   icon: Icon(Icons.date_range, color: textColor),
                    //   onPressed: () async {
                    //     DateTime? newDate = await showDatePicker(
                    //     context: context,
                    //     initialDate: datetime,
                    //     firstDate: DateTime(2000),
                    //     lastDate: DateTime(2100),
                    //     );
                    //     if (newDate == null) return;
                    //     // final datetime = DateFormat('MM-dd-yyyy KK:mm:ss').format(DateTime.now());
                    //     final dat = DateFormat('MM-dd-yyyy KK:mm:ss a').format(newDate);
                    //     s = dat;
                    //     final dt1 = DateTime.tryParse(dat);
                    //     // setState(() => datetime = dt1!);
                    //     setState((){
                    //       datetime = dat.toString() as DateTime;
                    //       _dateController.text = dat.toString();
                    //     });
                    //     },
                    //   label: Text(
                    //     'Select Date',
                    //     style: TextStyle(
                    //       fontSize: 24,
                    //       color: textColor,
                    //     ),
                    //   ),
                    //   style: OutlinedButton.styleFrom(
                    //     shape: StadiumBorder(),
                    //     minimumSize: Size.fromHeight (40),
                    //     backgroundColor: bgCard,
                    //   ),
                    //
                    // ),


                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton.icon(
                      icon: Icon(Icons.update, color: textColor),
                      label: Text(
                        'Update',
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


                        String? myNewDate = s;
                        if(myNewDate == null){
                          print("myNewDate == null");
                          myNewDate = _dateController.text;
                        }
                        if(myNewDate == ""){
                          print("myNewDate == empty string");
                          myNewDate = _dateController.text;
                        }


                        //
                        // if (s == null)
                        //   {
                        //     print("S is null and s is: " + s );
                        //     if(batchNumber != null){
                        //       await _mushroom.doc(documentSnapshot!.id).update({"batchNumber": batchNumber, "lightLevel": lightLevel, "roomTemp": roomTemp, "humidity": humidity, "outcome": outcome, "datetime": _dateController.text});
                        //       _batchController.text = '';
                        //       _lightLevelController.text = '';
                        //       _roomTemperatureController.text = '';
                        //       _roomHumidityController.text = '';
                        //       _productionController.text = '';
                        //       _dateController.text  = " ";
                        //
                        //
                        //     }
                        //   }
                        if(batchNumber != null){
                          print("S is not null and s is " + s);
                          await _mushroom.doc(documentSnapshot!.id).update({"batchNumber": batchNumber, "lightLevel": lightLevel, "roomTemp": roomTemp, "humidity": humidity, "outcome": outcome, "datetime": myNewDate});
                          _batchController.text = '';
                          _lightLevelController.text = '';
                          _roomTemperatureController.text = '';
                          _roomHumidityController.text = '';
                          _productionController.text = '';
                          _dateController.text  = " ";


                        }

                      },

                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  } //Future update void



  //await _mushroom.add({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.update({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });
  // await _mushroom.doc({"batch": batchController, "lightLevel": lightLevelController, "roomTemp": roomTemperatureController, "humidity": roomHumidityController, "outcome": "none", "date": date });

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose(){ //Dispose the controller if not needed
    _batchController.dispose();
    _lightLevelController.dispose();
    _roomTemperatureController.dispose();
    _roomHumidityController.dispose();
    _productionController.dispose();
    _dateController.dispose();
    _searchController.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    super.dispose();
  }
  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
    if(_focus.hasFocus.toString() == "true"){
      hasFocus = true;
      print("Nakafocus");
      // _searchController.text = '';
    }
    else{
      hasFocus = false;
      print("Hindi Nakafocus");
    }

  }


  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight),
        // color: bgCard,
        color: Colors.blueGrey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 30),
              Container(
                // color: green,
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'SEARCH RECORDS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: brown,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),

                ),
              ),
          Container(
            color: Colors.blueGrey,
            margin: EdgeInsets.all(10),
            child: TextFormField(
                      focusNode: _focus,
                      controller: _searchController,
                      cursorColor: brown,
                      onChanged: (query) {
                         setState(()   {
                           // count = productsCount;
                           _searchController.text.isEmpty ? hasData = false : hasData = true;
                           this.bitch = int.parse(
                               _searchController.text);
                            // passMe = query as int;

                            print('Before passME');
                            print(passMe);
                           print('After passME');

                           print(query.runtimeType);
                            // searchBatchNumber(bNumber);
                        });
                        // print("bNumber from onChanged: " +passMe.toString() );
                      },
                      // focusNode: _focusNode,
                      // onTap: _requestFocus,
                      style: TextStyle(
                        color: brown,
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        // focusColor: textColor,
                          hintText: 'Search...',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: textColor, width: 32.0),
                              borderRadius: BorderRadius.circular(15.0)),
                          prefixIcon: Icon(
                            Icons.search,
                            color: brown,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            color: brown,
                            onPressed: (){
                              var queryToSend = _searchController.text;
                              // final queryToSend = query;
                              print("This is queryToSend: " + queryToSend);
                              final int batchNumber = int.parse(
                                  _searchController.text);
                              SearchBatchNumber( query: batchNumber);
                            },
                          ),
                          labelText: "Search Batch Number",
                          labelStyle: TextStyle(
                            color: brown,
                          )
                      ),
                      // validator: (value) {
                      //   if (value != null && value.isEmpty) {
                      //     return "Username cannot be empty!";
                      //   }
                      //   else {
                      //     return null;
                      //   }
                      // },
                    ),
          ),
          // Container(child:
          // Text(
          //   "Count: " +
          //     count.toString(),
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 30,
          //     color: textColor,
          //
          //   ),
          // )
          // ),
          Container(
            height: 500, //Shows the last record
            // color: Colors.white,
            // margin: EdgeInsets.fromLTRB(0,0,0,100),
      //         if(_focus.hasFocus.toString()){
      // print('a');
      // }
            child: hasData ? StreamBuilder(
              // stream: _mushroom.snapshots(), //persistent connection to the database
              stream: FirebaseFirestore.instance.collection('mushroom')
                  .where("id", isEqualTo: currentUser.currentUser!.uid)
                  .where("batchNumber", isEqualTo: this.bitch)//id should match the id field in the database
                  // .orderBy('id')
                  // .orderBy('batchNumber')
                  .snapshots(),

              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){ //streamSnapshot: all data available on the database
                if(streamSnapshot.hasData){
                  print(streamSnapshot.data!.docs.length.toString());
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length, //docs mean row
                    // itemCount: searchResult.length,
                    itemBuilder: (context, index) {

                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      // date = documentSnapshot['date'].toString() as DateTime;
                      //DateTime myDateTime = DateTime.parse(date.toDate().toString());
                      return Card(
                        margin: const EdgeInsets.all(15),
                        // margin: EdgeInsets.fromLTRB(15, 15, 15, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: pinkColor,
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(

                              // leading: Icon(
                              //   Icons.numbers,
                              //   size: 50,
                              //   color:  textColor,
                              // ),
                              title: RichText(
                                text: TextSpan(
                                  //style: Theme.of(context).textTheme.body1,
                                  children: [
                                    // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.numbers, color: textColor, size: 30,),
                                      ),
                                    ),
                                    TextSpan(text:  "Batch: " + documentSnapshot['batchNumber'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: textColor,

                                      ),),
                                  ],
                                ),
                              ),

                              subtitle: Container(

                                // padding: const EdgeInsets.all(12),
                                // decoration: BoxDecoration(
                                //   color: Colors.grey.shade200,
                                //   borderRadius: BorderRadius.circular(20),
                                //   border: Border.all(color: Colors.grey),
                                // ),
                                  margin: EdgeInsets.fromLTRB(0, 0 , 0, 0),
                                  child: Column(

                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: RichText(
                                          text: TextSpan(
                                            //style: Theme.of(context).textTheme.body1,
                                            children: [
                                              // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: Icon(Icons.lightbulb, color: textColor),
                                                ),
                                              ),
                                              TextSpan(text: "Light Level: " + documentSnapshot['lightLevel'].toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: textColor,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            //style: Theme.of(context).textTheme.body1,
                                            children: [
                                              // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: Icon(Icons.thermostat, color: textColor),
                                                ),
                                              ),
                                              TextSpan(text: "Room Temp: " + documentSnapshot['roomTemp'].toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: textColor,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            //style: Theme.of(context).textTheme.body1,
                                            children: [
                                              // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: Icon(Icons.water_drop, color: textColor),
                                                ),
                                              ),
                                              TextSpan(text:   "Humidity: " +documentSnapshot['humidity'].toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: textColor,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            //style: Theme.of(context).textTheme.body1,
                                            children: [
                                              // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: Icon(Icons.info, color: textColor),
                                                ),
                                              ),
                                              TextSpan(text:   "Outcome: " +documentSnapshot['outcome'].toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: textColor,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            //style: Theme.of(context).textTheme.body1,
                                            children: [
                                              // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: Icon(Icons.date_range, color: textColor),
                                                ),
                                              ),
                                              TextSpan(text:   "Date: " + documentSnapshot['datetime'].toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: textColor,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  )

                              ),//Subtitle

                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    children: [
                                      IconButton(
                                          icon:  Icon(Icons.edit, color: textColor ),
                                          onPressed: () => _update(documentSnapshot)),
                                      IconButton(
                                          icon:  Icon(Icons.delete, color: textColor),
                                          onPressed: () => _delete(documentSnapshot.id)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );


                }//widget build
                return Center(
                  // child: CircularProgressIndicator(),
                  child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_tmsiddoc.json'),
                );
              },
            )
                :
            StreamBuilder(
              // stream: _mushroom.snapshots(), //persistent connection to the database
              stream: FirebaseFirestore.instance.collection('mushroom')
                  .where("id", isEqualTo: currentUser.currentUser!.uid)
                  // .where("batchNumber", isEqualTo: this.bitch)//id should match the id field in the database
                  // .orderBy('id')
                  // .orderBy('batchNumber')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){ //streamSnapshot: all data available on the database
                if(streamSnapshot.hasData){
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length, //docs mean row
                    // itemCount: searchResult.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                      // date = documentSnapshot['date'].toString() as DateTime;
                      //DateTime myDateTime = DateTime.parse(date.toDate().toString());
                      return Card(
                        margin: const EdgeInsets.all(15),
                        // margin: EdgeInsets.fromLTRB(15, 15, 15, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: pinkColor,
                        elevation: 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(

                              // leading: Icon(
                              //   Icons.numbers,
                              //   size: 50,
                              //   color:  textColor,
                              // ),
                              title: RichText(
                                text: TextSpan(
                                  //style: Theme.of(context).textTheme.body1,
                                  children: [
                                    // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                    WidgetSpan(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Icons.numbers, color: textColor, size: 30,),
                                      ),
                                    ),
                                    TextSpan(text:  "Batch: " + documentSnapshot['batchNumber'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: textColor,

                                      ),),
                                  ],
                                ),
                              ),

                              subtitle: Container(

                                // padding: const EdgeInsets.all(12),
                                // decoration: BoxDecoration(
                                //   color: Colors.grey.shade200,
                                //   borderRadius: BorderRadius.circular(20),
                                //   border: Border.all(color: Colors.grey),
                                // ),
                                  margin: EdgeInsets.fromLTRB(0, 0 , 0, 0),
                                  child: Column(

                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: RichText(
                                          text: TextSpan(
                                            //style: Theme.of(context).textTheme.body1,
                                            children: [
                                              // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: Icon(Icons.lightbulb, color: textColor),
                                                ),
                                              ),
                                              TextSpan(text: "Light Level: " + documentSnapshot['lightLevel'].toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: textColor,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            //style: Theme.of(context).textTheme.body1,
                                            children: [
                                              // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: Icon(Icons.thermostat, color: textColor),
                                                ),
                                              ),
                                              TextSpan(text: "Room Temp: " + documentSnapshot['roomTemp'].toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: textColor,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            //style: Theme.of(context).textTheme.body1,
                                            children: [
                                              // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: Icon(Icons.water_drop, color: textColor),
                                                ),
                                              ),
                                              TextSpan(text:   "Humidity: " +documentSnapshot['humidity'].toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: textColor,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            //style: Theme.of(context).textTheme.body1,
                                            children: [
                                              // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: Icon(Icons.info, color: textColor),
                                                ),
                                              ),
                                              TextSpan(text:   "Outcome: " +documentSnapshot['outcome'].toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: textColor,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RichText(
                                          text: TextSpan(
                                            //style: Theme.of(context).textTheme.body1,
                                            children: [
                                              // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
                                              WidgetSpan(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                  child: Icon(Icons.date_range, color: textColor),
                                                ),
                                              ),
                                              TextSpan(text:   "Date: " + documentSnapshot['datetime'].toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: textColor,
                                                ),),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  )

                              ),//Subtitle

                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonBar(
                                    children: [
                                      IconButton(
                                          icon:  Icon(Icons.edit, color: textColor ),
                                          onPressed: () => _update(documentSnapshot)),
                                      IconButton(
                                          icon:  Icon(Icons.delete, color: textColor),
                                          onPressed: () => _delete(documentSnapshot.id)),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );


                }//widget build
                return Container(
                  // height: 500,
                  child: Center(
                    child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_tmsiddoc.json'),
                  ),
                );
              },
            ),

          ),
            ],
          ),
        ),
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




