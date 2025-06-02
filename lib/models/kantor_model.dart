import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class KantorModel {

  const KantorModel({
    required this.id,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.namaKantor,
    required this.statusKantor,
    required this.alamat,
    required this.kelurahan,
    required this.kecamatan,
    required this.kota,
    required this.provinsi,
    required this.kodePos,
    required this.telp,
    required this.fax,
  });

  final int id;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;
  final String namaKantor;
  final String statusKantor;
  final String alamat;
  final String kelurahan;
  final String kecamatan;
  final String kota;
  final String provinsi;
  final String kodePos;
  final dynamic telp;
  final dynamic fax;

  factory KantorModel.fromJson(Map<String,dynamic> json) => KantorModel(
    id: json['id'] as int,
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString(),
    namaKantor: json['nama_kantor'].toString(),
    statusKantor: json['status_kantor'].toString(),
    alamat: json['alamat'].toString(),
    kelurahan: json['kelurahan'].toString(),
    kecamatan: json['kecamatan'].toString(),
    kota: json['kota'].toString(),
    provinsi: json['provinsi'].toString(),
    kodePos: json['kode_pos'].toString(),
    telp: json['telp'] as dynamic,
    fax: json['fax'] as dynamic
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk,
    'nama_kantor': namaKantor,
    'status_kantor': statusKantor,
    'alamat': alamat,
    'kelurahan': kelurahan,
    'kecamatan': kecamatan,
    'kota': kota,
    'provinsi': provinsi,
    'kode_pos': kodePos,
    'telp': telp,
    'fax': fax
  };

  KantorModel clone() => KantorModel(
    id: id,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk,
    namaKantor: namaKantor,
    statusKantor: statusKantor,
    alamat: alamat,
    kelurahan: kelurahan,
    kecamatan: kecamatan,
    kota: kota,
    provinsi: provinsi,
    kodePos: kodePos,
    telp: telp,
    fax: fax
  );


  KantorModel copyWith({
    int? id,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk,
    String? namaKantor,
    String? statusKantor,
    String? alamat,
    String? kelurahan,
    String? kecamatan,
    String? kota,
    String? provinsi,
    String? kodePos,
    dynamic? telp,
    dynamic? fax
  }) => KantorModel(
    id: id ?? this.id,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
    namaKantor: namaKantor ?? this.namaKantor,
    statusKantor: statusKantor ?? this.statusKantor,
    alamat: alamat ?? this.alamat,
    kelurahan: kelurahan ?? this.kelurahan,
    kecamatan: kecamatan ?? this.kecamatan,
    kota: kota ?? this.kota,
    provinsi: provinsi ?? this.provinsi,
    kodePos: kodePos ?? this.kodePos,
    telp: telp ?? this.telp,
    fax: fax ?? this.fax,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is KantorModel && id == other.id && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && namaKantor == other.namaKantor && statusKantor == other.statusKantor && alamat == other.alamat && kelurahan == other.kelurahan && kecamatan == other.kecamatan && kota == other.kota && provinsi == other.provinsi && kodePos == other.kodePos && telp == other.telp && fax == other.fax;

  @override
  int get hashCode => id.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ namaKantor.hashCode ^ statusKantor.hashCode ^ alamat.hashCode ^ kelurahan.hashCode ^ kecamatan.hashCode ^ kota.hashCode ^ provinsi.hashCode ^ kodePos.hashCode ^ telp.hashCode ^ fax.hashCode;
}
