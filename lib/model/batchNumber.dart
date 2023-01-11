

import 'package:json_annotation/json_annotation.dart';

part 'batchNumber.g.dart';
@JsonSerializable()
class BatchNumber{
  final double count;
  final double mean;
  final double std;
  final double min;
  final double twentyFive;
  final double fifty;
  final double seventyFive;
  final double max;

  BatchNumber(
  {
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

  factory BatchNumber.fromJson (Map<String, dynamic> json) =>  _$BatchNumberFromJson (json);

  Map<String, dynamic> toJson() => _$BatchNumberToJson(this);


}

// class BatchNumber{
//   late double count;
//   late double mean;
//   late double std;
//   late double min;
//   late double twentyFive;
//   late double fifty;
//   late double seventyFive;
//   late double max;
//
//   BatchNumber(
//       this.count,
//       this.mean,
//       this.std,
//       this.min,
//       this.twentyFive,
//       this.fifty,
//       this.seventyFive,
//       this.max);
//
//   BatchNumber.fromJson (Map<String, dynamic> json) {
//     count = json['batchNumber']['count'];
//     mean = json['batchNumber']['mean'];
//     std = json['batchNumber']['std'];
//     min = json['batchNumber']['min'];
//     twentyFive = json['batchNumber']['25%'];
//     fifty = json['batchNumber']['50%'];
//     seventyFive = json['batchNumber']['75%'];
//     max = json['batchNumber']['max'];
//   }
//
// }