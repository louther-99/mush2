
import 'package:json_annotation/json_annotation.dart';
class Mushi {
  final String id;
  final String batchNumber;
  final String lightLevel;
  final String roomTemp;
  final String humidity;
  final String outcome;
  final String datetime;

  Mushi({
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

  static Mushi fromJson (Map<String, dynamic> json) => Mushi(
    id: json['id'],
    batchNumber: json['batchNumber'],
    lightLevel: json['lightLevel'],
    roomTemp: json['roomTemp'],
    humidity: json['humidity'],
    outcome: json['outcome'],
    datetime: json['datetime'],
  );//Converts object to JSON




}