import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class PejabatModel {

  const PejabatModel({
    required this.kodeKantor,
    required this.kodeInduk,
    required this.nik,
    required this.namaPejabat,
    required this.noHpPejabat,
    required this.kodeJabatan,
    required this.namaJabatan,
  });

  final String kodeKantor;
  final String kodeInduk;
  final String nik;
  final String namaPejabat;
  final String noHpPejabat;
  final String kodeJabatan;
  final String namaJabatan;

  factory PejabatModel.fromJson(Map<String,dynamic> json) => PejabatModel(
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString(),
    nik: json['nik'].toString(),
    namaPejabat: json['nama_pejabat'].toString(),
    noHpPejabat: json['no_hp_pejabat'].toString(),
    kodeJabatan: json['kode_jabatan'].toString(),
    namaJabatan: json['nama_jabatan'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk,
    'nik': nik,
    'nama_pejabat': namaPejabat,
    'no_hp_pejabat': noHpPejabat,
    'kode_jabatan': kodeJabatan,
    'nama_jabatan': namaJabatan
  };

  PejabatModel clone() => PejabatModel(
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk,
    nik: nik,
    namaPejabat: namaPejabat,
    noHpPejabat: noHpPejabat,
    kodeJabatan: kodeJabatan,
    namaJabatan: namaJabatan
  );


  PejabatModel copyWith({
    String? kodeKantor,
    String? kodeInduk,
    String? nik,
    String? namaPejabat,
    String? noHpPejabat,
    String? kodeJabatan,
    String? namaJabatan
  }) => PejabatModel(
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
    nik: nik ?? this.nik,
    namaPejabat: namaPejabat ?? this.namaPejabat,
    noHpPejabat: noHpPejabat ?? this.noHpPejabat,
    kodeJabatan: kodeJabatan ?? this.kodeJabatan,
    namaJabatan: namaJabatan ?? this.namaJabatan,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is PejabatModel && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && nik == other.nik && namaPejabat == other.namaPejabat && noHpPejabat == other.noHpPejabat && kodeJabatan == other.kodeJabatan && namaJabatan == other.namaJabatan;

  @override
  int get hashCode => kodeKantor.hashCode ^ kodeInduk.hashCode ^ nik.hashCode ^ namaPejabat.hashCode ^ noHpPejabat.hashCode ^ kodeJabatan.hashCode ^ namaJabatan.hashCode;
}
