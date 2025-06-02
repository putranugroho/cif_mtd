import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class CoaSbbModel {

  const CoaSbbModel({
    required this.golAcc,
    required this.jnsAcc,
    required this.nobb,
    required this.nosbb,
    required this.namaSbb,
    required this.typePosting,
    required this.sbbKhusus,
  });

  final String golAcc;
  final String jnsAcc;
  final String nobb;
  final String nosbb;
  final String namaSbb;
  final String typePosting;
  final List<CoaSbbItemModel> sbbKhusus;

  factory CoaSbbModel.fromJson(Map<String,dynamic> json) => CoaSbbModel(
    golAcc: json['gol_acc'].toString(),
    jnsAcc: json['jns_acc'].toString(),
    nobb: json['nobb'].toString(),
    nosbb: json['nosbb'].toString(),
    namaSbb: json['nama_sbb'].toString(),
    typePosting: json['type_posting'].toString(),
    sbbKhusus: (json['sbb_khusus'] as List? ?? []).map((e) => CoaSbbItemModel.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'gol_acc': golAcc,
    'jns_acc': jnsAcc,
    'nobb': nobb,
    'nosbb': nosbb,
    'nama_sbb': namaSbb,
    'type_posting': typePosting,
    'sbb_khusus': sbbKhusus.map((e) => e.toJson()).toList()
  };

  CoaSbbModel clone() => CoaSbbModel(
    golAcc: golAcc,
    jnsAcc: jnsAcc,
    nobb: nobb,
    nosbb: nosbb,
    namaSbb: namaSbb,
    typePosting: typePosting,
    sbbKhusus: sbbKhusus.map((e) => e.clone()).toList()
  );


  CoaSbbModel copyWith({
    String? golAcc,
    String? jnsAcc,
    String? nobb,
    String? nosbb,
    String? namaSbb,
    String? typePosting,
    List<CoaSbbItemModel>? sbbKhusus
  }) => CoaSbbModel(
    golAcc: golAcc ?? this.golAcc,
    jnsAcc: jnsAcc ?? this.jnsAcc,
    nobb: nobb ?? this.nobb,
    nosbb: nosbb ?? this.nosbb,
    namaSbb: namaSbb ?? this.namaSbb,
    typePosting: typePosting ?? this.typePosting,
    sbbKhusus: sbbKhusus ?? this.sbbKhusus,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is CoaSbbModel && golAcc == other.golAcc && jnsAcc == other.jnsAcc && nobb == other.nobb && nosbb == other.nosbb && namaSbb == other.namaSbb && typePosting == other.typePosting && sbbKhusus == other.sbbKhusus;

  @override
  int get hashCode => golAcc.hashCode ^ jnsAcc.hashCode ^ nobb.hashCode ^ nosbb.hashCode ^ namaSbb.hashCode ^ typePosting.hashCode ^ sbbKhusus.hashCode;
}
