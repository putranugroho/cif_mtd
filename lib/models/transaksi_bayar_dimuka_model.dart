import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class TransaksiBayarDimukaModel {

  const TransaksiBayarDimukaModel({
    required this.id,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.userinput,
    required this.userterm,
    required this.nomorDok,
    required this.nomorRef,
    required this.masaBayar,
    required this.nominal,
    required this.nilaiPengakuan,
    required this.keterangan,
    required this.debetSbb,
    required this.creditSbb,
    required this.mulaiSusu,
    required this.createddate,
    required this.status,
  });

  final int id;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;
  final String userinput;
  final String userterm;
  final String nomorDok;
  final String nomorRef;
  final String masaBayar;
  final String nominal;
  final String nilaiPengakuan;
  final String keterangan;
  final String debetSbb;
  final String creditSbb;
  final String mulaiSusu;
  final String createddate;
  final String status;

  factory TransaksiBayarDimukaModel.fromJson(Map<String,dynamic> json) => TransaksiBayarDimukaModel(
    id: json['id'] as int,
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString(),
    userinput: json['userinput'].toString(),
    userterm: json['userterm'].toString(),
    nomorDok: json['nomor_dok'].toString(),
    nomorRef: json['nomor_ref'].toString(),
    masaBayar: json['masa_bayar'].toString(),
    nominal: json['nominal'].toString(),
    nilaiPengakuan: json['nilai_pengakuan'].toString(),
    keterangan: json['keterangan'].toString(),
    debetSbb: json['debet_sbb'].toString(),
    creditSbb: json['credit_sbb'].toString(),
    mulaiSusu: json['mulai_susu'].toString(),
    createddate: json['createddate'].toString(),
    status: json['status'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk,
    'userinput': userinput,
    'userterm': userterm,
    'nomor_dok': nomorDok,
    'nomor_ref': nomorRef,
    'masa_bayar': masaBayar,
    'nominal': nominal,
    'nilai_pengakuan': nilaiPengakuan,
    'keterangan': keterangan,
    'debet_sbb': debetSbb,
    'credit_sbb': creditSbb,
    'mulai_susu': mulaiSusu,
    'createddate': createddate,
    'status': status
  };

  TransaksiBayarDimukaModel clone() => TransaksiBayarDimukaModel(
    id: id,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk,
    userinput: userinput,
    userterm: userterm,
    nomorDok: nomorDok,
    nomorRef: nomorRef,
    masaBayar: masaBayar,
    nominal: nominal,
    nilaiPengakuan: nilaiPengakuan,
    keterangan: keterangan,
    debetSbb: debetSbb,
    creditSbb: creditSbb,
    mulaiSusu: mulaiSusu,
    createddate: createddate,
    status: status
  );


  TransaksiBayarDimukaModel copyWith({
    int? id,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk,
    String? userinput,
    String? userterm,
    String? nomorDok,
    String? nomorRef,
    String? masaBayar,
    String? nominal,
    String? nilaiPengakuan,
    String? keterangan,
    String? debetSbb,
    String? creditSbb,
    String? mulaiSusu,
    String? createddate,
    String? status
  }) => TransaksiBayarDimukaModel(
    id: id ?? this.id,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
    userinput: userinput ?? this.userinput,
    userterm: userterm ?? this.userterm,
    nomorDok: nomorDok ?? this.nomorDok,
    nomorRef: nomorRef ?? this.nomorRef,
    masaBayar: masaBayar ?? this.masaBayar,
    nominal: nominal ?? this.nominal,
    nilaiPengakuan: nilaiPengakuan ?? this.nilaiPengakuan,
    keterangan: keterangan ?? this.keterangan,
    debetSbb: debetSbb ?? this.debetSbb,
    creditSbb: creditSbb ?? this.creditSbb,
    mulaiSusu: mulaiSusu ?? this.mulaiSusu,
    createddate: createddate ?? this.createddate,
    status: status ?? this.status,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TransaksiBayarDimukaModel && id == other.id && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && userinput == other.userinput && userterm == other.userterm && nomorDok == other.nomorDok && nomorRef == other.nomorRef && masaBayar == other.masaBayar && nominal == other.nominal && nilaiPengakuan == other.nilaiPengakuan && keterangan == other.keterangan && debetSbb == other.debetSbb && creditSbb == other.creditSbb && mulaiSusu == other.mulaiSusu && createddate == other.createddate && status == other.status;

  @override
  int get hashCode => id.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ userinput.hashCode ^ userterm.hashCode ^ nomorDok.hashCode ^ nomorRef.hashCode ^ masaBayar.hashCode ^ nominal.hashCode ^ nilaiPengakuan.hashCode ^ keterangan.hashCode ^ debetSbb.hashCode ^ creditSbb.hashCode ^ mulaiSusu.hashCode ^ createddate.hashCode ^ status.hashCode;
}
