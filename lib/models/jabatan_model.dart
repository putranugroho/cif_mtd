import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class JabatanModel {

  const JabatanModel({
    required this.id,
    required this.kodeJabatan,
    required this.namaJabatan,
    required this.lvlJabatan,
    required this.kelJabatan,
  });

  final int id;
  final String kodeJabatan;
  final String namaJabatan;
  final String lvlJabatan;
  final String kelJabatan;

  factory JabatanModel.fromJson(Map<String,dynamic> json) => JabatanModel(
    id: json['id'] as int,
    kodeJabatan: json['kode_jabatan'].toString(),
    namaJabatan: json['nama_jabatan'].toString(),
    lvlJabatan: json['lvl_jabatan'].toString(),
    kelJabatan: json['kel_jabatan'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kode_jabatan': kodeJabatan,
    'nama_jabatan': namaJabatan,
    'lvl_jabatan': lvlJabatan,
    'kel_jabatan': kelJabatan
  };

  JabatanModel clone() => JabatanModel(
    id: id,
    kodeJabatan: kodeJabatan,
    namaJabatan: namaJabatan,
    lvlJabatan: lvlJabatan,
    kelJabatan: kelJabatan
  );


  JabatanModel copyWith({
    int? id,
    String? kodeJabatan,
    String? namaJabatan,
    String? lvlJabatan,
    String? kelJabatan
  }) => JabatanModel(
    id: id ?? this.id,
    kodeJabatan: kodeJabatan ?? this.kodeJabatan,
    namaJabatan: namaJabatan ?? this.namaJabatan,
    lvlJabatan: lvlJabatan ?? this.lvlJabatan,
    kelJabatan: kelJabatan ?? this.kelJabatan,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is JabatanModel && id == other.id && kodeJabatan == other.kodeJabatan && namaJabatan == other.namaJabatan && lvlJabatan == other.lvlJabatan && kelJabatan == other.kelJabatan;

  @override
  int get hashCode => id.hashCode ^ kodeJabatan.hashCode ^ namaJabatan.hashCode ^ lvlJabatan.hashCode ^ kelJabatan.hashCode;
}
