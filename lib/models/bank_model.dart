import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class BankModel {
  const BankModel({
    required this.id,
    required this.kodeBank,
    required this.nmBank,
    required this.nmRek,
    required this.noBilyet,
    required this.noRek,
    required this.cabang,
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
    required this.createddate,
    required this.isDeleted,
  });

  final int id;
  final String kodeBank;
  final String nmBank;
  final String nmRek;
  final dynamic noBilyet;
  final String noRek;
  final String cabang;
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
  final String createddate;
  final String isDeleted;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(id: json['id'] as int, kodeBank: json['kode_bank'].toString(), nmBank: json['nm_bank'].toString(), nmRek: json['nm_rek'].toString(), noBilyet: json['no_bilyet'] as dynamic, noRek: json['no_rek'].toString(), cabang: json['cabang'].toString(), kdRek: json['kd_rek'].toString(), nosbb: json['nosbb'].toString(), namaSbb: json['nama_sbb'].toString(), nominal: json['nominal'].toString(), jw: json['jw'].toString(), tglbuka: json['tglbuka'].toString(), tgljtempo: json['tgljtempo'].toString(), saldoeom: json['saldoeom'].toString(), kodePt: json['kode_pt'].toString(), kodeKantor: json['kode_kantor'].toString(), kodeInduk: json['kode_induk'].toString(), createddate: json['createddate'].toString(), isDeleted: json['is_deleted'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'kode_bank': kodeBank,
        'nm_bank': nmBank,
        'nm_rek': nmRek,
        'no_bilyet': noBilyet,
        'no_rek': noRek,
        'cabang': cabang,
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
        'kode_induk': kodeInduk,
        'createddate': createddate,
        'is_deleted': isDeleted
      };

  BankModel clone() => BankModel(id: id, kodeBank: kodeBank, nmBank: nmBank, nmRek: nmRek, noBilyet: noBilyet, noRek: noRek, cabang: cabang, kdRek: kdRek, nosbb: nosbb, namaSbb: namaSbb, nominal: nominal, jw: jw, tglbuka: tglbuka, tgljtempo: tgljtempo, saldoeom: saldoeom, kodePt: kodePt, kodeKantor: kodeKantor, kodeInduk: kodeInduk, createddate: createddate, isDeleted: isDeleted);

  BankModel copyWith({int? id, String? kodeBank, String? nmBank, String? nmRek, dynamic noBilyet, String? noRek, String? cabang, String? kdRek, String? nosbb, String? namaSbb, String? nominal, String? jw, String? tglbuka, String? tgljtempo, String? saldoeom, String? kodePt, String? kodeKantor, String? kodeInduk, String? createddate, String? isDeleted}) => BankModel(
        id: id ?? this.id,
        kodeBank: kodeBank ?? this.kodeBank,
        nmBank: nmBank ?? this.nmBank,
        nmRek: nmRek ?? this.nmRek,
        noBilyet: noBilyet ?? this.noBilyet,
        noRek: noRek ?? this.noRek,
        cabang: cabang ?? this.cabang,
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
        createddate: createddate ?? this.createddate,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is BankModel && id == other.id && kodeBank == other.kodeBank && nmBank == other.nmBank && nmRek == other.nmRek && noBilyet == other.noBilyet && noRek == other.noRek && cabang == other.cabang && kdRek == other.kdRek && nosbb == other.nosbb && namaSbb == other.namaSbb && nominal == other.nominal && jw == other.jw && tglbuka == other.tglbuka && tgljtempo == other.tgljtempo && saldoeom == other.saldoeom && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && createddate == other.createddate && isDeleted == other.isDeleted;

  @override
  int get hashCode => id.hashCode ^ kodeBank.hashCode ^ nmBank.hashCode ^ nmRek.hashCode ^ noBilyet.hashCode ^ noRek.hashCode ^ cabang.hashCode ^ kdRek.hashCode ^ nosbb.hashCode ^ namaSbb.hashCode ^ nominal.hashCode ^ jw.hashCode ^ tglbuka.hashCode ^ tgljtempo.hashCode ^ saldoeom.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ createddate.hashCode ^ isDeleted.hashCode;
}
