
import 'package:json_annotation/json_annotation.dart';

part 'humidity.g.dart';
@JsonSerializable()
class Humidity{
  final double count;
  final double mean;
  final double std;
  final double min;
  final double twentyFive;
  final double fifty;
  final double seventyFive;
  final double max;

  Humidity({
    required this.count,
    required this.mean,
    required this.std,
    required this.min,
    required this.twentyFive,
    required this.fifty,
    required this.seventyFive,
    required this.max
}
  );

  factory Humidity.fromJson (Map<String, dynamic> json) =>  _$HumidityFromJson (json);

  Map<String, dynamic> toJson() => _$HumidityToJson(this);


}


// class Humidity{
//   late double count;
//   late double mean;
//   late double std;
//   late double min;
//   late double twentyFive;
//   late double fifty;
//   late double seventyFive;
//   late double max;
//
//   Humidity(
//       this.count,
//       this.mean,
//       this.std,
//       this.min,
//       this.twentyFive,
//       this.fifty,
//       this.seventyFive,
//       this.max);
//
//   Humidity.fromJson (Map<String, dynamic> json) {
//     count = json['humidity']['count'];
//     mean = json['humidity']['mean'];
//     std = json['humidity']['std'];
//     min = json['humidity']['min'];
//     twentyFive = json['humidity']['25%'];
//     fifty = json['humidity']['50%'];
//     seventyFive = json['humidity']['75%'];
//     max = json['humidity']['max'];
//   }
//
// }