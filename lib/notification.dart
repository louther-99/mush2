import 'package:firebase_auth/firebase_auth.dart';
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

import 'newTile.dart';

class Notif extends StatefulWidget {
  const Notif({Key? key}) : super(key: key);

  @override
  State<Notif> createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  String q = "";
  //hasFocus ? print("true") : print('false');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final String userID = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseAuth.instance.currentUser!;


  final CollectionReference _mushroom = FirebaseFirestore.instance.collection(
      'mushroom');
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

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;

    var searchText;
    var shuta;
    return Column(
      children: [
        // SizedBox(height: 10,),
        TextFormField(
          controller: _searchController,
          cursorColor: textColor,
          onChanged: (query) {
            setState(() {
             q = query;


              print(q);
              // BuildResult(context, bNumber);
              // searchBatchNumber(bNumber);
            });
            print("bNumber from onChanged: " + q);
          },
          // focusNode: _focusNode,
          // onTap: _requestFocus,
          style: TextStyle(
            color: textColor,
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
                color: textColor,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                color: textColor,
                onPressed: () {
                  final queryToSend = _searchController.text;
                  // final queryToSend = q;
                  futa(queryToSend);
                },
              ),
              labelText: "Search Batch Number",
              labelStyle: TextStyle(
                color: textColor,
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
        Expanded(
          // color: Colors.lightGreen,
          child: Container(
            child: StreamBuilder(
              // stream: _mushroom.snapshots(), //persistent connection to the database
              stream: FirebaseFirestore.instance.collection('mushroom')
              // .where("id", isEqualTo: currentUser.currentUser!.uid)
                  .where("batchNumber",
                  isEqualTo: q) //id should match the id field in the database
                  .snapshots(),
              builder: (context, AsyncSnapshot<
                  QuerySnapshot> streamSnapshot) { //streamSnapshot: all data available on the database
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    //docs mean row
                    // itemCount: searchResult.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot = streamSnapshot
                          .data!.docs[index];
                      // date = documentSnapshot['date'].toString() as DateTime;
                      //DateTime myDateTime = DateTime.parse(date.toDate().toString());
                      return Ink(
                        color: bgCard,
                        child: ListTile(
                          leading: Icon(
                            Icons.numbers,
                            size: 30,
                            color: textColor,
                          ),
                          title: Text("Batch: " +
                              documentSnapshot['batchNumber'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: textColor,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 30,
                            color: textColor,
                          ),
                          onTap: () {
                            print("bNumber after ink: " + q);
                            print("From data: " + _searchController.text);
                            final String searchBatch = (_searchController
                                .text);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NewTile(value: _searchController.text)));
                          },

                        ),
                      );
                    },
                  );
                } //widget build
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),


        //Container showing all data

        // Container(
        //   height: 340,
        //   color: Colors.blueGrey,
        //   child: StreamBuilder(
        //     // stream: _mushroom.snapshots(), //persistent connection to the database
        //     stream: FirebaseFirestore.instance.collection('mushroom')
        //         .where("id", isEqualTo: currentUser.currentUser!.uid)
        //       .where("batchNumber", isEqualTo: query)//id should match the id field in the database
        //         .snapshots(),
        //     builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){ //streamSnapshot: all data available on the database
        //       if(streamSnapshot.hasData){
        //         return ListView.builder(
        //           itemCount: streamSnapshot.data!.docs.length, //docs mean row
        //         // itemCount: searchResult.length,
        //         itemBuilder: (context, index) {
        //             final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
        //             // date = documentSnapshot['date'].toString() as DateTime;
        //             //DateTime myDateTime = DateTime.parse(date.toDate().toString());
        //             return Card(
        //               margin: const EdgeInsets.all(15),
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(15.0),
        //               ),
        //               color: pinkColor,
        //               elevation: 10,
        //               child: Column(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   ListTile(
        //
        //                     // leading: Icon(
        //                     //   Icons.numbers,
        //                     //   size: 50,
        //                     //   color:  textColor,
        //                     // ),
        //                     title: RichText(
        //                       text: TextSpan(
        //                         //style: Theme.of(context).textTheme.body1,
        //                         children: [
        //                           // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
        //                           WidgetSpan(
        //                             child: Padding(
        //                               padding: const EdgeInsets.symmetric(horizontal: 2.0),
        //                               child: Icon(Icons.numbers, color: textColor, size: 30,),
        //                             ),
        //                           ),
        //                           TextSpan(text:  "Batch: " + documentSnapshot['batchNumber'].toString(),
        //                             style: TextStyle(
        //                               fontWeight: FontWeight.bold,
        //                               fontSize: 30,
        //                               color: textColor,
        //
        //                             ),),
        //                         ],
        //                       ),
        //                     ),
        //
        //                     subtitle: Container(
        //
        //                       // padding: const EdgeInsets.all(12),
        //                       // decoration: BoxDecoration(
        //                       //   color: Colors.grey.shade200,
        //                       //   borderRadius: BorderRadius.circular(20),
        //                       //   border: Border.all(color: Colors.grey),
        //                       // ),
        //                         margin: EdgeInsets.fromLTRB(0, 0 , 0, 0),
        //                         child: Column(
        //
        //                           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                           crossAxisAlignment: CrossAxisAlignment.start,
        //                           children: [
        //                             SizedBox(height: 10),
        //                             Padding(
        //                               padding: const EdgeInsets.all(5.0),
        //                               child: RichText(
        //                                 text: TextSpan(
        //                                   //style: Theme.of(context).textTheme.body1,
        //                                   children: [
        //                                     // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
        //                                     WidgetSpan(
        //                                       child: Padding(
        //                                         padding: const EdgeInsets.symmetric(horizontal: 2.0),
        //                                         child: Icon(Icons.lightbulb, color: textColor),
        //                                       ),
        //                                     ),
        //                                     TextSpan(text: "Light Level: " + documentSnapshot['lightLevel'].toString(),
        //                                       style: TextStyle(
        //                                         fontWeight: FontWeight.normal,
        //                                         fontSize: 15,
        //                                         color: textColor,
        //                                       ),),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                             Padding(
        //                               padding: const EdgeInsets.all(8.0),
        //                               child: RichText(
        //                                 text: TextSpan(
        //                                   //style: Theme.of(context).textTheme.body1,
        //                                   children: [
        //                                     // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
        //                                     WidgetSpan(
        //                                       child: Padding(
        //                                         padding: const EdgeInsets.symmetric(horizontal: 2.0),
        //                                         child: Icon(Icons.thermostat, color: textColor),
        //                                       ),
        //                                     ),
        //                                     TextSpan(text: "Room Temp: " + documentSnapshot['roomTemp'].toString(),
        //                                       style: TextStyle(
        //                                         fontWeight: FontWeight.normal,
        //                                         fontSize: 15,
        //                                         color: textColor,
        //                                       ),),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                             Padding(
        //                               padding: const EdgeInsets.all(8.0),
        //                               child: RichText(
        //                                 text: TextSpan(
        //                                   //style: Theme.of(context).textTheme.body1,
        //                                   children: [
        //                                     // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
        //                                     WidgetSpan(
        //                                       child: Padding(
        //                                         padding: const EdgeInsets.symmetric(horizontal: 2.0),
        //                                         child: Icon(Icons.water_drop, color: textColor),
        //                                       ),
        //                                     ),
        //                                     TextSpan(text:   "Humidity: " +documentSnapshot['humidity'].toString(),
        //                                       style: TextStyle(
        //                                         fontWeight: FontWeight.normal,
        //                                         fontSize: 15,
        //                                         color: textColor,
        //                                       ),),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                             Padding(
        //                               padding: const EdgeInsets.all(8.0),
        //                               child: RichText(
        //                                 text: TextSpan(
        //                                   //style: Theme.of(context).textTheme.body1,
        //                                   children: [
        //                                     // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
        //                                     WidgetSpan(
        //                                       child: Padding(
        //                                         padding: const EdgeInsets.symmetric(horizontal: 2.0),
        //                                         child: Icon(Icons.info, color: textColor),
        //                                       ),
        //                                     ),
        //                                     TextSpan(text:   "Outcome: " +documentSnapshot['outcome'].toString(),
        //                                       style: TextStyle(
        //                                         fontWeight: FontWeight.normal,
        //                                         fontSize: 15,
        //                                         color: textColor,
        //                                       ),),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //                             Padding(
        //                               padding: const EdgeInsets.all(8.0),
        //                               child: RichText(
        //                                 text: TextSpan(
        //                                   //style: Theme.of(context).textTheme.body1,
        //                                   children: [
        //                                     // TextSpan(text: "Batch Number: " + documentSnapshot['batchNumber'].toString(),),
        //                                     WidgetSpan(
        //                                       child: Padding(
        //                                         padding: const EdgeInsets.symmetric(horizontal: 2.0),
        //                                         child: Icon(Icons.date_range, color: textColor),
        //                                       ),
        //                                     ),
        //                                     TextSpan(text:   "Date: " + documentSnapshot['datetime'].toString(),
        //                                       style: TextStyle(
        //                                         fontWeight: FontWeight.normal,
        //                                         fontSize: 15,
        //                                         color: textColor,
        //                                       ),),
        //                                   ],
        //                                 ),
        //                               ),
        //                             ),
        //
        //                           ],
        //                         )
        //
        //                     ),//Subtitle
        //
        //                   ),
        //                   Center(
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.center,
        //                       children: [
        //                         ButtonBar(
        //                           children: [
        //                             IconButton(
        //                                 icon:  Icon(Icons.edit, color: textColor ),
        //                                 onPressed: () => _update(documentSnapshot)),
        //                             IconButton(
        //                                 icon:  Icon(Icons.delete, color: textColor),
        //                                 onPressed: () => _delete(documentSnapshot.id)),
        //
        //                           ],
        //                         ),
        //                       ],
        //                     ),
        //                   )
        //                 ],
        //               ),
        //             );
        //           },
        //         );
        //
        //
        //       }//widget build
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     },
        //   ),
        // ),
        //  End container showing all data

      ],
      // color: bgCard,
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


      // IDUser: data['IDUser'],
      // profilePath: data['profilePath'],
      // name: data['name'],
      // email: data['email'],
      // about: data['about'],
      // coverPath: data['coverPath'],
      // lastMessageTime: data['lastMessageTime']);


    );
    // return Container(
    //   child: Text(user.uid),
    // );
  }

  Widget futa(String queryToSend) {
     return StreamBuilder(
       // stream: _mushroom.snapshots(), //persistent connection to the database
       stream: FirebaseFirestore.instance.collection('mushroom')
       // .where("id", isEqualTo: currentUser.currentUser!.uid)
           .where("batchNumber",
           isEqualTo: queryToSend) //id should match the id field in the database
           .snapshots(),
       builder: (context, AsyncSnapshot<
           QuerySnapshot> streamSnapshot) { //streamSnapshot: all data available on the database
         if (streamSnapshot.hasData) {
           return ListView.builder(
             itemCount: streamSnapshot.data!.docs.length,
             //docs mean row
             // itemCount: searchResult.length,
             itemBuilder: (context, index) {
               final DocumentSnapshot documentSnapshot = streamSnapshot
                   .data!.docs[index];
               // date = documentSnapshot['date'].toString() as DateTime;
               //DateTime myDateTime = DateTime.parse(date.toDate().toString());
               return Ink(
                 color: bgCard,
                 child: ListTile(
                   leading: Icon(
                     Icons.numbers,
                     size: 30,
                     color: textColor,
                   ),
                   title: Text("Batch: " +
                       documentSnapshot['batchNumber'].toString(),
                     style: TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 30,
                       color: textColor,
                     ),
                   ),
                   trailing: Icon(
                     Icons.arrow_forward_ios,
                     size: 30,
                     color: textColor,
                   ),
                   onTap: () {
                     print("bNumber after ink: " + q);
                     print("From data: " + _searchController.text);
                     final String searchBatch = (_searchController
                         .text);
                     Navigator.of(context).push(MaterialPageRoute(
                         builder: (BuildContext context) =>
                             NewTile(value: _searchController.text)));
                   },

                 ),
               );
             },
           );
         } //widget build
         return const Center(
           child: CircularProgressIndicator(),
         );
       },
     );


  }
}






