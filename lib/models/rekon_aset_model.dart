import 'package:flutter/foundation.dart';

import 'index.dart';

@immutable
class RekonAsetModel {
  const RekonAsetModel({
    required this.kodeKelompok,
    required this.namaKelompok,
    required this.item,
  });

  final String kodeKelompok;
  final String namaKelompok;
  final List<InventarisModel> item;

  factory RekonAsetModel.fromJson(Map<String, dynamic> json) => RekonAsetModel(kodeKelompok: json['kode_kelompok'].toString(), namaKelompok: json['nama_kelompok'].toString(), item: (json['item'] as List? ?? []).map((e) => InventarisModel.fromJson(e as Map<String, dynamic>)).toList());

  Map<String, dynamic> toJson() => {
        'kode_kelompok': kodeKelompok,
        'nama_kelompok': namaKelompok,
        'item': item.map((e) => e.toJson()).toList()
      };

  RekonAsetModel clone() => RekonAsetModel(kodeKelompok: kodeKelompok, namaKelompok: namaKelompok, item: item.map((e) => e.clone()).toList());

  RekonAsetModel copyWith({String? kodeKelompok, String? namaKelompok, List<InventarisModel>? item}) => RekonAsetModel(
        kodeKelompok: kodeKelompok ?? this.kodeKelompok,
        namaKelompok: namaKelompok ?? this.namaKelompok,
        item: item ?? this.item,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is RekonAsetModel && kodeKelompok == other.kodeKelompok && namaKelompok == other.namaKelompok && item == other.item;

  @override
  int get hashCode => kodeKelompok.hashCode ^ namaKelompok.hashCode ^ item.hashCode;
}
