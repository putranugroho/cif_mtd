import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class SetupTransModel {

  const SetupTransModel({
    required this.id,
    required this.kdTrans,
    required this.namaTrans,
    required this.kodePt,
    required this.glDeb,
    required this.namaDeb,
    required this.glKre,
    required this.namaKre,
    required this.modul,
    required this.hutangPiutang,
    required this.createdDate,
  });

  final int id;
  final String kdTrans;
  final String namaTrans;
  final String kodePt;
  final String glDeb;
  final String namaDeb;
  final String glKre;
  final String namaKre;
  final String modul;
  final dynamic hutangPiutang;
  final String createdDate;

  factory SetupTransModel.fromJson(Map<String,dynamic> json) => SetupTransModel(
    id: json['id'] as int,
    kdTrans: json['kd_trans'].toString(),
    namaTrans: json['nama_trans'].toString(),
    kodePt: json['kode_pt'].toString(),
    glDeb: json['gl_deb'].toString(),
    namaDeb: json['nama_deb'].toString(),
    glKre: json['gl_kre'].toString(),
    namaKre: json['nama_kre'].toString(),
    modul: json['modul'].toString(),
    hutangPiutang: json['hutang_piutang'] as dynamic,
    createdDate: json['createdDate'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kd_trans': kdTrans,
    'nama_trans': namaTrans,
    'kode_pt': kodePt,
    'gl_deb': glDeb,
    'nama_deb': namaDeb,
    'gl_kre': glKre,
    'nama_kre': namaKre,
    'modul': modul,
    'hutang_piutang': hutangPiutang,
    'createdDate': createdDate
  };

  SetupTransModel clone() => SetupTransModel(
    id: id,
    kdTrans: kdTrans,
    namaTrans: namaTrans,
    kodePt: kodePt,
    glDeb: glDeb,
    namaDeb: namaDeb,
    glKre: glKre,
    namaKre: namaKre,
    modul: modul,
    hutangPiutang: hutangPiutang,
    createdDate: createdDate
  );


  SetupTransModel copyWith({
    int? id,
    String? kdTrans,
    String? namaTrans,
    String? kodePt,
    String? glDeb,
    String? namaDeb,
    String? glKre,
    String? namaKre,
    String? modul,
    dynamic? hutangPiutang,
    String? createdDate
  }) => SetupTransModel(
    id: id ?? this.id,
    kdTrans: kdTrans ?? this.kdTrans,
    namaTrans: namaTrans ?? this.namaTrans,
    kodePt: kodePt ?? this.kodePt,
    glDeb: glDeb ?? this.glDeb,
    namaDeb: namaDeb ?? this.namaDeb,
    glKre: glKre ?? this.glKre,
    namaKre: namaKre ?? this.namaKre,
    modul: modul ?? this.modul,
    hutangPiutang: hutangPiutang ?? this.hutangPiutang,
    createdDate: createdDate ?? this.createdDate,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SetupTransModel && id == other.id && kdTrans == other.kdTrans && namaTrans == other.namaTrans && kodePt == other.kodePt && glDeb == other.glDeb && namaDeb == other.namaDeb && glKre == other.glKre && namaKre == other.namaKre && modul == other.modul && hutangPiutang == other.hutangPiutang && createdDate == other.createdDate;

  @override
  int get hashCode => id.hashCode ^ kdTrans.hashCode ^ namaTrans.hashCode ^ kodePt.hashCode ^ glDeb.hashCode ^ namaDeb.hashCode ^ glKre.hashCode ^ namaKre.hashCode ^ modul.hashCode ^ hutangPiutang.hashCode ^ createdDate.hashCode;
}
