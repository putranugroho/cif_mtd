import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class InventarisModel {

  const InventarisModel({
    required this.id,
    required this.kdaset,
    required this.ket,
    required this.kodeKelompok,
    required this.namaKelompok,
    required this.kodeGolongan,
    required this.namaGolongan,
    required this.nodokBeli,
    required this.tglBeli,
    required this.tglTerima,
    required this.habeli,
    required this.disc,
    required this.biaya,
    required this.haper,
    required this.nilaiResidu,
    required this.ppnBeli,
    required this.pph,
    required this.tglJual,
    required this.nodokJual,
    required this.hajual,
    required this.ppnJual,
    required this.margin,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.lokasi,
    required this.kota,
    required this.masasusut,
    required this.blnMulaiSusut,
    required this.kdkondisi,
    required this.kondisi,
    required this.satuanAset,
    required this.nilaiDeclining,
    required this.perbaikan,
    required this.stsasr,
    required this.nopolis,
    required this.nilaiRevaluasi,
    required this.nik,
    required this.namaPejabat,
    required this.sbbAset,
    required this.sbbPenyusutan,
    required this.sbbBiayaPenyusutan,
    required this.sbbRugiRevaluasi,
    required this.sbbLabaRevaluasi,
    required this.sbbRugiJual,
    required this.sbbLabaJual,
    required this.sbbBiayaPerbaikan,
  });

  final int id;
  final String kdaset;
  final String ket;
  final String kodeKelompok;
  final String namaKelompok;
  final String kodeGolongan;
  final String namaGolongan;
  final String nodokBeli;
  final String tglBeli;
  final String tglTerima;
  final String habeli;
  final String disc;
  final String biaya;
  final String haper;
  final String nilaiResidu;
  final String ppnBeli;
  final String pph;
  final String tglJual;
  final String nodokJual;
  final String hajual;
  final String ppnJual;
  final String margin;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;
  final String lokasi;
  final String kota;
  final String masasusut;
  final String blnMulaiSusut;
  final String kdkondisi;
  final String kondisi;
  final String satuanAset;
  final String nilaiDeclining;
  final String perbaikan;
  final String stsasr;
  final String nopolis;
  final String nilaiRevaluasi;
  final String nik;
  final String namaPejabat;
  final String sbbAset;
  final String sbbPenyusutan;
  final String sbbBiayaPenyusutan;
  final String sbbRugiRevaluasi;
  final String sbbLabaRevaluasi;
  final String sbbRugiJual;
  final String sbbLabaJual;
  final String sbbBiayaPerbaikan;

  factory InventarisModel.fromJson(Map<String,dynamic> json) => InventarisModel(
    id: json['id'] as int,
    kdaset: json['kdaset'].toString(),
    ket: json['ket'].toString(),
    kodeKelompok: json['kode_kelompok'].toString(),
    namaKelompok: json['nama_kelompok'].toString(),
    kodeGolongan: json['kode_golongan'].toString(),
    namaGolongan: json['nama_golongan'].toString(),
    nodokBeli: json['nodok_beli'].toString(),
    tglBeli: json['tgl_beli'].toString(),
    tglTerima: json['tgl_terima'].toString(),
    habeli: json['habeli'].toString(),
    disc: json['disc'].toString(),
    biaya: json['biaya'].toString(),
    haper: json['haper'].toString(),
    nilaiResidu: json['nilai_residu'].toString(),
    ppnBeli: json['ppn_beli'].toString(),
    pph: json['pph'].toString(),
    tglJual: json['tgl_jual'].toString(),
    nodokJual: json['nodok_jual'].toString(),
    hajual: json['hajual'].toString(),
    ppnJual: json['ppn_jual'].toString(),
    margin: json['margin'].toString(),
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString(),
    lokasi: json['lokasi'].toString(),
    kota: json['kota'].toString(),
    masasusut: json['masasusut'].toString(),
    blnMulaiSusut: json['bln_mulai_susut'].toString(),
    kdkondisi: json['kdkondisi'].toString(),
    kondisi: json['kondisi'].toString(),
    satuanAset: json['satuan_aset'].toString(),
    nilaiDeclining: json['nilai_declining'].toString(),
    perbaikan: json['perbaikan'].toString(),
    stsasr: json['stsasr'].toString(),
    nopolis: json['nopolis'].toString(),
    nilaiRevaluasi: json['nilai_revaluasi'].toString(),
    nik: json['nik'].toString(),
    namaPejabat: json['nama_pejabat'].toString(),
    sbbAset: json['sbb_aset'].toString(),
    sbbPenyusutan: json['sbb_penyusutan'].toString(),
    sbbBiayaPenyusutan: json['sbb_biaya_penyusutan'].toString(),
    sbbRugiRevaluasi: json['sbb_rugi_revaluasi'].toString(),
    sbbLabaRevaluasi: json['sbb_laba_revaluasi'].toString(),
    sbbRugiJual: json['sbb_rugi_jual'].toString(),
    sbbLabaJual: json['sbb_laba_jual'].toString(),
    sbbBiayaPerbaikan: json['sbb_biaya_perbaikan'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kdaset': kdaset,
    'ket': ket,
    'kode_kelompok': kodeKelompok,
    'nama_kelompok': namaKelompok,
    'kode_golongan': kodeGolongan,
    'nama_golongan': namaGolongan,
    'nodok_beli': nodokBeli,
    'tgl_beli': tglBeli,
    'tgl_terima': tglTerima,
    'habeli': habeli,
    'disc': disc,
    'biaya': biaya,
    'haper': haper,
    'nilai_residu': nilaiResidu,
    'ppn_beli': ppnBeli,
    'pph': pph,
    'tgl_jual': tglJual,
    'nodok_jual': nodokJual,
    'hajual': hajual,
    'ppn_jual': ppnJual,
    'margin': margin,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk,
    'lokasi': lokasi,
    'kota': kota,
    'masasusut': masasusut,
    'bln_mulai_susut': blnMulaiSusut,
    'kdkondisi': kdkondisi,
    'kondisi': kondisi,
    'satuan_aset': satuanAset,
    'nilai_declining': nilaiDeclining,
    'perbaikan': perbaikan,
    'stsasr': stsasr,
    'nopolis': nopolis,
    'nilai_revaluasi': nilaiRevaluasi,
    'nik': nik,
    'nama_pejabat': namaPejabat,
    'sbb_aset': sbbAset,
    'sbb_penyusutan': sbbPenyusutan,
    'sbb_biaya_penyusutan': sbbBiayaPenyusutan,
    'sbb_rugi_revaluasi': sbbRugiRevaluasi,
    'sbb_laba_revaluasi': sbbLabaRevaluasi,
    'sbb_rugi_jual': sbbRugiJual,
    'sbb_laba_jual': sbbLabaJual,
    'sbb_biaya_perbaikan': sbbBiayaPerbaikan
  };

  InventarisModel clone() => InventarisModel(
    id: id,
    kdaset: kdaset,
    ket: ket,
    kodeKelompok: kodeKelompok,
    namaKelompok: namaKelompok,
    kodeGolongan: kodeGolongan,
    namaGolongan: namaGolongan,
    nodokBeli: nodokBeli,
    tglBeli: tglBeli,
    tglTerima: tglTerima,
    habeli: habeli,
    disc: disc,
    biaya: biaya,
    haper: haper,
    nilaiResidu: nilaiResidu,
    ppnBeli: ppnBeli,
    pph: pph,
    tglJual: tglJual,
    nodokJual: nodokJual,
    hajual: hajual,
    ppnJual: ppnJual,
    margin: margin,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk,
    lokasi: lokasi,
    kota: kota,
    masasusut: masasusut,
    blnMulaiSusut: blnMulaiSusut,
    kdkondisi: kdkondisi,
    kondisi: kondisi,
    satuanAset: satuanAset,
    nilaiDeclining: nilaiDeclining,
    perbaikan: perbaikan,
    stsasr: stsasr,
    nopolis: nopolis,
    nilaiRevaluasi: nilaiRevaluasi,
    nik: nik,
    namaPejabat: namaPejabat,
    sbbAset: sbbAset,
    sbbPenyusutan: sbbPenyusutan,
    sbbBiayaPenyusutan: sbbBiayaPenyusutan,
    sbbRugiRevaluasi: sbbRugiRevaluasi,
    sbbLabaRevaluasi: sbbLabaRevaluasi,
    sbbRugiJual: sbbRugiJual,
    sbbLabaJual: sbbLabaJual,
    sbbBiayaPerbaikan: sbbBiayaPerbaikan
  );


  InventarisModel copyWith({
    int? id,
    String? kdaset,
    String? ket,
    String? kodeKelompok,
    String? namaKelompok,
    String? kodeGolongan,
    String? namaGolongan,
    String? nodokBeli,
    String? tglBeli,
    String? tglTerima,
    String? habeli,
    String? disc,
    String? biaya,
    String? haper,
    String? nilaiResidu,
    String? ppnBeli,
    String? pph,
    String? tglJual,
    String? nodokJual,
    String? hajual,
    String? ppnJual,
    String? margin,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk,
    String? lokasi,
    String? kota,
    String? masasusut,
    String? blnMulaiSusut,
    String? kdkondisi,
    String? kondisi,
    String? satuanAset,
    String? nilaiDeclining,
    String? perbaikan,
    String? stsasr,
    String? nopolis,
    String? nilaiRevaluasi,
    String? nik,
    String? namaPejabat,
    String? sbbAset,
    String? sbbPenyusutan,
    String? sbbBiayaPenyusutan,
    String? sbbRugiRevaluasi,
    String? sbbLabaRevaluasi,
    String? sbbRugiJual,
    String? sbbLabaJual,
    String? sbbBiayaPerbaikan
  }) => InventarisModel(
    id: id ?? this.id,
    kdaset: kdaset ?? this.kdaset,
    ket: ket ?? this.ket,
    kodeKelompok: kodeKelompok ?? this.kodeKelompok,
    namaKelompok: namaKelompok ?? this.namaKelompok,
    kodeGolongan: kodeGolongan ?? this.kodeGolongan,
    namaGolongan: namaGolongan ?? this.namaGolongan,
    nodokBeli: nodokBeli ?? this.nodokBeli,
    tglBeli: tglBeli ?? this.tglBeli,
    tglTerima: tglTerima ?? this.tglTerima,
    habeli: habeli ?? this.habeli,
    disc: disc ?? this.disc,
    biaya: biaya ?? this.biaya,
    haper: haper ?? this.haper,
    nilaiResidu: nilaiResidu ?? this.nilaiResidu,
    ppnBeli: ppnBeli ?? this.ppnBeli,
    pph: pph ?? this.pph,
    tglJual: tglJual ?? this.tglJual,
    nodokJual: nodokJual ?? this.nodokJual,
    hajual: hajual ?? this.hajual,
    ppnJual: ppnJual ?? this.ppnJual,
    margin: margin ?? this.margin,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
    lokasi: lokasi ?? this.lokasi,
    kota: kota ?? this.kota,
    masasusut: masasusut ?? this.masasusut,
    blnMulaiSusut: blnMulaiSusut ?? this.blnMulaiSusut,
    kdkondisi: kdkondisi ?? this.kdkondisi,
    kondisi: kondisi ?? this.kondisi,
    satuanAset: satuanAset ?? this.satuanAset,
    nilaiDeclining: nilaiDeclining ?? this.nilaiDeclining,
    perbaikan: perbaikan ?? this.perbaikan,
    stsasr: stsasr ?? this.stsasr,
    nopolis: nopolis ?? this.nopolis,
    nilaiRevaluasi: nilaiRevaluasi ?? this.nilaiRevaluasi,
    nik: nik ?? this.nik,
    namaPejabat: namaPejabat ?? this.namaPejabat,
    sbbAset: sbbAset ?? this.sbbAset,
    sbbPenyusutan: sbbPenyusutan ?? this.sbbPenyusutan,
    sbbBiayaPenyusutan: sbbBiayaPenyusutan ?? this.sbbBiayaPenyusutan,
    sbbRugiRevaluasi: sbbRugiRevaluasi ?? this.sbbRugiRevaluasi,
    sbbLabaRevaluasi: sbbLabaRevaluasi ?? this.sbbLabaRevaluasi,
    sbbRugiJual: sbbRugiJual ?? this.sbbRugiJual,
    sbbLabaJual: sbbLabaJual ?? this.sbbLabaJual,
    sbbBiayaPerbaikan: sbbBiayaPerbaikan ?? this.sbbBiayaPerbaikan,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is InventarisModel && id == other.id && kdaset == other.kdaset && ket == other.ket && kodeKelompok == other.kodeKelompok && namaKelompok == other.namaKelompok && kodeGolongan == other.kodeGolongan && namaGolongan == other.namaGolongan && nodokBeli == other.nodokBeli && tglBeli == other.tglBeli && tglTerima == other.tglTerima && habeli == other.habeli && disc == other.disc && biaya == other.biaya && haper == other.haper && nilaiResidu == other.nilaiResidu && ppnBeli == other.ppnBeli && pph == other.pph && tglJual == other.tglJual && nodokJual == other.nodokJual && hajual == other.hajual && ppnJual == other.ppnJual && margin == other.margin && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && lokasi == other.lokasi && kota == other.kota && masasusut == other.masasusut && blnMulaiSusut == other.blnMulaiSusut && kdkondisi == other.kdkondisi && kondisi == other.kondisi && satuanAset == other.satuanAset && nilaiDeclining == other.nilaiDeclining && perbaikan == other.perbaikan && stsasr == other.stsasr && nopolis == other.nopolis && nilaiRevaluasi == other.nilaiRevaluasi && nik == other.nik && namaPejabat == other.namaPejabat && sbbAset == other.sbbAset && sbbPenyusutan == other.sbbPenyusutan && sbbBiayaPenyusutan == other.sbbBiayaPenyusutan && sbbRugiRevaluasi == other.sbbRugiRevaluasi && sbbLabaRevaluasi == other.sbbLabaRevaluasi && sbbRugiJual == other.sbbRugiJual && sbbLabaJual == other.sbbLabaJual && sbbBiayaPerbaikan == other.sbbBiayaPerbaikan;

  @override
  int get hashCode => id.hashCode ^ kdaset.hashCode ^ ket.hashCode ^ kodeKelompok.hashCode ^ namaKelompok.hashCode ^ kodeGolongan.hashCode ^ namaGolongan.hashCode ^ nodokBeli.hashCode ^ tglBeli.hashCode ^ tglTerima.hashCode ^ habeli.hashCode ^ disc.hashCode ^ biaya.hashCode ^ haper.hashCode ^ nilaiResidu.hashCode ^ ppnBeli.hashCode ^ pph.hashCode ^ tglJual.hashCode ^ nodokJual.hashCode ^ hajual.hashCode ^ ppnJual.hashCode ^ margin.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ lokasi.hashCode ^ kota.hashCode ^ masasusut.hashCode ^ blnMulaiSusut.hashCode ^ kdkondisi.hashCode ^ kondisi.hashCode ^ satuanAset.hashCode ^ nilaiDeclining.hashCode ^ perbaikan.hashCode ^ stsasr.hashCode ^ nopolis.hashCode ^ nilaiRevaluasi.hashCode ^ nik.hashCode ^ namaPejabat.hashCode ^ sbbAset.hashCode ^ sbbPenyusutan.hashCode ^ sbbBiayaPenyusutan.hashCode ^ sbbRugiRevaluasi.hashCode ^ sbbLabaRevaluasi.hashCode ^ sbbRugiJual.hashCode ^ sbbLabaJual.hashCode ^ sbbBiayaPerbaikan.hashCode;
}
