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
    required this.namasbbtransaksihutang,
    required this.namasbbpphhutang,
    required this.namasbbppnhutang,
    required this.namasbbtransaksipiutang,
    required this.namasbbpphpiutang,
    required this.namasbbppnpiutang,
  });

  final int id;
  final String kodePt;
  final String sbbtransaksihutang;
  final String sbbpphhutang;
  final String sbbppnhutang;
  final String sbbtransaksipiutang;
  final String sbbppnpiutang;
  final String sbbpphpiutang;
  final String namasbbtransaksihutang;
  final String namasbbpphhutang;
  final String namasbbppnhutang;
  final String namasbbtransaksipiutang;
  final String namasbbpphpiutang;
  final String namasbbppnpiutang;

  factory SetupHutangPiutangModel.fromJson(Map<String,dynamic> json) => SetupHutangPiutangModel(
    id: json['id'] as int,
    kodePt: json['kode_pt'].toString(),
    sbbtransaksihutang: json['sbbtransaksihutang'].toString(),
    sbbpphhutang: json['sbbpphhutang'].toString(),
    sbbppnhutang: json['sbbppnhutang'].toString(),
    sbbtransaksipiutang: json['sbbtransaksipiutang'].toString(),
    sbbppnpiutang: json['sbbppnpiutang'].toString(),
    sbbpphpiutang: json['sbbpphpiutang'].toString(),
    namasbbtransaksihutang: json['namasbbtransaksihutang'].toString(),
    namasbbpphhutang: json['namasbbpphhutang'].toString(),
    namasbbppnhutang: json['namasbbppnhutang'].toString(),
    namasbbtransaksipiutang: json['namasbbtransaksipiutang'].toString(),
    namasbbpphpiutang: json['namasbbpphpiutang'].toString(),
    namasbbppnpiutang: json['namasbbppnpiutang'].toString()
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
    'namasbbtransaksihutang': namasbbtransaksihutang,
    'namasbbpphhutang': namasbbpphhutang,
    'namasbbppnhutang': namasbbppnhutang,
    'namasbbtransaksipiutang': namasbbtransaksipiutang,
    'namasbbpphpiutang': namasbbpphpiutang,
    'namasbbppnpiutang': namasbbppnpiutang
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
    namasbbtransaksihutang: namasbbtransaksihutang,
    namasbbpphhutang: namasbbpphhutang,
    namasbbppnhutang: namasbbppnhutang,
    namasbbtransaksipiutang: namasbbtransaksipiutang,
    namasbbpphpiutang: namasbbpphpiutang,
    namasbbppnpiutang: namasbbppnpiutang
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
    String? namasbbtransaksihutang,
    String? namasbbpphhutang,
    String? namasbbppnhutang,
    String? namasbbtransaksipiutang,
    String? namasbbpphpiutang,
    String? namasbbppnpiutang
  }) => SetupHutangPiutangModel(
    id: id ?? this.id,
    kodePt: kodePt ?? this.kodePt,
    sbbtransaksihutang: sbbtransaksihutang ?? this.sbbtransaksihutang,
    sbbpphhutang: sbbpphhutang ?? this.sbbpphhutang,
    sbbppnhutang: sbbppnhutang ?? this.sbbppnhutang,
    sbbtransaksipiutang: sbbtransaksipiutang ?? this.sbbtransaksipiutang,
    sbbppnpiutang: sbbppnpiutang ?? this.sbbppnpiutang,
    sbbpphpiutang: sbbpphpiutang ?? this.sbbpphpiutang,
    namasbbtransaksihutang: namasbbtransaksihutang ?? this.namasbbtransaksihutang,
    namasbbpphhutang: namasbbpphhutang ?? this.namasbbpphhutang,
    namasbbppnhutang: namasbbppnhutang ?? this.namasbbppnhutang,
    namasbbtransaksipiutang: namasbbtransaksipiutang ?? this.namasbbtransaksipiutang,
    namasbbpphpiutang: namasbbpphpiutang ?? this.namasbbpphpiutang,
    namasbbppnpiutang: namasbbppnpiutang ?? this.namasbbppnpiutang,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SetupHutangPiutangModel && id == other.id && kodePt == other.kodePt && sbbtransaksihutang == other.sbbtransaksihutang && sbbpphhutang == other.sbbpphhutang && sbbppnhutang == other.sbbppnhutang && sbbtransaksipiutang == other.sbbtransaksipiutang && sbbppnpiutang == other.sbbppnpiutang && sbbpphpiutang == other.sbbpphpiutang && namasbbtransaksihutang == other.namasbbtransaksihutang && namasbbpphhutang == other.namasbbpphhutang && namasbbppnhutang == other.namasbbppnhutang && namasbbtransaksipiutang == other.namasbbtransaksipiutang && namasbbpphpiutang == other.namasbbpphpiutang && namasbbppnpiutang == other.namasbbppnpiutang;

  @override
  int get hashCode => id.hashCode ^ kodePt.hashCode ^ sbbtransaksihutang.hashCode ^ sbbpphhutang.hashCode ^ sbbppnhutang.hashCode ^ sbbtransaksipiutang.hashCode ^ sbbppnpiutang.hashCode ^ sbbpphpiutang.hashCode ^ namasbbtransaksihutang.hashCode ^ namasbbpphhutang.hashCode ^ namasbbppnhutang.hashCode ^ namasbbtransaksipiutang.hashCode ^ namasbbpphpiutang.hashCode ^ namasbbppnpiutang.hashCode;
}
