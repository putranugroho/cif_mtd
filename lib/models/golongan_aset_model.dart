import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class GolonganAsetModel {

  const GolonganAsetModel({
    required this.id,
    required this.kodeGolongan,
    required this.namaGolongan,
    required this.masaSusut,
    required this.nilaiDeclining,
    required this.sbbAset,
    required this.sbbPenyusutan,
    required this.sbbBiayaPenyusutan,
    required this.sbbRugiRevaluasi,
    required this.sbbLabaRevaluasi,
    required this.sbbRugiJual,
    required this.sbbLabaJual,
    required this.sbbPpn,
    required this.sbbPph,
    required this.sbbBiayaPerbaikan,
  });

  final int id;
  final String kodeGolongan;
  final String namaGolongan;
  final String masaSusut;
  final String nilaiDeclining;
  final dynamic sbbAset;
  final dynamic sbbPenyusutan;
  final dynamic sbbBiayaPenyusutan;
  final dynamic sbbRugiRevaluasi;
  final dynamic sbbLabaRevaluasi;
  final dynamic sbbRugiJual;
  final dynamic sbbLabaJual;
  final dynamic sbbPpn;
  final dynamic sbbPph;
  final dynamic sbbBiayaPerbaikan;

  factory GolonganAsetModel.fromJson(Map<String,dynamic> json) => GolonganAsetModel(
    id: json['id'] as int,
    kodeGolongan: json['kode_golongan'].toString(),
    namaGolongan: json['nama_golongan'].toString(),
    masaSusut: json['masa_susut'].toString(),
    nilaiDeclining: json['nilai_declining'].toString(),
    sbbAset: json['sbb_aset'] as dynamic,
    sbbPenyusutan: json['sbb_penyusutan'] as dynamic,
    sbbBiayaPenyusutan: json['sbb_biaya_penyusutan'] as dynamic,
    sbbRugiRevaluasi: json['sbb_rugi_revaluasi'] as dynamic,
    sbbLabaRevaluasi: json['sbb_laba_revaluasi'] as dynamic,
    sbbRugiJual: json['sbb_rugi_jual'] as dynamic,
    sbbLabaJual: json['sbb_laba_jual'] as dynamic,
    sbbPpn: json['sbb_ppn'] as dynamic,
    sbbPph: json['sbb_pph'] as dynamic,
    sbbBiayaPerbaikan: json['sbb_biaya_perbaikan'] as dynamic
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kode_golongan': kodeGolongan,
    'nama_golongan': namaGolongan,
    'masa_susut': masaSusut,
    'nilai_declining': nilaiDeclining,
    'sbb_aset': sbbAset,
    'sbb_penyusutan': sbbPenyusutan,
    'sbb_biaya_penyusutan': sbbBiayaPenyusutan,
    'sbb_rugi_revaluasi': sbbRugiRevaluasi,
    'sbb_laba_revaluasi': sbbLabaRevaluasi,
    'sbb_rugi_jual': sbbRugiJual,
    'sbb_laba_jual': sbbLabaJual,
    'sbb_ppn': sbbPpn,
    'sbb_pph': sbbPph,
    'sbb_biaya_perbaikan': sbbBiayaPerbaikan
  };

  GolonganAsetModel clone() => GolonganAsetModel(
    id: id,
    kodeGolongan: kodeGolongan,
    namaGolongan: namaGolongan,
    masaSusut: masaSusut,
    nilaiDeclining: nilaiDeclining,
    sbbAset: sbbAset,
    sbbPenyusutan: sbbPenyusutan,
    sbbBiayaPenyusutan: sbbBiayaPenyusutan,
    sbbRugiRevaluasi: sbbRugiRevaluasi,
    sbbLabaRevaluasi: sbbLabaRevaluasi,
    sbbRugiJual: sbbRugiJual,
    sbbLabaJual: sbbLabaJual,
    sbbPpn: sbbPpn,
    sbbPph: sbbPph,
    sbbBiayaPerbaikan: sbbBiayaPerbaikan
  );


  GolonganAsetModel copyWith({
    int? id,
    String? kodeGolongan,
    String? namaGolongan,
    String? masaSusut,
    String? nilaiDeclining,
    dynamic? sbbAset,
    dynamic? sbbPenyusutan,
    dynamic? sbbBiayaPenyusutan,
    dynamic? sbbRugiRevaluasi,
    dynamic? sbbLabaRevaluasi,
    dynamic? sbbRugiJual,
    dynamic? sbbLabaJual,
    dynamic? sbbPpn,
    dynamic? sbbPph,
    dynamic? sbbBiayaPerbaikan
  }) => GolonganAsetModel(
    id: id ?? this.id,
    kodeGolongan: kodeGolongan ?? this.kodeGolongan,
    namaGolongan: namaGolongan ?? this.namaGolongan,
    masaSusut: masaSusut ?? this.masaSusut,
    nilaiDeclining: nilaiDeclining ?? this.nilaiDeclining,
    sbbAset: sbbAset ?? this.sbbAset,
    sbbPenyusutan: sbbPenyusutan ?? this.sbbPenyusutan,
    sbbBiayaPenyusutan: sbbBiayaPenyusutan ?? this.sbbBiayaPenyusutan,
    sbbRugiRevaluasi: sbbRugiRevaluasi ?? this.sbbRugiRevaluasi,
    sbbLabaRevaluasi: sbbLabaRevaluasi ?? this.sbbLabaRevaluasi,
    sbbRugiJual: sbbRugiJual ?? this.sbbRugiJual,
    sbbLabaJual: sbbLabaJual ?? this.sbbLabaJual,
    sbbPpn: sbbPpn ?? this.sbbPpn,
    sbbPph: sbbPph ?? this.sbbPph,
    sbbBiayaPerbaikan: sbbBiayaPerbaikan ?? this.sbbBiayaPerbaikan,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is GolonganAsetModel && id == other.id && kodeGolongan == other.kodeGolongan && namaGolongan == other.namaGolongan && masaSusut == other.masaSusut && nilaiDeclining == other.nilaiDeclining && sbbAset == other.sbbAset && sbbPenyusutan == other.sbbPenyusutan && sbbBiayaPenyusutan == other.sbbBiayaPenyusutan && sbbRugiRevaluasi == other.sbbRugiRevaluasi && sbbLabaRevaluasi == other.sbbLabaRevaluasi && sbbRugiJual == other.sbbRugiJual && sbbLabaJual == other.sbbLabaJual && sbbPpn == other.sbbPpn && sbbPph == other.sbbPph && sbbBiayaPerbaikan == other.sbbBiayaPerbaikan;

  @override
  int get hashCode => id.hashCode ^ kodeGolongan.hashCode ^ namaGolongan.hashCode ^ masaSusut.hashCode ^ nilaiDeclining.hashCode ^ sbbAset.hashCode ^ sbbPenyusutan.hashCode ^ sbbBiayaPenyusutan.hashCode ^ sbbRugiRevaluasi.hashCode ^ sbbLabaRevaluasi.hashCode ^ sbbRugiJual.hashCode ^ sbbLabaJual.hashCode ^ sbbPpn.hashCode ^ sbbPph.hashCode ^ sbbBiayaPerbaikan.hashCode;
}
