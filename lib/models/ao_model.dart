import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class AoModel {

  const AoModel({
    required this.id,
    required this.kode,
    required this.nama,
    required this.golCust,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
  });

  final int id;
  final String kode;
  final String nama;
  final String golCust;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;

  factory AoModel.fromJson(Map<String,dynamic> json) => AoModel(
    id: json['id'] as int,
    kode: json['kode'].toString(),
    nama: json['nama'].toString(),
    golCust: json['gol_cust'].toString(),
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kode': kode,
    'nama': nama,
    'gol_cust': golCust,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk
  };

  AoModel clone() => AoModel(
    id: id,
    kode: kode,
    nama: nama,
    golCust: golCust,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk
  );


  AoModel copyWith({
    int? id,
    String? kode,
    String? nama,
    String? golCust,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk
  }) => AoModel(
    id: id ?? this.id,
    kode: kode ?? this.kode,
    nama: nama ?? this.nama,
    golCust: golCust ?? this.golCust,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is AoModel && id == other.id && kode == other.kode && nama == other.nama && golCust == other.golCust && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk;

  @override
  int get hashCode => id.hashCode ^ kode.hashCode ^ nama.hashCode ^ golCust.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode;
}
