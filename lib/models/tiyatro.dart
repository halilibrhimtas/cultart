import 'package:freezed_annotation/freezed_annotation.dart';
part 'tiyatro.g.dart';

@JsonSerializable()
class Tiyatro {
  final String? sehir;
  final String? oyunAdi;
  final String? yazan;
  final String? oyunAfis;
  final String? oyunKonusu;
  final String? oyunUrl;
  final String? salon;
  final Map? salonKonum;

  Tiyatro(
      {this.sehir,
      this.oyunAdi,
      this.oyunAfis,
      this.oyunKonusu,
      this.oyunUrl,
      this.yazan,
      this.salon,
      this.salonKonum});

  factory Tiyatro.fromJson(Map<String, dynamic> json) =>
      _$TiyatroFromJson(json);

  Map<String, dynamic> toJson() => _$TiyatroToJson(this);
}
