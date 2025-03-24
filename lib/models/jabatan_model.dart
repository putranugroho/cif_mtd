import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class JabatanModel {

  const JabatanModel({
    required this.kodeJabatan,
    required this.namaJabatan,
    required this.lvlJabatan,
  });

  final String kodeJabatan;
  final String namaJabatan;
  final String lvlJabatan;

  factory JabatanModel.fromJson(Map<String,dynamic> json) => JabatanModel(
    kodeJabatan: json['kode_jabatan'].toString(),
    namaJabatan: json['nama_jabatan'].toString(),
    lvlJabatan: json['lvl_jabatan'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'kode_jabatan': kodeJabatan,
    'nama_jabatan': namaJabatan,
    'lvl_jabatan': lvlJabatan
  };

  JabatanModel clone() => JabatanModel(
    kodeJabatan: kodeJabatan,
    namaJabatan: namaJabatan,
    lvlJabatan: lvlJabatan
  );


  JabatanModel copyWith({
    String? kodeJabatan,
    String? namaJabatan,
    String? lvlJabatan
  }) => JabatanModel(
    kodeJabatan: kodeJabatan ?? this.kodeJabatan,
    namaJabatan: namaJabatan ?? this.namaJabatan,
    lvlJabatan: lvlJabatan ?? this.lvlJabatan,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is JabatanModel && kodeJabatan == other.kodeJabatan && namaJabatan == other.namaJabatan && lvlJabatan == other.lvlJabatan;

  @override
  int get hashCode => kodeJabatan.hashCode ^ namaJabatan.hashCode ^ lvlJabatan.hashCode;
}
