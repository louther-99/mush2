// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batchNumber.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchNumber _$BatchNumberFromJson(Map<String, dynamic> json) => BatchNumber(
      count: (json['count'] as num).toDouble(),
      mean: (json['mean'] as num).toDouble(),
      std: (json['std'] as num).toDouble(),
      min: (json['min'] as num).toDouble(),
      twentyFive: (json['25%'] as num).toDouble(),
      fifty: (json['50%'] as num).toDouble(),
      seventyFive: (json['75%'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
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
