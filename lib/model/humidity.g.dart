// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'humidity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Humidity _$HumidityFromJson(Map<String, dynamic> json) => Humidity(
      count: (json['count'] as num).toDouble(),
      mean: (json['mean'] as num).toDouble(),
      std: (json['std'] as num).toDouble(),
      min: (json['min'] as num).toDouble(),
      twentyFive: (json['twentyFive'] as num).toDouble(),
      fifty: (json['fifty'] as num).toDouble(),
      seventyFive: (json['seventyFive'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
    );

Map<String, dynamic> _$HumidityToJson(Humidity instance) => <String, dynamic>{
      'count': instance.count,
      'mean': instance.mean,
      'std': instance.std,
      'min': instance.min,
      'twentyFive': instance.twentyFive,
      'fifty': instance.fifty,
      'seventyFive': instance.seventyFive,
      'max': instance.max,
    };
