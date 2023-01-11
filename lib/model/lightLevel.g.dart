// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lightLevel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightLevel _$LightLevelFromJson(Map<String, dynamic> json) => LightLevel(
      count: (json['count']).toDouble(),
      mean: (json['mean']).toDouble(),
      std: (json['std']).toDouble().roundToDouble(),
      min: (json['min']).toDouble(),
      twentyFive: (json['25%']).toDouble(),
      fifty: (json['50%']).toDouble(),
      seventyFive: (json['75%']).toDouble(),
      max: (json['max']).toDouble(),
    );

Map<String, dynamic> _$LightLevelToJson(LightLevel instance) =>
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
