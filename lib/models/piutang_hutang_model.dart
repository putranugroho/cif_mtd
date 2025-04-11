import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class PiutangHutangModel {

  const PiutangHutangModel({
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

  factory PiutangHutangModel.fromJson(Map<String,dynamic> json) => PiutangHutangModel(
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
    kodeAo: json['kode_ao'].toString()
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
    'kode_ao': kodeAo
  };

  PiutangHutangModel clone() => PiutangHutangModel(
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
    kodeAo: kodeAo
  );


  PiutangHutangModel copyWith({
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
    String? kodeAo
  }) => PiutangHutangModel(
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
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is PiutangHutangModel && noInvoice == other.noInvoice && jnsInvoice == other.jnsInvoice && noSif == other.noSif && nmSif == other.nmSif && tglInvoice == other.tglInvoice && nilaiInvoice == other.nilaiInvoice && ppn == other.ppn && pph == other.pph && tglJtTempo == other.tglJtTempo && bertahap == other.bertahap && jumlahTahap == other.jumlahTahap && tglBayar == other.tglBayar && nilaiBayar == other.nilaiBayar && statusInvoice == other.statusInvoice && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && kodeAo == other.kodeAo;

  @override
  int get hashCode => noInvoice.hashCode ^ jnsInvoice.hashCode ^ noSif.hashCode ^ nmSif.hashCode ^ tglInvoice.hashCode ^ nilaiInvoice.hashCode ^ ppn.hashCode ^ pph.hashCode ^ tglJtTempo.hashCode ^ bertahap.hashCode ^ jumlahTahap.hashCode ^ tglBayar.hashCode ^ nilaiBayar.hashCode ^ statusInvoice.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ kodeAo.hashCode;
}
