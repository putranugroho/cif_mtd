import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class AksesPointModel {

  const AksesPointModel({
    required this.id,
    required this.noAkses,
    required this.aksesId,
    required this.type,
    required this.lokasi,
    required this.alamat,
    required this.keterangan,
    required this.kodePt,
    required this.createddate,
    required this.isDeleted,
  });

  final int id;
  final String noAkses;
  final String aksesId;
  final String type;
  final String lokasi;
  final String alamat;
  final String keterangan;
  final String kodePt;
  final String createddate;
  final String isDeleted;

  factory AksesPointModel.fromJson(Map<String,dynamic> json) => AksesPointModel(
    id: json['id'] as int,
    noAkses: json['no_akses'].toString(),
    aksesId: json['akses_id'].toString(),
    type: json['type'].toString(),
    lokasi: json['lokasi'].toString(),
    alamat: json['alamat'].toString(),
    keterangan: json['keterangan'].toString(),
    kodePt: json['kode_pt'].toString(),
    createddate: json['createddate'].toString(),
    isDeleted: json['is_deleted'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'no_akses': noAkses,
    'akses_id': aksesId,
    'type': type,
    'lokasi': lokasi,
    'alamat': alamat,
    'keterangan': keterangan,
    'kode_pt': kodePt,
    'createddate': createddate,
    'is_deleted': isDeleted
  };

  AksesPointModel clone() => AksesPointModel(
    id: id,
    noAkses: noAkses,
    aksesId: aksesId,
    type: type,
    lokasi: lokasi,
    alamat: alamat,
    keterangan: keterangan,
    kodePt: kodePt,
    createddate: createddate,
    isDeleted: isDeleted
  );


  AksesPointModel copyWith({
    int? id,
    String? noAkses,
    String? aksesId,
    String? type,
    String? lokasi,
    String? alamat,
    String? keterangan,
    String? kodePt,
    String? createddate,
    String? isDeleted
  }) => AksesPointModel(
    id: id ?? this.id,
    noAkses: noAkses ?? this.noAkses,
    aksesId: aksesId ?? this.aksesId,
    type: type ?? this.type,
    lokasi: lokasi ?? this.lokasi,
    alamat: alamat ?? this.alamat,
    keterangan: keterangan ?? this.keterangan,
    kodePt: kodePt ?? this.kodePt,
    createddate: createddate ?? this.createddate,
    isDeleted: isDeleted ?? this.isDeleted,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is AksesPointModel && id == other.id && noAkses == other.noAkses && aksesId == other.aksesId && type == other.type && lokasi == other.lokasi && alamat == other.alamat && keterangan == other.keterangan && kodePt == other.kodePt && createddate == other.createddate && isDeleted == other.isDeleted;

  @override
  int get hashCode => id.hashCode ^ noAkses.hashCode ^ aksesId.hashCode ^ type.hashCode ^ lokasi.hashCode ^ alamat.hashCode ^ keterangan.hashCode ^ kodePt.hashCode ^ createddate.hashCode ^ isDeleted.hashCode;
}
