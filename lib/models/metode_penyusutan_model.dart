import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class MetodePenyusutanModel {

  const MetodePenyusutanModel({
    required this.id,
    required this.metodePenyusutan,
    required this.nilaiAkhir,
    required this.kodePt,
    required this.sbbPendapatan,
    required this.namaSbbPendapatan,
    required this.declining,
  });

  final int id;
  final String metodePenyusutan;
  final int nilaiAkhir;
  final String kodePt;
  final String sbbPendapatan;
  final String namaSbbPendapatan;
  final String declining;

  factory MetodePenyusutanModel.fromJson(Map<String,dynamic> json) => MetodePenyusutanModel(
    id: json['id'] as int,
    metodePenyusutan: json['metode_penyusutan'].toString(),
    nilaiAkhir: json['nilai_akhir'] as int,
    kodePt: json['kode_pt'].toString(),
    sbbPendapatan: json['sbb_pendapatan'].toString(),
    namaSbbPendapatan: json['nama_sbb_pendapatan'].toString(),
    declining: json['declining'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'metode_penyusutan': metodePenyusutan,
    'nilai_akhir': nilaiAkhir,
    'kode_pt': kodePt,
    'sbb_pendapatan': sbbPendapatan,
    'nama_sbb_pendapatan': namaSbbPendapatan,
    'declining': declining
  };

  MetodePenyusutanModel clone() => MetodePenyusutanModel(
    id: id,
    metodePenyusutan: metodePenyusutan,
    nilaiAkhir: nilaiAkhir,
    kodePt: kodePt,
    sbbPendapatan: sbbPendapatan,
    namaSbbPendapatan: namaSbbPendapatan,
    declining: declining
  );


  MetodePenyusutanModel copyWith({
    int? id,
    String? metodePenyusutan,
    int? nilaiAkhir,
    String? kodePt,
    String? sbbPendapatan,
    String? namaSbbPendapatan,
    String? declining
  }) => MetodePenyusutanModel(
    id: id ?? this.id,
    metodePenyusutan: metodePenyusutan ?? this.metodePenyusutan,
    nilaiAkhir: nilaiAkhir ?? this.nilaiAkhir,
    kodePt: kodePt ?? this.kodePt,
    sbbPendapatan: sbbPendapatan ?? this.sbbPendapatan,
    namaSbbPendapatan: namaSbbPendapatan ?? this.namaSbbPendapatan,
    declining: declining ?? this.declining,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is MetodePenyusutanModel && id == other.id && metodePenyusutan == other.metodePenyusutan && nilaiAkhir == other.nilaiAkhir && kodePt == other.kodePt && sbbPendapatan == other.sbbPendapatan && namaSbbPendapatan == other.namaSbbPendapatan && declining == other.declining;

  @override
  int get hashCode => id.hashCode ^ metodePenyusutan.hashCode ^ nilaiAkhir.hashCode ^ kodePt.hashCode ^ sbbPendapatan.hashCode ^ namaSbbPendapatan.hashCode ^ declining.hashCode;
}
