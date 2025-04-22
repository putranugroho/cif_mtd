import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class CoaModel {

  const CoaModel({
    required this.id,
    required this.golAcc,
    required this.jnsAcc,
    required this.nobb,
    required this.nosbb,
    required this.namaSbb,
    required this.typePosting,
    required this.sbbKhusus,
    required this.createddate,
    required this.isDeleted,
    required this.kodePt,
    required this.kodeKantor,
    required this.limitDebet,
    required this.limitKredit,
    required this.akunPerantara,
    required this.hutang,
    required this.piutang,
  });

  final int id;
  final String golAcc;
  final String jnsAcc;
  final String nobb;
  final String nosbb;
  final String namaSbb;
  final String typePosting;
  final String sbbKhusus;
  final String createddate;
  final String isDeleted;
  final String kodePt;
  final String kodeKantor;
  final String limitDebet;
  final String limitKredit;
  final String akunPerantara;
  final String hutang;
  final String piutang;

  factory CoaModel.fromJson(Map<String,dynamic> json) => CoaModel(
    id: json['id'] as int,
    golAcc: json['gol_acc'].toString(),
    jnsAcc: json['jns_acc'].toString(),
    nobb: json['nobb'].toString(),
    nosbb: json['nosbb'].toString(),
    namaSbb: json['nama_sbb'].toString(),
    typePosting: json['type_posting'].toString(),
    sbbKhusus: json['sbb_khusus'].toString(),
    createddate: json['createddate'].toString(),
    isDeleted: json['is_deleted'].toString(),
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    limitDebet: json['limit_debet'].toString(),
    limitKredit: json['limit_kredit'].toString(),
    akunPerantara: json['akun_perantara'].toString(),
    hutang: json['hutang'].toString(),
    piutang: json['piutang'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'gol_acc': golAcc,
    'jns_acc': jnsAcc,
    'nobb': nobb,
    'nosbb': nosbb,
    'nama_sbb': namaSbb,
    'type_posting': typePosting,
    'sbb_khusus': sbbKhusus,
    'createddate': createddate,
    'is_deleted': isDeleted,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'limit_debet': limitDebet,
    'limit_kredit': limitKredit,
    'akun_perantara': akunPerantara,
    'hutang': hutang,
    'piutang': piutang
  };

  CoaModel clone() => CoaModel(
    id: id,
    golAcc: golAcc,
    jnsAcc: jnsAcc,
    nobb: nobb,
    nosbb: nosbb,
    namaSbb: namaSbb,
    typePosting: typePosting,
    sbbKhusus: sbbKhusus,
    createddate: createddate,
    isDeleted: isDeleted,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    limitDebet: limitDebet,
    limitKredit: limitKredit,
    akunPerantara: akunPerantara,
    hutang: hutang,
    piutang: piutang
  );


  CoaModel copyWith({
    int? id,
    String? golAcc,
    String? jnsAcc,
    String? nobb,
    String? nosbb,
    String? namaSbb,
    String? typePosting,
    String? sbbKhusus,
    String? createddate,
    String? isDeleted,
    String? kodePt,
    String? kodeKantor,
    String? limitDebet,
    String? limitKredit,
    String? akunPerantara,
    String? hutang,
    String? piutang
  }) => CoaModel(
    id: id ?? this.id,
    golAcc: golAcc ?? this.golAcc,
    jnsAcc: jnsAcc ?? this.jnsAcc,
    nobb: nobb ?? this.nobb,
    nosbb: nosbb ?? this.nosbb,
    namaSbb: namaSbb ?? this.namaSbb,
    typePosting: typePosting ?? this.typePosting,
    sbbKhusus: sbbKhusus ?? this.sbbKhusus,
    createddate: createddate ?? this.createddate,
    isDeleted: isDeleted ?? this.isDeleted,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    limitDebet: limitDebet ?? this.limitDebet,
    limitKredit: limitKredit ?? this.limitKredit,
    akunPerantara: akunPerantara ?? this.akunPerantara,
    hutang: hutang ?? this.hutang,
    piutang: piutang ?? this.piutang,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is CoaModel && id == other.id && golAcc == other.golAcc && jnsAcc == other.jnsAcc && nobb == other.nobb && nosbb == other.nosbb && namaSbb == other.namaSbb && typePosting == other.typePosting && sbbKhusus == other.sbbKhusus && createddate == other.createddate && isDeleted == other.isDeleted && kodePt == other.kodePt && kodeKantor == other.kodeKantor && limitDebet == other.limitDebet && limitKredit == other.limitKredit && akunPerantara == other.akunPerantara && hutang == other.hutang && piutang == other.piutang;

  @override
  int get hashCode => id.hashCode ^ golAcc.hashCode ^ jnsAcc.hashCode ^ nobb.hashCode ^ nosbb.hashCode ^ namaSbb.hashCode ^ typePosting.hashCode ^ sbbKhusus.hashCode ^ createddate.hashCode ^ isDeleted.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ limitDebet.hashCode ^ limitKredit.hashCode ^ akunPerantara.hashCode ^ hutang.hashCode ^ piutang.hashCode;
}
