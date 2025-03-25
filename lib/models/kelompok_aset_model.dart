import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class KelompokAsetModel {

  const KelompokAsetModel({
    required this.kodeKelompok,
    required this.namaKelompok,
  });

  final String kodeKelompok;
  final String namaKelompok;

  factory KelompokAsetModel.fromJson(Map<String,dynamic> json) => KelompokAsetModel(
    kodeKelompok: json['kode_kelompok'].toString(),
    namaKelompok: json['nama_kelompok'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'kode_kelompok': kodeKelompok,
    'nama_kelompok': namaKelompok
  };

  KelompokAsetModel clone() => KelompokAsetModel(
    kodeKelompok: kodeKelompok,
    namaKelompok: namaKelompok
  );


  KelompokAsetModel copyWith({
    String? kodeKelompok,
    String? namaKelompok
  }) => KelompokAsetModel(
    kodeKelompok: kodeKelompok ?? this.kodeKelompok,
    namaKelompok: namaKelompok ?? this.namaKelompok,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is KelompokAsetModel && kodeKelompok == other.kodeKelompok && namaKelompok == other.namaKelompok;

  @override
  int get hashCode => kodeKelompok.hashCode ^ namaKelompok.hashCode;
}
