
import 'package:json_annotation/json_annotation.dart';
class MushroomData {
  final String id;
  final int batchNumber;
  final double lightLevel;
  final double roomTemp;
  final double humidity;
  final String outcome;
  final String datetime;

  MushroomData({
    required this.id,
    required this.batchNumber,
    required this.lightLevel,
    required this.roomTemp,
    required this.humidity,
    required this.outcome,
    required this.datetime,
  });

  Map<String, dynamic> toJson() => { //Converts object to JSON
    'id': id,
    'batchNumber': batchNumber,
    'lightLevel': lightLevel,
    'roomTemp': roomTemp,
    'humidity': humidity,
    'outcome': outcome,
    'datetime': datetime,
  };

  static MushroomData fromJson (Map<String, dynamic> json) => MushroomData(
    id: json['id'],
    batchNumber: json['batchNumber'],
    lightLevel: json['lightLevel'],
    roomTemp: json['roomTemp'],
    humidity: json['humidity'],
    outcome: json['outcome'],
    datetime: json['datetime'],
  );//Converts object to JSON




}

//
// class Users {
//   final String id;
//   final int batchNumber;
//   final double lightLevel;
//   final double roomTemp;
//   final double humidity;
//   final String outcome;
//   final String datetime;
//
//   Users({
//     required this.id,
//     required this.batchNumber,
//     required this.lightLevel,
//     required this.roomTemp,
//     required this.humidity,
//     required this.outcome,
//     required this.datetime,
//   });
//
//   Map<String, dynamic> toJson() => { //Converts object to JSON
//     'id': id,
//     'batchNumber': batchNumber,
//     'lightLevel': lightLevel,
//     'roomTemp': roomTemp,
//     'humidity': humidity,
//     'outcome': outcome,
//     'datetime': datetime,
//   };
//
//   static Users fromJson (Map<String, dynamic> json) => Users(
//     id: json['id'],
//     batchNumber: json['batchNumber'],
//     lightLevel: json['lightLevel'],
//     roomTemp: json['roomTemp'],
//     humidity: json['humidity'],
//     outcome: json['outcome'],
//     datetime: json['datetime'],
//   );//Converts object to JSON
//
//
// // Future<http.Response>postData(int batchNumber, double lightLevel, double roomTemp, double humidity, String outcome,DateTime datetime ){
// //   return http.post(
// //     'http://0.0.0.0:5000/',
// //     headers: <String, String>{
// //       'Content-Type': 'application/json; charset=UTF-8',
// //     },
// //     body: jsonEncode(<String, String>{
// //       'batchNumber': batchNumber,
// //       'lightLevel': lightLevel,
// //       'roomTemp': roomTemp,
// //       'humidity': humidity,
// //       'outcome': outcome,
// //       'datetime' : datetime,
// //     }),
// //   );
// // }
//
// }


//batchNumber
// 2
// datetime
// "2021-11-03"
// (string)
//
// edit
//
// delete
// humidity
// 42
// id
// "mTwB5Fo7clUfGNuUgnsCgWkyjOA3"
// lightLevel
// 100
// outcome
// ""
// roomTemp
// 39