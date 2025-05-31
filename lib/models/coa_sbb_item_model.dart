import 'package:flutter/foundation.dart';

@immutable
class CoaSbbItemModel {
  const CoaSbbItemModel({
    required this.nosbb,
    required this.nama,
    required this.keterangan,
  });

  final String nosbb;
  final String nama;
  final String keterangan;

  factory CoaSbbItemModel.fromJson(Map<String, dynamic> json) => CoaSbbItemModel(nosbb: json['nosbb'].toString(), nama: json['nama'].toString(), keterangan: json['keterangan'].toString());

  Map<String, dynamic> toJson() => {
        'nosbb': nosbb,
        'nama': nama,
        'keterangan': keterangan
      };

  CoaSbbItemModel clone() => CoaSbbItemModel(nosbb: nosbb, nama: nama, keterangan: keterangan);

  CoaSbbItemModel copyWith({String? nosbb, String? nama, String? keterangan}) => CoaSbbItemModel(
        nosbb: nosbb ?? this.nosbb,
        nama: nama ?? this.nama,
        keterangan: keterangan ?? this.keterangan,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is CoaSbbItemModel && nosbb == other.nosbb && nama == other.nama && keterangan == other.keterangan;

  @override
  int get hashCode => nosbb.hashCode ^ nama.hashCode ^ keterangan.hashCode;
}
