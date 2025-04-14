import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class RekonsiliasiPiutangHutangModel {

  const RekonsiliasiPiutangHutangModel({
    required this.noInvoice,
    required this.jnsInvoice,
    required this.noSif,
    required this.nmSif,
    required this.tglInvoice,
    required this.nilaiInvoice,
    required this.ppn,
    required this.pph,
    required this.tglJtTempo,
    required this.bertahap,
    required this.jumlahTahap,
    required this.tglBayar,
    required this.nilaiBayar,
    required this.statusInvoice,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.kodeAo,
    required this.noReferensi,
    required this.saldo,
  });

  final String noInvoice;
  final String jnsInvoice;
  final String noSif;
  final String nmSif;
  final String tglInvoice;
  final String nilaiInvoice;
  final String ppn;
  final String pph;
  final String tglJtTempo;
  final String bertahap;
  final String jumlahTahap;
  final String tglBayar;
  final String nilaiBayar;
  final String statusInvoice;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;
  final String kodeAo;
  final String noReferensi;
  final String saldo;

  factory RekonsiliasiPiutangHutangModel.fromJson(Map<String,dynamic> json) => RekonsiliasiPiutangHutangModel(
    noInvoice: json['no_invoice'].toString(),
    jnsInvoice: json['jns_invoice'].toString(),
    noSif: json['no_sif'].toString(),
    nmSif: json['nm_sif'].toString(),
    tglInvoice: json['tgl_invoice'].toString(),
    nilaiInvoice: json['nilai_invoice'].toString(),
    ppn: json['ppn'].toString(),
    pph: json['pph'].toString(),
    tglJtTempo: json['tgl_jt_tempo'].toString(),
    bertahap: json['bertahap'].toString(),
    jumlahTahap: json['jumlah_tahap'].toString(),
    tglBayar: json['tgl_bayar'].toString(),
    nilaiBayar: json['nilai_bayar'].toString(),
    statusInvoice: json['status_invoice'].toString(),
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString(),
    kodeAo: json['kode_ao'].toString(),
    noReferensi: json['no_referensi'].toString(),
    saldo: json['saldo'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'no_invoice': noInvoice,
    'jns_invoice': jnsInvoice,
    'no_sif': noSif,
    'nm_sif': nmSif,
    'tgl_invoice': tglInvoice,
    'nilai_invoice': nilaiInvoice,
    'ppn': ppn,
    'pph': pph,
    'tgl_jt_tempo': tglJtTempo,
    'bertahap': bertahap,
    'jumlah_tahap': jumlahTahap,
    'tgl_bayar': tglBayar,
    'nilai_bayar': nilaiBayar,
    'status_invoice': statusInvoice,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk,
    'kode_ao': kodeAo,
    'no_referensi': noReferensi,
    'saldo': saldo
  };

  RekonsiliasiPiutangHutangModel clone() => RekonsiliasiPiutangHutangModel(
    noInvoice: noInvoice,
    jnsInvoice: jnsInvoice,
    noSif: noSif,
    nmSif: nmSif,
    tglInvoice: tglInvoice,
    nilaiInvoice: nilaiInvoice,
    ppn: ppn,
    pph: pph,
    tglJtTempo: tglJtTempo,
    bertahap: bertahap,
    jumlahTahap: jumlahTahap,
    tglBayar: tglBayar,
    nilaiBayar: nilaiBayar,
    statusInvoice: statusInvoice,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk,
    kodeAo: kodeAo,
    noReferensi: noReferensi,
    saldo: saldo
  );


  RekonsiliasiPiutangHutangModel copyWith({
    String? noInvoice,
    String? jnsInvoice,
    String? noSif,
    String? nmSif,
    String? tglInvoice,
    String? nilaiInvoice,
    String? ppn,
    String? pph,
    String? tglJtTempo,
    String? bertahap,
    String? jumlahTahap,
    String? tglBayar,
    String? nilaiBayar,
    String? statusInvoice,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk,
    String? kodeAo,
    String? noReferensi,
    String? saldo
  }) => RekonsiliasiPiutangHutangModel(
    noInvoice: noInvoice ?? this.noInvoice,
    jnsInvoice: jnsInvoice ?? this.jnsInvoice,
    noSif: noSif ?? this.noSif,
    nmSif: nmSif ?? this.nmSif,
    tglInvoice: tglInvoice ?? this.tglInvoice,
    nilaiInvoice: nilaiInvoice ?? this.nilaiInvoice,
    ppn: ppn ?? this.ppn,
    pph: pph ?? this.pph,
    tglJtTempo: tglJtTempo ?? this.tglJtTempo,
    bertahap: bertahap ?? this.bertahap,
    jumlahTahap: jumlahTahap ?? this.jumlahTahap,
    tglBayar: tglBayar ?? this.tglBayar,
    nilaiBayar: nilaiBayar ?? this.nilaiBayar,
    statusInvoice: statusInvoice ?? this.statusInvoice,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
    kodeAo: kodeAo ?? this.kodeAo,
    noReferensi: noReferensi ?? this.noReferensi,
    saldo: saldo ?? this.saldo,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is RekonsiliasiPiutangHutangModel && noInvoice == other.noInvoice && jnsInvoice == other.jnsInvoice && noSif == other.noSif && nmSif == other.nmSif && tglInvoice == other.tglInvoice && nilaiInvoice == other.nilaiInvoice && ppn == other.ppn && pph == other.pph && tglJtTempo == other.tglJtTempo && bertahap == other.bertahap && jumlahTahap == other.jumlahTahap && tglBayar == other.tglBayar && nilaiBayar == other.nilaiBayar && statusInvoice == other.statusInvoice && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && kodeAo == other.kodeAo && noReferensi == other.noReferensi && saldo == other.saldo;

  @override
  int get hashCode => noInvoice.hashCode ^ jnsInvoice.hashCode ^ noSif.hashCode ^ nmSif.hashCode ^ tglInvoice.hashCode ^ nilaiInvoice.hashCode ^ ppn.hashCode ^ pph.hashCode ^ tglJtTempo.hashCode ^ bertahap.hashCode ^ jumlahTahap.hashCode ^ tglBayar.hashCode ^ nilaiBayar.hashCode ^ statusInvoice.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ kodeAo.hashCode ^ noReferensi.hashCode ^ saldo.hashCode;
}
