import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class SetupTransModel {

  const SetupTransModel({
    required this.kdTrans,
    required this.namaTrans,
    required this.glDeb,
    required this.namaDeb,
    required this.glKre,
    required this.namaKre,
    required this.modul,
  });

  final String kdTrans;
  final String namaTrans;
  final String glDeb;
  final String namaDeb;
  final String glKre;
  final String namaKre;
  final String modul;

  factory SetupTransModel.fromJson(Map<String,dynamic> json) => SetupTransModel(
    kdTrans: json['kd_trans'].toString(),
    namaTrans: json['nama_trans'].toString(),
    glDeb: json['gl_deb'].toString(),
    namaDeb: json['nama_deb'].toString(),
    glKre: json['gl_kre'].toString(),
    namaKre: json['nama_kre'].toString(),
    modul: json['modul'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'kd_trans': kdTrans,
    'nama_trans': namaTrans,
    'gl_deb': glDeb,
    'nama_deb': namaDeb,
    'gl_kre': glKre,
    'nama_kre': namaKre,
    'modul': modul
  };

  SetupTransModel clone() => SetupTransModel(
    kdTrans: kdTrans,
    namaTrans: namaTrans,
    glDeb: glDeb,
    namaDeb: namaDeb,
    glKre: glKre,
    namaKre: namaKre,
    modul: modul
  );


  SetupTransModel copyWith({
    String? kdTrans,
    String? namaTrans,
    String? glDeb,
    String? namaDeb,
    String? glKre,
    String? namaKre,
    String? modul
  }) => SetupTransModel(
    kdTrans: kdTrans ?? this.kdTrans,
    namaTrans: namaTrans ?? this.namaTrans,
    glDeb: glDeb ?? this.glDeb,
    namaDeb: namaDeb ?? this.namaDeb,
    glKre: glKre ?? this.glKre,
    namaKre: namaKre ?? this.namaKre,
    modul: modul ?? this.modul,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SetupTransModel && kdTrans == other.kdTrans && namaTrans == other.namaTrans && glDeb == other.glDeb && namaDeb == other.namaDeb && glKre == other.glKre && namaKre == other.namaKre && modul == other.modul;

  @override
  int get hashCode => kdTrans.hashCode ^ namaTrans.hashCode ^ glDeb.hashCode ^ namaDeb.hashCode ^ glKre.hashCode ^ namaKre.hashCode ^ modul.hashCode;
}
