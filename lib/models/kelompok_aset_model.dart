import 'package:flutter/foundation.dart';

@immutable
class KelompokAsetModel {
  const KelompokAsetModel({
    required this.id,
    required this.kodeKelompok,
    required this.namaKelompokn,
  });

  final int id;
  final String kodeKelompok;
  final String namaKelompokn;

  factory KelompokAsetModel.fromJson(Map<String, dynamic> json) => KelompokAsetModel(id: json['id'] as int, kodeKelompok: json['kode_kelompok'].toString(), namaKelompokn: json['nama_kelompokn'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_kelompok': kodeKelompok,
        'nama_kelompokn': namaKelompokn
      };

  KelompokAsetModel clone() => KelompokAsetModel(id: id, kodeKelompok: kodeKelompok, namaKelompokn: namaKelompokn);

  KelompokAsetModel copyWith({int? id, String? kodeKelompok, String? namaKelompokn}) => KelompokAsetModel(
        id: id ?? this.id,
        kodeKelompok: kodeKelompok ?? this.kodeKelompok,
        namaKelompokn: namaKelompokn ?? this.namaKelompokn,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is KelompokAsetModel && id == other.id && kodeKelompok == other.kodeKelompok && namaKelompokn == other.namaKelompokn;

  @override
  int get hashCode => id.hashCode ^ kodeKelompok.hashCode ^ namaKelompokn.hashCode;
}
