import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class SbbKhususItemModel {

  const SbbKhususItemModel({
    required this.id,
    required this.kodePt,
    required this.kodeGolongan,
    required this.nosbb,
    required this.namaSbb,
    required this.createddate,
    required this.isDeleted,
  });

  final int id;
  final String kodePt;
  final String kodeGolongan;
  final String nosbb;
  final String namaSbb;
  final String createddate;
  final String isDeleted;

  factory SbbKhususItemModel.fromJson(Map<String,dynamic> json) => SbbKhususItemModel(
    id: json['id'] as int,
    kodePt: json['kode_pt'].toString(),
    kodeGolongan: json['kode_golongan'].toString(),
    nosbb: json['nosbb'].toString(),
    namaSbb: json['nama_sbb'].toString(),
    createddate: json['createddate'].toString(),
    isDeleted: json['is_deleted'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kode_pt': kodePt,
    'kode_golongan': kodeGolongan,
    'nosbb': nosbb,
    'nama_sbb': namaSbb,
    'createddate': createddate,
    'is_deleted': isDeleted
  };

  SbbKhususItemModel clone() => SbbKhususItemModel(
    id: id,
    kodePt: kodePt,
    kodeGolongan: kodeGolongan,
    nosbb: nosbb,
    namaSbb: namaSbb,
    createddate: createddate,
    isDeleted: isDeleted
  );


  SbbKhususItemModel copyWith({
    int? id,
    String? kodePt,
    String? kodeGolongan,
    String? nosbb,
    String? namaSbb,
    String? createddate,
    String? isDeleted
  }) => SbbKhususItemModel(
    id: id ?? this.id,
    kodePt: kodePt ?? this.kodePt,
    kodeGolongan: kodeGolongan ?? this.kodeGolongan,
    nosbb: nosbb ?? this.nosbb,
    namaSbb: namaSbb ?? this.namaSbb,
    createddate: createddate ?? this.createddate,
    isDeleted: isDeleted ?? this.isDeleted,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SbbKhususItemModel && id == other.id && kodePt == other.kodePt && kodeGolongan == other.kodeGolongan && nosbb == other.nosbb && namaSbb == other.namaSbb && createddate == other.createddate && isDeleted == other.isDeleted;

  @override
  int get hashCode => id.hashCode ^ kodePt.hashCode ^ kodeGolongan.hashCode ^ nosbb.hashCode ^ namaSbb.hashCode ^ createddate.hashCode ^ isDeleted.hashCode;
}
