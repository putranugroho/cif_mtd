import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class GolonganBarang {
  final int id;
  final String kode;
  final String nama;
  final String deskripsi;
  final String status;

  GolonganBarang({
    required this.id,
    required this.kode,
    required this.nama,
    required this.deskripsi,
    required this.status,
  });

  factory GolonganBarang.fromJson(Map<String, dynamic> json) {
    return GolonganBarang(
      id: json['id'],
      kode: json['kode'] ?? '',
      nama: json['nama'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
