import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class PiutangHutangModel {

  const PiutangHutangModel({
    required this.id,
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
    required this.noSbb,
    required this.namaSbb,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.keterangan,
    required this.kodeAo,
    required this.itemPembayaran,
  });

  final int id;
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
  final String noSbb;
  final String namaSbb;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;
  final String keterangan;
  final String kodeAo;
  final List<PembayaranHutangPiutangModel> itemPembayaran;

  factory PiutangHutangModel.fromJson(Map<String,dynamic> json) => PiutangHutangModel(
    id: json['id'] as int,
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
    noSbb: json['no_sbb'].toString(),
    namaSbb: json['nama_sbb'].toString(),
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString(),
    keterangan: json['keterangan'].toString(),
    kodeAo: json['kode_ao'].toString(),
    itemPembayaran: (json['item_pembayaran'] as List? ?? []).map((e) => PembayaranHutangPiutangModel.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
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
    'no_sbb': noSbb,
    'nama_sbb': namaSbb,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk,
    'keterangan': keterangan,
    'kode_ao': kodeAo,
    'item_pembayaran': itemPembayaran.map((e) => e.toJson()).toList()
  };

  PiutangHutangModel clone() => PiutangHutangModel(
    id: id,
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
    noSbb: noSbb,
    namaSbb: namaSbb,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk,
    keterangan: keterangan,
    kodeAo: kodeAo,
    itemPembayaran: itemPembayaran.map((e) => e.clone()).toList()
  );


  PiutangHutangModel copyWith({
    int? id,
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
    String? noSbb,
    String? namaSbb,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk,
    String? keterangan,
    String? kodeAo,
    List<PembayaranHutangPiutangModel>? itemPembayaran
  }) => PiutangHutangModel(
    id: id ?? this.id,
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
    noSbb: noSbb ?? this.noSbb,
    namaSbb: namaSbb ?? this.namaSbb,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
    keterangan: keterangan ?? this.keterangan,
    kodeAo: kodeAo ?? this.kodeAo,
    itemPembayaran: itemPembayaran ?? this.itemPembayaran,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is PiutangHutangModel && id == other.id && noInvoice == other.noInvoice && jnsInvoice == other.jnsInvoice && noSif == other.noSif && nmSif == other.nmSif && tglInvoice == other.tglInvoice && nilaiInvoice == other.nilaiInvoice && ppn == other.ppn && pph == other.pph && tglJtTempo == other.tglJtTempo && bertahap == other.bertahap && jumlahTahap == other.jumlahTahap && tglBayar == other.tglBayar && nilaiBayar == other.nilaiBayar && statusInvoice == other.statusInvoice && noSbb == other.noSbb && namaSbb == other.namaSbb && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && keterangan == other.keterangan && kodeAo == other.kodeAo && itemPembayaran == other.itemPembayaran;

  @override
  int get hashCode => id.hashCode ^ noInvoice.hashCode ^ jnsInvoice.hashCode ^ noSif.hashCode ^ nmSif.hashCode ^ tglInvoice.hashCode ^ nilaiInvoice.hashCode ^ ppn.hashCode ^ pph.hashCode ^ tglJtTempo.hashCode ^ bertahap.hashCode ^ jumlahTahap.hashCode ^ tglBayar.hashCode ^ nilaiBayar.hashCode ^ statusInvoice.hashCode ^ noSbb.hashCode ^ namaSbb.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ keterangan.hashCode ^ kodeAo.hashCode ^ itemPembayaran.hashCode;
}
