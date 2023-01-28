import 'package:fl_chart/fl_chart.dart';
import 'package:mush2/model/id.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mush2/model/roomTemp.dart';
import 'batchNumber.dart';
import 'humidity.dart';
import 'lightLevel.dart';

part 'pdf2.g.dart';
@JsonSerializable(explicitToJson: true)

class Pdf2 {

  final int trueNegative;
  final int falsePositive;
  final int falseNegative;
  final int truePositive;
  final String prediction;
  final double accuracy;
  final Id id;
  final BatchNumber batchNumber;
  final LightLevel lightLevel;
  final RoomTemp roomTemp;
  final Humidity humidity;



// final String described;

  Pdf2({
    required this.trueNegative,
    required this.falsePositive,
    required this.falseNegative,
    required this.truePositive,
    required this.prediction,
    required this.accuracy,
    required this.id,
    required this.batchNumber,
    required this.lightLevel,
    required this.roomTemp,
    required this.humidity,

    // required this.described,
  });

  factory Pdf2.fromJson (Map<String, dynamic> json) =>  _$PdfFromJson (json);

  Map<String, dynamic> toJson() => _$PdfToJson(this);


//
// String get getPrediction {
//     return prediction;
// }
//
// double get getAccuracy {
//   return accuracy;
// }


}





