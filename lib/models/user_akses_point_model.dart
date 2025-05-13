import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class UserAksesPointModel {

  const UserAksesPointModel({
    required this.id,
    required this.keterangan,
    required this.lokasi,
    required this.noAkses,
    required this.aksesId,
    required this.type,
    required this.kodeKantor,
    required this.namaKantor,
  });

  final int id;
  final String keterangan;
  final String lokasi;
  final String noAkses;
  final String aksesId;
  final String type;
  final String kodeKantor;
  final String namaKantor;

  factory UserAksesPointModel.fromJson(Map<String,dynamic> json) => UserAksesPointModel(
    id: json['id'] as int,
    keterangan: json['keterangan'].toString(),
    lokasi: json['lokasi'].toString(),
    noAkses: json['no_akses'].toString(),
    aksesId: json['akses_id'].toString(),
    type: json['type'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    namaKantor: json['nama_kantor'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'keterangan': keterangan,
    'lokasi': lokasi,
    'no_akses': noAkses,
    'akses_id': aksesId,
    'type': type,
    'kode_kantor': kodeKantor,
    'nama_kantor': namaKantor
  };

  UserAksesPointModel clone() => UserAksesPointModel(
    id: id,
    keterangan: keterangan,
    lokasi: lokasi,
    noAkses: noAkses,
    aksesId: aksesId,
    type: type,
    kodeKantor: kodeKantor,
    namaKantor: namaKantor
  );


  UserAksesPointModel copyWith({
    int? id,
    String? keterangan,
    String? lokasi,
    String? noAkses,
    String? aksesId,
    String? type,
    String? kodeKantor,
    String? namaKantor
  }) => UserAksesPointModel(
    id: id ?? this.id,
    keterangan: keterangan ?? this.keterangan,
    lokasi: lokasi ?? this.lokasi,
    noAkses: noAkses ?? this.noAkses,
    aksesId: aksesId ?? this.aksesId,
    type: type ?? this.type,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    namaKantor: namaKantor ?? this.namaKantor,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is UserAksesPointModel && id == other.id && keterangan == other.keterangan && lokasi == other.lokasi && noAkses == other.noAkses && aksesId == other.aksesId && type == other.type && kodeKantor == other.kodeKantor && namaKantor == other.namaKantor;

  @override
  int get hashCode => id.hashCode ^ keterangan.hashCode ^ lokasi.hashCode ^ noAkses.hashCode ^ aksesId.hashCode ^ type.hashCode ^ kodeKantor.hashCode ^ namaKantor.hashCode;
}
