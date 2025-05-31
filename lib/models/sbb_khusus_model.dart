import 'package:flutter/foundation.dart';

import 'index.dart';

@immutable
class SbbKhususModel {
  const SbbKhususModel({
    required this.kodeGolongan,
    required this.namaGolongan,
    required this.items,
  });

  final String kodeGolongan;
  final String namaGolongan;
  final List<SbbKhususItemModel> items;

  factory SbbKhususModel.fromJson(Map<String, dynamic> json) => SbbKhususModel(kodeGolongan: json['kode_golongan'].toString(), namaGolongan: json['nama_golongan'].toString(), items: (json['items'] as List? ?? []).map((e) => SbbKhususItemModel.fromJson(e as Map<String, dynamic>)).toList());

  Map<String, dynamic> toJson() => {
        'kode_golongan': kodeGolongan,
        'nama_golongan': namaGolongan,
        'items': items.map((e) => e.toJson()).toList()
      };

  SbbKhususModel clone() => SbbKhususModel(kodeGolongan: kodeGolongan, namaGolongan: namaGolongan, items: items.map((e) => e.clone()).toList());

  SbbKhususModel copyWith({String? kodeGolongan, String? namaGolongan, List<SbbKhususItemModel>? items}) => SbbKhususModel(
        kodeGolongan: kodeGolongan ?? this.kodeGolongan,
        namaGolongan: namaGolongan ?? this.namaGolongan,
        items: items ?? this.items,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is SbbKhususModel && kodeGolongan == other.kodeGolongan && namaGolongan == other.namaGolongan && items == other.items;

  @override
  int get hashCode => kodeGolongan.hashCode ^ namaGolongan.hashCode ^ items.hashCode;
}
