// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pdf _$PdfFromJson(Map<String, dynamic> json) => Pdf(
      prediction: json['Response']['Prediction'] as String,
      accuracy: (json['Response']["Accuracy"].toDouble()),
      id: Id.fromJson(json['Responde']['id'] as Map<String, dynamic>),
      batchNumber:
          BatchNumber.fromJson(json['Responde']['batchNumber'] as Map<String, dynamic>),
      lightLevel:
          LightLevel.fromJson(json['Responde']['lightLevel'] as Map<String, dynamic>),
      roomTemp: RoomTemp.fromJson(json['Responde']['roomTemp'] as Map<String, dynamic>),
      humidity: Humidity.fromJson(json['Responde']['humidity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PdfToJson(Pdf instance) => <String, dynamic>{
      'prediction': instance.prediction,
      'accuracy': instance.accuracy,
      'id': instance.id.toJson(),
      'batchNumber': instance.batchNumber.toJson(),
      'lightLevel': instance.lightLevel.toJson(),
      'roomTemp': instance.roomTemp.toJson(),
      'humidity': instance.humidity.toJson(),
    };
