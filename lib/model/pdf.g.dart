// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pdf _$PdfFromJson(Map<String, dynamic> json) => Pdf(
      prediction: json['prediction'] as String,
      accuracy: (json['accuracy'] as num).toDouble(),
      id: Id.fromJson(json['id'] as Map<String, dynamic>),
      batchNumber:
          BatchNumber.fromJson(json['batchNumber'] as Map<String, dynamic>),
      lightLevel:
          LightLevel.fromJson(json['lightLevel'] as Map<String, dynamic>),
      roomTemp: RoomTemp.fromJson(json['roomTemp'] as Map<String, dynamic>),
      humidity: Humidity.fromJson(json['humidity'] as Map<String, dynamic>),
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
