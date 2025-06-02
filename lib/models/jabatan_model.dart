import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class JabatanModel {

  const JabatanModel({
    required this.id,
    required this.kodeJabatan,
    required this.namaJabatan,
    required this.idLevel,
    required this.kelJabatan,
  });

  final int id;
  final String kodeJabatan;
  final String namaJabatan;
  final dynamic idLevel;
  final String kelJabatan;

  factory JabatanModel.fromJson(Map<String,dynamic> json) => JabatanModel(
    id: json['id'] as int,
    kodeJabatan: json['kode_jabatan'].toString(),
    namaJabatan: json['nama_jabatan'].toString(),
    idLevel: json['id_level'] as dynamic,
    kelJabatan: json['kel_jabatan'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kode_jabatan': kodeJabatan,
    'nama_jabatan': namaJabatan,
    'id_level': idLevel,
    'kel_jabatan': kelJabatan
  };

  JabatanModel clone() => JabatanModel(
    id: id,
    kodeJabatan: kodeJabatan,
    namaJabatan: namaJabatan,
    idLevel: idLevel,
    kelJabatan: kelJabatan
  );


  JabatanModel copyWith({
    int? id,
    String? kodeJabatan,
    String? namaJabatan,
    dynamic? idLevel,
    String? kelJabatan
  }) => JabatanModel(
    id: id ?? this.id,
    kodeJabatan: kodeJabatan ?? this.kodeJabatan,
    namaJabatan: namaJabatan ?? this.namaJabatan,
    idLevel: idLevel ?? this.idLevel,
    kelJabatan: kelJabatan ?? this.kelJabatan,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is JabatanModel && id == other.id && kodeJabatan == other.kodeJabatan && namaJabatan == other.namaJabatan && idLevel == other.idLevel && kelJabatan == other.kelJabatan;

  @override
  int get hashCode => id.hashCode ^ kodeJabatan.hashCode ^ namaJabatan.hashCode ^ idLevel.hashCode ^ kelJabatan.hashCode;
}
