import 'package:flutter/foundation.dart';

@immutable
class AktivasiModel {
  const AktivasiModel({
    required this.id,
    required this.kdAktivasi,
    required this.nmAktivasi,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
    required this.createdDate,
  });

  final int id;
  final String kdAktivasi;
  final String nmAktivasi;
  final String hari;
  final String jamMulai;
  final String jamSelesai;
  final String createdDate;

  factory AktivasiModel.fromJson(Map<String, dynamic> json) => AktivasiModel(id: json['id'] as int, kdAktivasi: json['kd_aktivasi'].toString(), nmAktivasi: json['nm_aktivasi'].toString(), hari: json['hari'].toString(), jamMulai: json['jam_mulai'].toString(), jamSelesai: json['jam_selesai'].toString(), createdDate: json['createdDate'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'kd_aktivasi': kdAktivasi,
        'nm_aktivasi': nmAktivasi,
        'hari': hari,
        'jam_mulai': jamMulai,
        'jam_selesai': jamSelesai,
        'createdDate': createdDate
      };

  AktivasiModel clone() => AktivasiModel(id: id, kdAktivasi: kdAktivasi, nmAktivasi: nmAktivasi, hari: hari, jamMulai: jamMulai, jamSelesai: jamSelesai, createdDate: createdDate);

  AktivasiModel copyWith({int? id, String? kdAktivasi, String? nmAktivasi, String? hari, String? jamMulai, String? jamSelesai, String? createdDate}) => AktivasiModel(
        id: id ?? this.id,
        kdAktivasi: kdAktivasi ?? this.kdAktivasi,
        nmAktivasi: nmAktivasi ?? this.nmAktivasi,
        hari: hari ?? this.hari,
        jamMulai: jamMulai ?? this.jamMulai,
        jamSelesai: jamSelesai ?? this.jamSelesai,
        createdDate: createdDate ?? this.createdDate,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is AktivasiModel && id == other.id && kdAktivasi == other.kdAktivasi && nmAktivasi == other.nmAktivasi && hari == other.hari && jamMulai == other.jamMulai && jamSelesai == other.jamSelesai && createdDate == other.createdDate;

  @override
  int get hashCode => id.hashCode ^ kdAktivasi.hashCode ^ nmAktivasi.hashCode ^ hari.hashCode ^ jamMulai.hashCode ^ jamSelesai.hashCode ^ createdDate.hashCode;
}
