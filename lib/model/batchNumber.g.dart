// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batchNumber.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchNumber _$BatchNumberFromJson(Map<String, dynamic> json) => BatchNumber(
      count: (json['count']).toDouble(),
      mean: (json['mean']).toDouble(),
      std: (json['std']).toDouble().roundToDouble(),
      min: (json['min']).toDouble(),
      twentyFive: (json['25%']).toDouble(),
      fifty: (json['50%']).toDouble(),
      seventyFive: (json['75%']).toDouble(),
      max: (json['max']).toDouble(),
    );

Map<String, dynamic> _$BatchNumberToJson(BatchNumber instance) =>
    <String, dynamic>{
      'count': instance.count,
      'mean': instance.mean,
      'std': instance.std,
      'min': instance.min,
      'twentyFive': instance.twentyFive,
      'fifty': instance.fifty,
      'seventyFive': instance.seventyFive,
      'max': instance.max,
    };
