// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pdf _$PdfFromJson(Map<String, dynamic> json) => Pdf(
      trueNegative :  (json['Response']['trueNegative']),
      falsePositive :  (json['Response']['falsePositive']),
      falseNegative : (json['Response']['falseNegative']),
      truePositive : (json['Response']['truePositive']),
      no: (json['Response']['no']),
      yes: (json['Response']['yes']),
      prediction: (json['Response']['prediction'] as String),
      accuracy: (json['Response']["accuracy"].toDouble()),
      id: Id.fromJson(json['Responde']['id'] as Map<String, dynamic>),
      batchNumber:
          BatchNumber.fromJson(json['Responde']['batchNumber'] as Map<String, dynamic>),
      lightLevel:
          LightLevel.fromJson(json['Responde']['lightLevel'] as Map<String, dynamic>),
      roomTemp: RoomTemp.fromJson(json['Responde']['roomTemp'] as Map<String, dynamic>),
      humidity: Humidity.fromJson(json['Responde']['humidity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PdfToJson(Pdf instance) => <String, dynamic>{

      'trueNegative' : instance.trueNegative,
      'falsePositive' : instance.falsePositive,
      'falseNegative' : instance.falseNegative,
      'truePositive' : instance.truePositive,
      'no': instance.no,
      'yes': instance.yes,
      'prediction': instance.prediction,
      'accuracy': instance.accuracy,
      'id': instance.id.toJson(),
      'batchNumber': instance.batchNumber.toJson(),
      'lightLevel': instance.lightLevel.toJson(),
      'roomTemp': instance.roomTemp.toJson(),
      'humidity': instance.humidity.toJson(),
    };
