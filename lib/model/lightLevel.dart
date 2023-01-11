import 'package:json_annotation/json_annotation.dart';

part 'lightLevel.g.dart';
@JsonSerializable()

class LightLevel{
  final double count;
  final double mean;
  final double std;
  final double min;
  final double twentyFive;
  final double fifty;
  final double seventyFive;
  final double max;

  LightLevel({
    required this.count,
    required this.mean,
    required this.std,
    required this.min,
    required this.twentyFive,
    required this.fifty,
    required this.seventyFive,
    required this.max
  });

  factory LightLevel.fromJson (Map<String, dynamic> json) =>  _$LightLevelFromJson (json);

  Map<String, dynamic> toJson() => _$LightLevelToJson(this);


}

// class LightLevel{
//   late double count;
//   late double mean;
//   late double std;
//   late double min;
//   late double twentyFive;
//   late double fifty;
//   late double seventyFive;
//   late double max;
//
//   LightLevel(
//       this.count,
//       this.mean,
//       this.std,
//       this.min,
//       this.twentyFive,
//       this.fifty,
//       this.seventyFive,
//       this.max);
//
//   LightLevel.fromJson (Map<String, dynamic> json) {
//     count = json['lightLevel']['count'];
//     mean = json['lightLevel']['mean'];
//     std = json['lightLevel']['std'];
//     min = json['lightLevel']['min'];
//     twentyFive = json['lightLevel']['25%'];
//     fifty = json['lightLevel']['50%'];
//     seventyFive = json['lightLevel']['75%'];
//     max = json['lightLevel']['max'];
//   }
//
// }