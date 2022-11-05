// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wms_tile_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WmsParams _$WmsParamsFromJson(Map<String, dynamic> json) => WmsParams()
  ..layers = json['layers'] as String
  ..styles = json['styles'] as String
  ..version = json['version'] as String
  ..transparent = json['transparent'] as bool
  ..bgcolor = json['bgcolor'] as String
  ..format = json['format'] as String
  ..outline = json['outline'] as bool;

Map<String, dynamic> _$WmsParamsToJson(WmsParams instance) => <String, dynamic>{
      'layers': instance.layers,
      'styles': instance.styles,
      'version': instance.version,
      'transparent': instance.transparent,
      'bgcolor': instance.bgcolor,
      'format': instance.format,
      'outline': instance.outline,
    };
