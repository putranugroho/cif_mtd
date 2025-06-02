import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class PembayaranHutangPiutangModel {

  const PembayaranHutangPiutangModel({
    required this.noInvoice,
    required this.jnsInvoice,
    required this.jumlahTahap,
    required this.ke,
    required this.nilaiTahap,
    required this.nilaiBayar,
    required this.tglJtTempo,
    required this.statusBayar,
  });

  final String noInvoice;
  final String jnsInvoice;
  final String jumlahTahap;
  final String ke;
  final String nilaiTahap;
  final String nilaiBayar;
  final String tglJtTempo;
  final String statusBayar;

  factory PembayaranHutangPiutangModel.fromJson(Map<String,dynamic> json) => PembayaranHutangPiutangModel(
    noInvoice: json['no_invoice'].toString(),
    jnsInvoice: json['jns_invoice'].toString(),
    jumlahTahap: json['jumlah_tahap'].toString(),
    ke: json['ke'].toString(),
    nilaiTahap: json['nilai_tahap'].toString(),
    nilaiBayar: json['nilai_bayar'].toString(),
    tglJtTempo: json['tgl_jt_tempo'].toString(),
    statusBayar: json['status_bayar'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'no_invoice': noInvoice,
    'jns_invoice': jnsInvoice,
    'jumlah_tahap': jumlahTahap,
    'ke': ke,
    'nilai_tahap': nilaiTahap,
    'nilai_bayar': nilaiBayar,
    'tgl_jt_tempo': tglJtTempo,
    'status_bayar': statusBayar
  };

  PembayaranHutangPiutangModel clone() => PembayaranHutangPiutangModel(
    noInvoice: noInvoice,
    jnsInvoice: jnsInvoice,
    jumlahTahap: jumlahTahap,
    ke: ke,
    nilaiTahap: nilaiTahap,
    nilaiBayar: nilaiBayar,
    tglJtTempo: tglJtTempo,
    statusBayar: statusBayar
  );


  PembayaranHutangPiutangModel copyWith({
    String? noInvoice,
    String? jnsInvoice,
    String? jumlahTahap,
    String? ke,
    String? nilaiTahap,
    String? nilaiBayar,
    String? tglJtTempo,
    String? statusBayar
  }) => PembayaranHutangPiutangModel(
    noInvoice: noInvoice ?? this.noInvoice,
    jnsInvoice: jnsInvoice ?? this.jnsInvoice,
    jumlahTahap: jumlahTahap ?? this.jumlahTahap,
    ke: ke ?? this.ke,
    nilaiTahap: nilaiTahap ?? this.nilaiTahap,
    nilaiBayar: nilaiBayar ?? this.nilaiBayar,
    tglJtTempo: tglJtTempo ?? this.tglJtTempo,
    statusBayar: statusBayar ?? this.statusBayar,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is PembayaranHutangPiutangModel && noInvoice == other.noInvoice && jnsInvoice == other.jnsInvoice && jumlahTahap == other.jumlahTahap && ke == other.ke && nilaiTahap == other.nilaiTahap && nilaiBayar == other.nilaiBayar && tglJtTempo == other.tglJtTempo && statusBayar == other.statusBayar;

  @override
  int get hashCode => noInvoice.hashCode ^ jnsInvoice.hashCode ^ jumlahTahap.hashCode ^ ke.hashCode ^ nilaiTahap.hashCode ^ nilaiBayar.hashCode ^ tglJtTempo.hashCode ^ statusBayar.hashCode;
}
