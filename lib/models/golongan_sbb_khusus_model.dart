import 'package:flutter/foundation.dart';

@immutable
class GolonganSbbKhususModel {
  const GolonganSbbKhususModel({
    required this.id,
    required this.kodeGolongan,
    required this.namaGolongan,
    required this.lebihSatuAkun,
    required this.kodePt,
  });

  final int id;
  final String kodeGolongan;
  final String namaGolongan;
  final String lebihSatuAkun;
  final String kodePt;

  factory GolonganSbbKhususModel.fromJson(Map<String, dynamic> json) => GolonganSbbKhususModel(id: json['id'] as int, kodeGolongan: json['kode_golongan'].toString(), namaGolongan: json['nama_golongan'].toString(), lebihSatuAkun: json['lebih_satu_akun'].toString(), kodePt: json['kode_pt'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_golongan': kodeGolongan,
        'nama_golongan': namaGolongan,
        'lebih_satu_akun': lebihSatuAkun,
        'kode_pt': kodePt
      };

  GolonganSbbKhususModel clone() => GolonganSbbKhususModel(id: id, kodeGolongan: kodeGolongan, namaGolongan: namaGolongan, lebihSatuAkun: lebihSatuAkun, kodePt: kodePt);

  GolonganSbbKhususModel copyWith({int? id, String? kodeGolongan, String? namaGolongan, String? lebihSatuAkun, String? kodePt}) => GolonganSbbKhususModel(
        id: id ?? this.id,
        kodeGolongan: kodeGolongan ?? this.kodeGolongan,
        namaGolongan: namaGolongan ?? this.namaGolongan,
        lebihSatuAkun: lebihSatuAkun ?? this.lebihSatuAkun,
        kodePt: kodePt ?? this.kodePt,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is GolonganSbbKhususModel && id == other.id && kodeGolongan == other.kodeGolongan && namaGolongan == other.namaGolongan && lebihSatuAkun == other.lebihSatuAkun && kodePt == other.kodePt;

  @override
  int get hashCode => id.hashCode ^ kodeGolongan.hashCode ^ namaGolongan.hashCode ^ lebihSatuAkun.hashCode ^ kodePt.hashCode;
}
