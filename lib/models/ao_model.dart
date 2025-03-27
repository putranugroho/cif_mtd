import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class AoModel {

  const AoModel({
    required this.kdAo,
    required this.nmAo,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
  });

  final String kdAo;
  final String nmAo;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;

  factory AoModel.fromJson(Map<String,dynamic> json) => AoModel(
    kdAo: json['kd_ao'].toString(),
    nmAo: json['nm_ao'].toString(),
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'kd_ao': kdAo,
    'nm_ao': nmAo,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk
  };

  AoModel clone() => AoModel(
    kdAo: kdAo,
    nmAo: nmAo,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk
  );


  AoModel copyWith({
    String? kdAo,
    String? nmAo,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk
  }) => AoModel(
    kdAo: kdAo ?? this.kdAo,
    nmAo: nmAo ?? this.nmAo,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is AoModel && kdAo == other.kdAo && nmAo == other.nmAo && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk;

  @override
  int get hashCode => kdAo.hashCode ^ nmAo.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode;
}
