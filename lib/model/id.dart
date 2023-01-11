
import 'package:json_annotation/json_annotation.dart';

part 'id.g.dart';
@JsonSerializable()
class Id{
  final double count;
  final double mean;
  final double std;
  final double min;
  final double twentyFive;
  final double fifty;
  final double seventyFive;
  final double max;

  Id({
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


  factory Id.fromJson (Map<String, dynamic> json) =>  _$IdFromJson (json);

  Map<String, dynamic> toJson() => _$IdToJson(this);




}

// class Id{
//   late double count;
//   late double mean;
//   late double std;
//   late double min;
//   late double twentyFive;
//   late double fifty;
//   late double seventyFive;
//   late double max;
//
//   Id(
//       this.count,
//       this.mean,
//       this.std,
//       this.min,
//       this.twentyFive,
//       this.fifty,
//       this.seventyFive,
//       this.max);
//
//   Id.fromJson (Map<String, dynamic> json) {
//     count = json['id']['count'];
//     mean = json['id']['mean'];
//     std = json['id']['std'];
//     min = json['id']['min'];
//     twentyFive = json['id']['25%'];
//     fifty = json['id']['50%'];
//     seventyFive = json['id']['75%'];
//     max = json['id']['max'];
//   }
//
//
//
// }