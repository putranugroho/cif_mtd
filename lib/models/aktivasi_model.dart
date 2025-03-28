import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class AktivasiModel {

  const AktivasiModel({
    required this.kdAktivasi,
    required this.nmAktivasi,
    required this.hari,
    required this.jamMulai,
    required this.jamSelesai,
  });

  final String kdAktivasi;
  final String nmAktivasi;
  final String hari;
  final String jamMulai;
  final String jamSelesai;

  factory AktivasiModel.fromJson(Map<String,dynamic> json) => AktivasiModel(
    kdAktivasi: json['kd_aktivasi'].toString(),
    nmAktivasi: json['nm_aktivasi'].toString(),
    hari: json['hari'].toString(),
    jamMulai: json['jam_mulai'].toString(),
    jamSelesai: json['jam_selesai'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'kd_aktivasi': kdAktivasi,
    'nm_aktivasi': nmAktivasi,
    'hari': hari,
    'jam_mulai': jamMulai,
    'jam_selesai': jamSelesai
  };

  AktivasiModel clone() => AktivasiModel(
    kdAktivasi: kdAktivasi,
    nmAktivasi: nmAktivasi,
    hari: hari,
    jamMulai: jamMulai,
    jamSelesai: jamSelesai
  );


  AktivasiModel copyWith({
    String? kdAktivasi,
    String? nmAktivasi,
    String? hari,
    String? jamMulai,
    String? jamSelesai
  }) => AktivasiModel(
    kdAktivasi: kdAktivasi ?? this.kdAktivasi,
    nmAktivasi: nmAktivasi ?? this.nmAktivasi,
    hari: hari ?? this.hari,
    jamMulai: jamMulai ?? this.jamMulai,
    jamSelesai: jamSelesai ?? this.jamSelesai,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is AktivasiModel && kdAktivasi == other.kdAktivasi && nmAktivasi == other.nmAktivasi && hari == other.hari && jamMulai == other.jamMulai && jamSelesai == other.jamSelesai;

  @override
  int get hashCode => kdAktivasi.hashCode ^ nmAktivasi.hashCode ^ hari.hashCode ^ jamMulai.hashCode ^ jamSelesai.hashCode;
}
