import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class PejabatModel {

  const PejabatModel({
    required this.id,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.nik,
    required this.namaPejabat,
    required this.noHpPejabat,
    required this.idJabatan,
    required this.kodeJabatan,
    required this.department,
  });

  final int id;
  final String kodeKantor;
  final String kodeInduk;
  final String nik;
  final String namaPejabat;
  final String noHpPejabat;
  final String idJabatan;
  final String kodeJabatan;
  final String department;

  factory PejabatModel.fromJson(Map<String,dynamic> json) => PejabatModel(
    id: json['id'] as int,
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString(),
    nik: json['nik'].toString(),
    namaPejabat: json['nama_pejabat'].toString(),
    noHpPejabat: json['no_hp_pejabat'].toString(),
    idJabatan: json['id_jabatan'].toString(),
    kodeJabatan: json['kode_jabatan'].toString(),
    department: json['department'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk,
    'nik': nik,
    'nama_pejabat': namaPejabat,
    'no_hp_pejabat': noHpPejabat,
    'id_jabatan': idJabatan,
    'kode_jabatan': kodeJabatan,
    'department': department
  };

  PejabatModel clone() => PejabatModel(
    id: id,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk,
    nik: nik,
    namaPejabat: namaPejabat,
    noHpPejabat: noHpPejabat,
    idJabatan: idJabatan,
    kodeJabatan: kodeJabatan,
    department: department
  );


  PejabatModel copyWith({
    int? id,
    String? kodeKantor,
    String? kodeInduk,
    String? nik,
    String? namaPejabat,
    String? noHpPejabat,
    String? idJabatan,
    String? kodeJabatan,
    String? department
  }) => PejabatModel(
    id: id ?? this.id,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
    nik: nik ?? this.nik,
    namaPejabat: namaPejabat ?? this.namaPejabat,
    noHpPejabat: noHpPejabat ?? this.noHpPejabat,
    idJabatan: idJabatan ?? this.idJabatan,
    kodeJabatan: kodeJabatan ?? this.kodeJabatan,
    department: department ?? this.department,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is PejabatModel && id == other.id && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && nik == other.nik && namaPejabat == other.namaPejabat && noHpPejabat == other.noHpPejabat && idJabatan == other.idJabatan && kodeJabatan == other.kodeJabatan && department == other.department;

  @override
  int get hashCode => id.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ nik.hashCode ^ namaPejabat.hashCode ^ noHpPejabat.hashCode ^ idJabatan.hashCode ^ kodeJabatan.hashCode ^ department.hashCode;
}
