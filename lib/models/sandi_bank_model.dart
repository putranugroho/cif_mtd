import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class SandiBankModel {

  const SandiBankModel({
    required this.id,
    required this.namaLjk,
    required this.jenis,
    required this.kategori,
    required this.sandi,
  });

  final int id;
  final String namaLjk;
  final String jenis;
  final String kategori;
  final String sandi;

  factory SandiBankModel.fromJson(Map<String,dynamic> json) => SandiBankModel(
    id: json['id'] as int,
    namaLjk: json['nama_ljk'].toString(),
    jenis: json['jenis'].toString(),
    kategori: json['kategori'].toString(),
    sandi: json['sandi'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_ljk': namaLjk,
    'jenis': jenis,
    'kategori': kategori,
    'sandi': sandi
  };

  SandiBankModel clone() => SandiBankModel(
    id: id,
    namaLjk: namaLjk,
    jenis: jenis,
    kategori: kategori,
    sandi: sandi
  );


  SandiBankModel copyWith({
    int? id,
    String? namaLjk,
    String? jenis,
    String? kategori,
    String? sandi
  }) => SandiBankModel(
    id: id ?? this.id,
    namaLjk: namaLjk ?? this.namaLjk,
    jenis: jenis ?? this.jenis,
    kategori: kategori ?? this.kategori,
    sandi: sandi ?? this.sandi,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SandiBankModel && id == other.id && namaLjk == other.namaLjk && jenis == other.jenis && kategori == other.kategori && sandi == other.sandi;

  @override
  int get hashCode => id.hashCode ^ namaLjk.hashCode ^ jenis.hashCode ^ kategori.hashCode ^ sandi.hashCode;
}
