
import 'package:json_annotation/json_annotation.dart';

part 'roomTemp.g.dart';
@JsonSerializable()

class RoomTemp{
  final double count;
  final double mean;
  final double std;
  final double min;
  final double twentyFive;
  final double fifty;
  final double seventyFive;
  final double max;

  RoomTemp({
    required this.count,
    required this.mean,
    required this.std,
    required this.min,
    required this.twentyFive,
    required this.fifty,
    required this.seventyFive,
    required this.max
});

  factory RoomTemp.fromJson (Map<String, dynamic> json) =>  _$RoomTempFromJson (json);

  Map<String, dynamic> toJson() => _$RoomTempToJson(this);


}

// class RoomTemp{
//   late double count;
//   late double mean;
//   late double std;
//   late double min;
//   late double twentyFive;
//   late double fifty;
//   late double seventyFive;
//   late double max;
//
//   RoomTemp(
//       this.count,
//       this.mean,
//       this.std,
//       this.min,
//       this.twentyFive,
//       this.fifty,
//       this.seventyFive,
//       this.max);
//
//   RoomTemp.fromJson (Map<String, dynamic> json) {
//     count = json['roomTemp']['count'];
//     mean = json['roomTemp']['mean'];
//     std = json['roomTemp']['std'];
//     min = json['roomTemp']['min'];
//     twentyFive = json['roomTemp']['25%'];
//     fifty = json['roomTemp']['50%'];
//     seventyFive = json['roomTemp']['75%'];
//     max = json['roomTemp']['max'];
//   }
//
// }
