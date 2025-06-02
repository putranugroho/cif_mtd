import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class SetupHutangPiutangModel {

  const SetupHutangPiutangModel({
    required this.id,
    required this.kodePt,
    required this.sbbtransaksihutang,
    required this.sbbpphhutang,
    required this.sbbppnhutang,
    required this.sbbtransaksipiutang,
    required this.sbbppnpiutang,
    required this.sbbpphpiutang,
    required this.sbblawanhutang,
    required this.sbblawanpiutang,
    required this.sbbhpppiutang,
    required this.sbbpersedianpiutang,
    required this.namasbbtransaksihutang,
    required this.namasbbpphhutang,
    required this.namasbbppnhutang,
    required this.namasbbtransaksipiutang,
    required this.namasbbpphpiutang,
    required this.namasbbppnpiutang,
    required this.namasbblawanhutang,
    required this.namasbblawanpiutang,
    required this.namasbbhpppiutang,
    required this.namasbbpersedianpiutang,
  });

  final int id;
  final String kodePt;
  final String sbbtransaksihutang;
  final String sbbpphhutang;
  final String sbbppnhutang;
  final String sbbtransaksipiutang;
  final String sbbppnpiutang;
  final String sbbpphpiutang;
  final String sbblawanhutang;
  final String sbblawanpiutang;
  final String sbbhpppiutang;
  final String sbbpersedianpiutang;
  final String namasbbtransaksihutang;
  final String namasbbpphhutang;
  final String namasbbppnhutang;
  final String namasbbtransaksipiutang;
  final String namasbbpphpiutang;
  final String namasbbppnpiutang;
  final String namasbblawanhutang;
  final String namasbblawanpiutang;
  final String namasbbhpppiutang;
  final String namasbbpersedianpiutang;

  factory SetupHutangPiutangModel.fromJson(Map<String,dynamic> json) => SetupHutangPiutangModel(
    id: json['id'] as int,
    kodePt: json['kode_pt'].toString(),
    sbbtransaksihutang: json['sbbtransaksihutang'].toString(),
    sbbpphhutang: json['sbbpphhutang'].toString(),
    sbbppnhutang: json['sbbppnhutang'].toString(),
    sbbtransaksipiutang: json['sbbtransaksipiutang'].toString(),
    sbbppnpiutang: json['sbbppnpiutang'].toString(),
    sbbpphpiutang: json['sbbpphpiutang'].toString(),
    sbblawanhutang: json['sbblawanhutang'].toString(),
    sbblawanpiutang: json['sbblawanpiutang'].toString(),
    sbbhpppiutang: json['sbbhpppiutang'].toString(),
    sbbpersedianpiutang: json['sbbpersedianpiutang'].toString(),
    namasbbtransaksihutang: json['namasbbtransaksihutang'].toString(),
    namasbbpphhutang: json['namasbbpphhutang'].toString(),
    namasbbppnhutang: json['namasbbppnhutang'].toString(),
    namasbbtransaksipiutang: json['namasbbtransaksipiutang'].toString(),
    namasbbpphpiutang: json['namasbbpphpiutang'].toString(),
    namasbbppnpiutang: json['namasbbppnpiutang'].toString(),
    namasbblawanhutang: json['namasbblawanhutang'].toString(),
    namasbblawanpiutang: json['namasbblawanpiutang'].toString(),
    namasbbhpppiutang: json['namasbbhpppiutang'].toString(),
    namasbbpersedianpiutang: json['namasbbpersedianpiutang'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kode_pt': kodePt,
    'sbbtransaksihutang': sbbtransaksihutang,
    'sbbpphhutang': sbbpphhutang,
    'sbbppnhutang': sbbppnhutang,
    'sbbtransaksipiutang': sbbtransaksipiutang,
    'sbbppnpiutang': sbbppnpiutang,
    'sbbpphpiutang': sbbpphpiutang,
    'sbblawanhutang': sbblawanhutang,
    'sbblawanpiutang': sbblawanpiutang,
    'sbbhpppiutang': sbbhpppiutang,
    'sbbpersedianpiutang': sbbpersedianpiutang,
    'namasbbtransaksihutang': namasbbtransaksihutang,
    'namasbbpphhutang': namasbbpphhutang,
    'namasbbppnhutang': namasbbppnhutang,
    'namasbbtransaksipiutang': namasbbtransaksipiutang,
    'namasbbpphpiutang': namasbbpphpiutang,
    'namasbbppnpiutang': namasbbppnpiutang,
    'namasbblawanhutang': namasbblawanhutang,
    'namasbblawanpiutang': namasbblawanpiutang,
    'namasbbhpppiutang': namasbbhpppiutang,
    'namasbbpersedianpiutang': namasbbpersedianpiutang
  };

  SetupHutangPiutangModel clone() => SetupHutangPiutangModel(
    id: id,
    kodePt: kodePt,
    sbbtransaksihutang: sbbtransaksihutang,
    sbbpphhutang: sbbpphhutang,
    sbbppnhutang: sbbppnhutang,
    sbbtransaksipiutang: sbbtransaksipiutang,
    sbbppnpiutang: sbbppnpiutang,
    sbbpphpiutang: sbbpphpiutang,
    sbblawanhutang: sbblawanhutang,
    sbblawanpiutang: sbblawanpiutang,
    sbbhpppiutang: sbbhpppiutang,
    sbbpersedianpiutang: sbbpersedianpiutang,
    namasbbtransaksihutang: namasbbtransaksihutang,
    namasbbpphhutang: namasbbpphhutang,
    namasbbppnhutang: namasbbppnhutang,
    namasbbtransaksipiutang: namasbbtransaksipiutang,
    namasbbpphpiutang: namasbbpphpiutang,
    namasbbppnpiutang: namasbbppnpiutang,
    namasbblawanhutang: namasbblawanhutang,
    namasbblawanpiutang: namasbblawanpiutang,
    namasbbhpppiutang: namasbbhpppiutang,
    namasbbpersedianpiutang: namasbbpersedianpiutang
  );


  SetupHutangPiutangModel copyWith({
    int? id,
    String? kodePt,
    String? sbbtransaksihutang,
    String? sbbpphhutang,
    String? sbbppnhutang,
    String? sbbtransaksipiutang,
    String? sbbppnpiutang,
    String? sbbpphpiutang,
    String? sbblawanhutang,
    String? sbblawanpiutang,
    String? sbbhpppiutang,
    String? sbbpersedianpiutang,
    String? namasbbtransaksihutang,
    String? namasbbpphhutang,
    String? namasbbppnhutang,
    String? namasbbtransaksipiutang,
    String? namasbbpphpiutang,
    String? namasbbppnpiutang,
    String? namasbblawanhutang,
    String? namasbblawanpiutang,
    String? namasbbhpppiutang,
    String? namasbbpersedianpiutang
  }) => SetupHutangPiutangModel(
    id: id ?? this.id,
    kodePt: kodePt ?? this.kodePt,
    sbbtransaksihutang: sbbtransaksihutang ?? this.sbbtransaksihutang,
    sbbpphhutang: sbbpphhutang ?? this.sbbpphhutang,
    sbbppnhutang: sbbppnhutang ?? this.sbbppnhutang,
    sbbtransaksipiutang: sbbtransaksipiutang ?? this.sbbtransaksipiutang,
    sbbppnpiutang: sbbppnpiutang ?? this.sbbppnpiutang,
    sbbpphpiutang: sbbpphpiutang ?? this.sbbpphpiutang,
    sbblawanhutang: sbblawanhutang ?? this.sbblawanhutang,
    sbblawanpiutang: sbblawanpiutang ?? this.sbblawanpiutang,
    sbbhpppiutang: sbbhpppiutang ?? this.sbbhpppiutang,
    sbbpersedianpiutang: sbbpersedianpiutang ?? this.sbbpersedianpiutang,
    namasbbtransaksihutang: namasbbtransaksihutang ?? this.namasbbtransaksihutang,
    namasbbpphhutang: namasbbpphhutang ?? this.namasbbpphhutang,
    namasbbppnhutang: namasbbppnhutang ?? this.namasbbppnhutang,
    namasbbtransaksipiutang: namasbbtransaksipiutang ?? this.namasbbtransaksipiutang,
    namasbbpphpiutang: namasbbpphpiutang ?? this.namasbbpphpiutang,
    namasbbppnpiutang: namasbbppnpiutang ?? this.namasbbppnpiutang,
    namasbblawanhutang: namasbblawanhutang ?? this.namasbblawanhutang,
    namasbblawanpiutang: namasbblawanpiutang ?? this.namasbblawanpiutang,
    namasbbhpppiutang: namasbbhpppiutang ?? this.namasbbhpppiutang,
    namasbbpersedianpiutang: namasbbpersedianpiutang ?? this.namasbbpersedianpiutang,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SetupHutangPiutangModel && id == other.id && kodePt == other.kodePt && sbbtransaksihutang == other.sbbtransaksihutang && sbbpphhutang == other.sbbpphhutang && sbbppnhutang == other.sbbppnhutang && sbbtransaksipiutang == other.sbbtransaksipiutang && sbbppnpiutang == other.sbbppnpiutang && sbbpphpiutang == other.sbbpphpiutang && sbblawanhutang == other.sbblawanhutang && sbblawanpiutang == other.sbblawanpiutang && sbbhpppiutang == other.sbbhpppiutang && sbbpersedianpiutang == other.sbbpersedianpiutang && namasbbtransaksihutang == other.namasbbtransaksihutang && namasbbpphhutang == other.namasbbpphhutang && namasbbppnhutang == other.namasbbppnhutang && namasbbtransaksipiutang == other.namasbbtransaksipiutang && namasbbpphpiutang == other.namasbbpphpiutang && namasbbppnpiutang == other.namasbbppnpiutang && namasbblawanhutang == other.namasbblawanhutang && namasbblawanpiutang == other.namasbblawanpiutang && namasbbhpppiutang == other.namasbbhpppiutang && namasbbpersedianpiutang == other.namasbbpersedianpiutang;

  @override
  int get hashCode => id.hashCode ^ kodePt.hashCode ^ sbbtransaksihutang.hashCode ^ sbbpphhutang.hashCode ^ sbbppnhutang.hashCode ^ sbbtransaksipiutang.hashCode ^ sbbppnpiutang.hashCode ^ sbbpphpiutang.hashCode ^ sbblawanhutang.hashCode ^ sbblawanpiutang.hashCode ^ sbbhpppiutang.hashCode ^ sbbpersedianpiutang.hashCode ^ namasbbtransaksihutang.hashCode ^ namasbbpphhutang.hashCode ^ namasbbppnhutang.hashCode ^ namasbbtransaksipiutang.hashCode ^ namasbbpphpiutang.hashCode ^ namasbbppnpiutang.hashCode ^ namasbblawanhutang.hashCode ^ namasbblawanpiutang.hashCode ^ namasbbhpppiutang.hashCode ^ namasbbpersedianpiutang.hashCode;
}
