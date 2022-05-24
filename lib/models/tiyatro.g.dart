// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tiyatro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tiyatro _$TiyatroFromJson(Map<String, dynamic> json) => Tiyatro(
      sehir: json['sehir'] as String?,
      oyunAdi: json['oyunAdi'] as String?,
      oyunAfis: json['oyunAfis'] as String?,
      oyunKonusu: json['oyunKonusu'] as String?,
      oyunUrl: json['oyunUrl'] as String?,
      yazan: json['yazan'] as String?,
    );

Map<String, dynamic> _$TiyatroToJson(Tiyatro instance) => <String, dynamic>{
      'sehir': instance.sehir,
      'oyunAdi': instance.oyunAdi,
      'yazan': instance.yazan,
      'oyunAfis': instance.oyunAfis,
      'oyunKonusu': instance.oyunKonusu,
      'oyunUrl': instance.oyunUrl,
    };
