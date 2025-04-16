import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class TransaksiBayarPendapatanDimukaModel {

  const TransaksiBayarPendapatanDimukaModel({
    required this.noTransaksi,
    required this.keterangan,
    required this.berapa,
    required this.tanggalTransaksi,
    required this.dimuka,
    required this.noReferensi,
    required this.nominal,
    required this.status,
  });

  final String noTransaksi;
  final String keterangan;
  final String berapa;
  final String tanggalTransaksi;
  final String dimuka;
  final String noReferensi;
  final String nominal;
  final String status;

  factory TransaksiBayarPendapatanDimukaModel.fromJson(Map<String,dynamic> json) => TransaksiBayarPendapatanDimukaModel(
    noTransaksi: json['no_transaksi'].toString(),
    keterangan: json['keterangan'].toString(),
    berapa: json['berapa'].toString(),
    tanggalTransaksi: json['tanggal_transaksi'].toString(),
    dimuka: json['dimuka'].toString(),
    noReferensi: json['no_referensi'].toString(),
    nominal: json['nominal'].toString(),
    status: json['status'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'no_transaksi': noTransaksi,
    'keterangan': keterangan,
    'berapa': berapa,
    'tanggal_transaksi': tanggalTransaksi,
    'dimuka': dimuka,
    'no_referensi': noReferensi,
    'nominal': nominal,
    'status': status
  };

  TransaksiBayarPendapatanDimukaModel clone() => TransaksiBayarPendapatanDimukaModel(
    noTransaksi: noTransaksi,
    keterangan: keterangan,
    berapa: berapa,
    tanggalTransaksi: tanggalTransaksi,
    dimuka: dimuka,
    noReferensi: noReferensi,
    nominal: nominal,
    status: status
  );


  TransaksiBayarPendapatanDimukaModel copyWith({
    String? noTransaksi,
    String? keterangan,
    String? berapa,
    String? tanggalTransaksi,
    String? dimuka,
    String? noReferensi,
    String? nominal,
    String? status
  }) => TransaksiBayarPendapatanDimukaModel(
    noTransaksi: noTransaksi ?? this.noTransaksi,
    keterangan: keterangan ?? this.keterangan,
    berapa: berapa ?? this.berapa,
    tanggalTransaksi: tanggalTransaksi ?? this.tanggalTransaksi,
    dimuka: dimuka ?? this.dimuka,
    noReferensi: noReferensi ?? this.noReferensi,
    nominal: nominal ?? this.nominal,
    status: status ?? this.status,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TransaksiBayarPendapatanDimukaModel && noTransaksi == other.noTransaksi && keterangan == other.keterangan && berapa == other.berapa && tanggalTransaksi == other.tanggalTransaksi && dimuka == other.dimuka && noReferensi == other.noReferensi && nominal == other.nominal && status == other.status;

  @override
  int get hashCode => noTransaksi.hashCode ^ keterangan.hashCode ^ berapa.hashCode ^ tanggalTransaksi.hashCode ^ dimuka.hashCode ^ noReferensi.hashCode ^ nominal.hashCode ^ status.hashCode;
}
