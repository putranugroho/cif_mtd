import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class GolonganSbbKhususModel {

  const GolonganSbbKhususModel({
    required this.kodeSbbKhusus,
    required this.namaSbbKhusus,
    required this.coaSatu,
  });

  final String kodeSbbKhusus;
  final String namaSbbKhusus;
  final String coaSatu;

  factory GolonganSbbKhususModel.fromJson(Map<String,dynamic> json) => GolonganSbbKhususModel(
    kodeSbbKhusus: json['kode_sbb_khusus'].toString(),
    namaSbbKhusus: json['nama_sbb_khusus'].toString(),
    coaSatu: json['coa_satu'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'kode_sbb_khusus': kodeSbbKhusus,
    'nama_sbb_khusus': namaSbbKhusus,
    'coa_satu': coaSatu
  };

  GolonganSbbKhususModel clone() => GolonganSbbKhususModel(
    kodeSbbKhusus: kodeSbbKhusus,
    namaSbbKhusus: namaSbbKhusus,
    coaSatu: coaSatu
  );


  GolonganSbbKhususModel copyWith({
    String? kodeSbbKhusus,
    String? namaSbbKhusus,
    String? coaSatu
  }) => GolonganSbbKhususModel(
    kodeSbbKhusus: kodeSbbKhusus ?? this.kodeSbbKhusus,
    namaSbbKhusus: namaSbbKhusus ?? this.namaSbbKhusus,
    coaSatu: coaSatu ?? this.coaSatu,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is GolonganSbbKhususModel && kodeSbbKhusus == other.kodeSbbKhusus && namaSbbKhusus == other.namaSbbKhusus && coaSatu == other.coaSatu;

  @override
  int get hashCode => kodeSbbKhusus.hashCode ^ namaSbbKhusus.hashCode ^ coaSatu.hashCode;
}
