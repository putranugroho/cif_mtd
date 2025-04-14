import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class RekonPerantaraTransaksiModel {
  RekonPerantaraTransaksiModel({
    required this.tglTrans,
    required this.transUser,
    required this.kodeTrans,
    required this.debetAcc,
    required this.namaDebet,
    required this.creditAcc,
    required this.namaCredit,
    required this.nomorDok,
    required this.nomorRef,
    required this.nominal,
    required this.keterangan,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.kodeAoDebet,
    required this.kodeAoCredit,
    this.sisaSaldo,
  });

  final String tglTrans;
  final String transUser;
  final String kodeTrans;
  final String debetAcc;
  final String namaDebet;
  final String creditAcc;
  final String namaCredit;
  final String nomorDok;
  final String nomorRef;
  final double nominal;
  final String keterangan;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;
  final String kodeAoDebet;
  final String kodeAoCredit;
  double? sisaSaldo;

  factory RekonPerantaraTransaksiModel.fromJson(Map<String, dynamic> json) =>
      RekonPerantaraTransaksiModel(
          tglTrans: json['tgl_trans'].toString(),
          transUser: json['trans_user'].toString(),
          kodeTrans: json['kode_trans'].toString(),
          debetAcc: json['debet_acc'].toString(),
          namaDebet: json['nama_debet'].toString(),
          creditAcc: json['credit_acc'].toString(),
          namaCredit: json['nama_credit'].toString(),
          nomorDok: json['nomor_dok'].toString(),
          nomorRef: json['nomor_ref'].toString(),
          nominal: (json['nominal'] as num).toDouble(),
          keterangan: json['keterangan'].toString(),
          kodePt: json['kode_pt'].toString(),
          kodeKantor: json['kode_kantor'].toString(),
          kodeInduk: json['kode_induk'].toString(),
          kodeAoDebet: json['kode_ao_debet'].toString(),
          kodeAoCredit: json['kode_ao_credit'].toString());

  Map<String, dynamic> toJson() => {
        'tgl_trans': tglTrans,
        'trans_user': transUser,
        'kode_trans': kodeTrans,
        'debet_acc': debetAcc,
        'nama_debet': namaDebet,
        'credit_acc': creditAcc,
        'nama_credit': namaCredit,
        'nomor_dok': nomorDok,
        'nomor_ref': nomorRef,
        'nominal': nominal,
        'keterangan': keterangan,
        'kode_pt': kodePt,
        'kode_kantor': kodeKantor,
        'kode_induk': kodeInduk,
        'kode_ao_debet': kodeAoDebet,
        "sisaSaldo": sisaSaldo,
        'kode_ao_credit': kodeAoCredit
      };

  RekonPerantaraTransaksiModel clone() => RekonPerantaraTransaksiModel(
      tglTrans: tglTrans,
      transUser: transUser,
      kodeTrans: kodeTrans,
      debetAcc: debetAcc,
      namaDebet: namaDebet,
      creditAcc: creditAcc,
      namaCredit: namaCredit,
      nomorDok: nomorDok,
      nomorRef: nomorRef,
      nominal: nominal,
      keterangan: keterangan,
      kodePt: kodePt,
      kodeKantor: kodeKantor,
      kodeInduk: kodeInduk,
      kodeAoDebet: kodeAoDebet,
      kodeAoCredit: kodeAoCredit);

  RekonPerantaraTransaksiModel copyWith(
          {String? tglTrans,
          String? transUser,
          String? kodeTrans,
          String? debetAcc,
          String? namaDebet,
          String? creditAcc,
          String? namaCredit,
          String? nomorDok,
          String? nomorRef,
          double? nominal,
          String? keterangan,
          String? kodePt,
          String? kodeKantor,
          String? kodeInduk,
          String? kodeAoDebet,
          String? kodeAoCredit}) =>
      RekonPerantaraTransaksiModel(
        tglTrans: tglTrans ?? this.tglTrans,
        transUser: transUser ?? this.transUser,
        kodeTrans: kodeTrans ?? this.kodeTrans,
        debetAcc: debetAcc ?? this.debetAcc,
        namaDebet: namaDebet ?? this.namaDebet,
        creditAcc: creditAcc ?? this.creditAcc,
        namaCredit: namaCredit ?? this.namaCredit,
        nomorDok: nomorDok ?? this.nomorDok,
        nomorRef: nomorRef ?? this.nomorRef,
        nominal: nominal ?? this.nominal,
        keterangan: keterangan ?? this.keterangan,
        kodePt: kodePt ?? this.kodePt,
        kodeKantor: kodeKantor ?? this.kodeKantor,
        kodeInduk: kodeInduk ?? this.kodeInduk,
        kodeAoDebet: kodeAoDebet ?? this.kodeAoDebet,
        kodeAoCredit: kodeAoCredit ?? this.kodeAoCredit,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RekonPerantaraTransaksiModel &&
          tglTrans == other.tglTrans &&
          transUser == other.transUser &&
          kodeTrans == other.kodeTrans &&
          debetAcc == other.debetAcc &&
          namaDebet == other.namaDebet &&
          creditAcc == other.creditAcc &&
          namaCredit == other.namaCredit &&
          nomorDok == other.nomorDok &&
          nomorRef == other.nomorRef &&
          nominal == other.nominal &&
          keterangan == other.keterangan &&
          kodePt == other.kodePt &&
          kodeKantor == other.kodeKantor &&
          kodeInduk == other.kodeInduk &&
          kodeAoDebet == other.kodeAoDebet &&
          kodeAoCredit == other.kodeAoCredit;

  @override
  int get hashCode =>
      tglTrans.hashCode ^
      transUser.hashCode ^
      kodeTrans.hashCode ^
      debetAcc.hashCode ^
      namaDebet.hashCode ^
      creditAcc.hashCode ^
      namaCredit.hashCode ^
      nomorDok.hashCode ^
      nomorRef.hashCode ^
      nominal.hashCode ^
      keterangan.hashCode ^
      kodePt.hashCode ^
      kodeKantor.hashCode ^
      kodeInduk.hashCode ^
      kodeAoDebet.hashCode ^
      kodeAoCredit.hashCode;
}
