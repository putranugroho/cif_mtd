import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class HutangPiutangTransaksiModel {

  const HutangPiutangTransaksiModel({
    required this.nokontrak,
    required this.namaSif,
    required this.alamat,
    required this.tglKontrak,
    required this.jenisTransaksi,
    required this.keterangan,
    required this.noRef,
    required this.custsupp,
    required this.noDok,
    required this.tipeTransaksi,
    required this.noinv,
    required this.jangkawaktu,
    required this.totalTagPokok,
    required this.totalTagPpn,
    required this.totalTagPph,
    required this.totalByrPokok,
    required this.totalByrPpn,
    required this.totalByrPph,
  });

  final String nokontrak;
  final String namaSif;
  final String alamat;
  final String tglKontrak;
  final String jenisTransaksi;
  final String keterangan;
  final String noRef;
  final String custsupp;
  final dynamic noDok;
  final String tipeTransaksi;
  final dynamic noinv;
  final String jangkawaktu;
  final String totalTagPokok;
  final String totalTagPpn;
  final String totalTagPph;
  final String totalByrPokok;
  final String totalByrPpn;
  final String totalByrPph;

  factory HutangPiutangTransaksiModel.fromJson(Map<String,dynamic> json) => HutangPiutangTransaksiModel(
    nokontrak: json['nokontrak'].toString(),
    namaSif: json['nama_sif'].toString(),
    alamat: json['alamat'].toString(),
    tglKontrak: json['tgl_kontrak'].toString(),
    jenisTransaksi: json['jenis_transaksi'].toString(),
    keterangan: json['keterangan'].toString(),
    noRef: json['no_ref'].toString(),
    custsupp: json['custsupp'].toString(),
    noDok: json['no_dok'] as dynamic,
    tipeTransaksi: json['tipe_transaksi'].toString(),
    noinv: json['noinv'] as dynamic,
    jangkawaktu: json['jangkawaktu'].toString(),
    totalTagPokok: json['total_tag_pokok'].toString(),
    totalTagPpn: json['total_tag_ppn'].toString(),
    totalTagPph: json['total_tag_pph'].toString(),
    totalByrPokok: json['total_byr_pokok'].toString(),
    totalByrPpn: json['total_byr_ppn'].toString(),
    totalByrPph: json['total_byr_pph'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'nokontrak': nokontrak,
    'nama_sif': namaSif,
    'alamat': alamat,
    'tgl_kontrak': tglKontrak,
    'jenis_transaksi': jenisTransaksi,
    'keterangan': keterangan,
    'no_ref': noRef,
    'custsupp': custsupp,
    'no_dok': noDok,
    'tipe_transaksi': tipeTransaksi,
    'noinv': noinv,
    'jangkawaktu': jangkawaktu,
    'total_tag_pokok': totalTagPokok,
    'total_tag_ppn': totalTagPpn,
    'total_tag_pph': totalTagPph,
    'total_byr_pokok': totalByrPokok,
    'total_byr_ppn': totalByrPpn,
    'total_byr_pph': totalByrPph
  };

  HutangPiutangTransaksiModel clone() => HutangPiutangTransaksiModel(
    nokontrak: nokontrak,
    namaSif: namaSif,
    alamat: alamat,
    tglKontrak: tglKontrak,
    jenisTransaksi: jenisTransaksi,
    keterangan: keterangan,
    noRef: noRef,
    custsupp: custsupp,
    noDok: noDok,
    tipeTransaksi: tipeTransaksi,
    noinv: noinv,
    jangkawaktu: jangkawaktu,
    totalTagPokok: totalTagPokok,
    totalTagPpn: totalTagPpn,
    totalTagPph: totalTagPph,
    totalByrPokok: totalByrPokok,
    totalByrPpn: totalByrPpn,
    totalByrPph: totalByrPph
  );


  HutangPiutangTransaksiModel copyWith({
    String? nokontrak,
    String? namaSif,
    String? alamat,
    String? tglKontrak,
    String? jenisTransaksi,
    String? keterangan,
    String? noRef,
    String? custsupp,
    dynamic? noDok,
    String? tipeTransaksi,
    dynamic? noinv,
    String? jangkawaktu,
    String? totalTagPokok,
    String? totalTagPpn,
    String? totalTagPph,
    String? totalByrPokok,
    String? totalByrPpn,
    String? totalByrPph
  }) => HutangPiutangTransaksiModel(
    nokontrak: nokontrak ?? this.nokontrak,
    namaSif: namaSif ?? this.namaSif,
    alamat: alamat ?? this.alamat,
    tglKontrak: tglKontrak ?? this.tglKontrak,
    jenisTransaksi: jenisTransaksi ?? this.jenisTransaksi,
    keterangan: keterangan ?? this.keterangan,
    noRef: noRef ?? this.noRef,
    custsupp: custsupp ?? this.custsupp,
    noDok: noDok ?? this.noDok,
    tipeTransaksi: tipeTransaksi ?? this.tipeTransaksi,
    noinv: noinv ?? this.noinv,
    jangkawaktu: jangkawaktu ?? this.jangkawaktu,
    totalTagPokok: totalTagPokok ?? this.totalTagPokok,
    totalTagPpn: totalTagPpn ?? this.totalTagPpn,
    totalTagPph: totalTagPph ?? this.totalTagPph,
    totalByrPokok: totalByrPokok ?? this.totalByrPokok,
    totalByrPpn: totalByrPpn ?? this.totalByrPpn,
    totalByrPph: totalByrPph ?? this.totalByrPph,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is HutangPiutangTransaksiModel && nokontrak == other.nokontrak && namaSif == other.namaSif && alamat == other.alamat && tglKontrak == other.tglKontrak && jenisTransaksi == other.jenisTransaksi && keterangan == other.keterangan && noRef == other.noRef && custsupp == other.custsupp && noDok == other.noDok && tipeTransaksi == other.tipeTransaksi && noinv == other.noinv && jangkawaktu == other.jangkawaktu && totalTagPokok == other.totalTagPokok && totalTagPpn == other.totalTagPpn && totalTagPph == other.totalTagPph && totalByrPokok == other.totalByrPokok && totalByrPpn == other.totalByrPpn && totalByrPph == other.totalByrPph;

  @override
  int get hashCode => nokontrak.hashCode ^ namaSif.hashCode ^ alamat.hashCode ^ tglKontrak.hashCode ^ jenisTransaksi.hashCode ^ keterangan.hashCode ^ noRef.hashCode ^ custsupp.hashCode ^ noDok.hashCode ^ tipeTransaksi.hashCode ^ noinv.hashCode ^ jangkawaktu.hashCode ^ totalTagPokok.hashCode ^ totalTagPpn.hashCode ^ totalTagPph.hashCode ^ totalByrPokok.hashCode ^ totalByrPpn.hashCode ^ totalByrPph.hashCode;
}
