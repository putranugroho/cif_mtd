import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class BankModel {

  const BankModel({
    required this.kodeBank,
    required this.nmBank,
    required this.noRek,
    required this.kdRek,
    required this.nosbb,
    required this.namaSbb,
    required this.nominal,
    required this.jw,
    required this.tglbuka,
    required this.tgljtempo,
    required this.saldoeom,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
  });

  final String kodeBank;
  final String nmBank;
  final String noRek;
  final String kdRek;
  final String nosbb;
  final String namaSbb;
  final String nominal;
  final String jw;
  final String tglbuka;
  final String tgljtempo;
  final String saldoeom;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;

  factory BankModel.fromJson(Map<String,dynamic> json) => BankModel(
    kodeBank: json['kode_bank'].toString(),
    nmBank: json['nm_bank'].toString(),
    noRek: json['no_rek'].toString(),
    kdRek: json['kd_rek'].toString(),
    nosbb: json['nosbb'].toString(),
    namaSbb: json['nama_sbb'].toString(),
    nominal: json['nominal'].toString(),
    jw: json['jw'].toString(),
    tglbuka: json['tglbuka'].toString(),
    tgljtempo: json['tgljtempo'].toString(),
    saldoeom: json['saldoeom'].toString(),
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'kode_bank': kodeBank,
    'nm_bank': nmBank,
    'no_rek': noRek,
    'kd_rek': kdRek,
    'nosbb': nosbb,
    'nama_sbb': namaSbb,
    'nominal': nominal,
    'jw': jw,
    'tglbuka': tglbuka,
    'tgljtempo': tgljtempo,
    'saldoeom': saldoeom,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk
  };

  BankModel clone() => BankModel(
    kodeBank: kodeBank,
    nmBank: nmBank,
    noRek: noRek,
    kdRek: kdRek,
    nosbb: nosbb,
    namaSbb: namaSbb,
    nominal: nominal,
    jw: jw,
    tglbuka: tglbuka,
    tgljtempo: tgljtempo,
    saldoeom: saldoeom,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk
  );


  BankModel copyWith({
    String? kodeBank,
    String? nmBank,
    String? noRek,
    String? kdRek,
    String? nosbb,
    String? namaSbb,
    String? nominal,
    String? jw,
    String? tglbuka,
    String? tgljtempo,
    String? saldoeom,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk
  }) => BankModel(
    kodeBank: kodeBank ?? this.kodeBank,
    nmBank: nmBank ?? this.nmBank,
    noRek: noRek ?? this.noRek,
    kdRek: kdRek ?? this.kdRek,
    nosbb: nosbb ?? this.nosbb,
    namaSbb: namaSbb ?? this.namaSbb,
    nominal: nominal ?? this.nominal,
    jw: jw ?? this.jw,
    tglbuka: tglbuka ?? this.tglbuka,
    tgljtempo: tgljtempo ?? this.tgljtempo,
    saldoeom: saldoeom ?? this.saldoeom,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is BankModel && kodeBank == other.kodeBank && nmBank == other.nmBank && noRek == other.noRek && kdRek == other.kdRek && nosbb == other.nosbb && namaSbb == other.namaSbb && nominal == other.nominal && jw == other.jw && tglbuka == other.tglbuka && tgljtempo == other.tgljtempo && saldoeom == other.saldoeom && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk;

  @override
  int get hashCode => kodeBank.hashCode ^ nmBank.hashCode ^ noRek.hashCode ^ kdRek.hashCode ^ nosbb.hashCode ^ namaSbb.hashCode ^ nominal.hashCode ^ jw.hashCode ^ tglbuka.hashCode ^ tgljtempo.hashCode ^ saldoeom.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode;
}
