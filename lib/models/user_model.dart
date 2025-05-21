import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class UserModel {

  const UserModel({
    required this.id,
    required this.userid,
    required this.empId,
    required this.pass,
    required this.namauser,
    required this.batch,
    required this.kodePt,
    required this.kodeKantor,
    required this.kodeInduk,
    required this.tglexp,
    required this.lvluser,
    required this.terminalId,
    required this.aktivasi,
    required this.aksesKasir,
    required this.sbbKasir,
    required this.namaSbb,
    required this.fhoto1,
    required this.fhoto2,
    required this.fhoto3,
    required this.levelOtor,
    required this.bedaKantor,
    required this.minOtor,
    required this.maxOtor,
    required this.createddate,
    required this.isDeleted,
    required this.backDate,
  });

  final int id;
  final String userid;
  final String empId;
  final String pass;
  final String namauser;
  final String batch;
  final String kodePt;
  final String kodeKantor;
  final String kodeInduk;
  final String tglexp;
  final String lvluser;
  final String terminalId;
  final String aktivasi;
  final String aksesKasir;
  final String sbbKasir;
  final String namaSbb;
  final String fhoto1;
  final String fhoto2;
  final String fhoto3;
  final String levelOtor;
  final String bedaKantor;
  final String minOtor;
  final String maxOtor;
  final String createddate;
  final String isDeleted;
  final String backDate;

  factory UserModel.fromJson(Map<String,dynamic> json) => UserModel(
    id: json['id'] as int,
    userid: json['userid'].toString(),
    empId: json['emp_id'].toString(),
    pass: json['pass'].toString(),
    namauser: json['namauser'].toString(),
    batch: json['batch'].toString(),
    kodePt: json['kode_pt'].toString(),
    kodeKantor: json['kode_kantor'].toString(),
    kodeInduk: json['kode_induk'].toString(),
    tglexp: json['tglexp'].toString(),
    lvluser: json['lvluser'].toString(),
    terminalId: json['terminal_id'].toString(),
    aktivasi: json['aktivasi'].toString(),
    aksesKasir: json['akses_kasir'].toString(),
    sbbKasir: json['sbb_kasir'].toString(),
    namaSbb: json['nama_sbb'].toString(),
    fhoto1: json['fhoto_1'].toString(),
    fhoto2: json['fhoto_2'].toString(),
    fhoto3: json['fhoto_3'].toString(),
    levelOtor: json['level_otor'].toString(),
    bedaKantor: json['beda_kantor'].toString(),
    minOtor: json['min_otor'].toString(),
    maxOtor: json['max_otor'].toString(),
    createddate: json['createddate'].toString(),
    isDeleted: json['is_deleted'].toString(),
    backDate: json['back_date'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'userid': userid,
    'emp_id': empId,
    'pass': pass,
    'namauser': namauser,
    'batch': batch,
    'kode_pt': kodePt,
    'kode_kantor': kodeKantor,
    'kode_induk': kodeInduk,
    'tglexp': tglexp,
    'lvluser': lvluser,
    'terminal_id': terminalId,
    'aktivasi': aktivasi,
    'akses_kasir': aksesKasir,
    'sbb_kasir': sbbKasir,
    'nama_sbb': namaSbb,
    'fhoto_1': fhoto1,
    'fhoto_2': fhoto2,
    'fhoto_3': fhoto3,
    'level_otor': levelOtor,
    'beda_kantor': bedaKantor,
    'min_otor': minOtor,
    'max_otor': maxOtor,
    'createddate': createddate,
    'is_deleted': isDeleted,
    'back_date': backDate
  };

  UserModel clone() => UserModel(
    id: id,
    userid: userid,
    empId: empId,
    pass: pass,
    namauser: namauser,
    batch: batch,
    kodePt: kodePt,
    kodeKantor: kodeKantor,
    kodeInduk: kodeInduk,
    tglexp: tglexp,
    lvluser: lvluser,
    terminalId: terminalId,
    aktivasi: aktivasi,
    aksesKasir: aksesKasir,
    sbbKasir: sbbKasir,
    namaSbb: namaSbb,
    fhoto1: fhoto1,
    fhoto2: fhoto2,
    fhoto3: fhoto3,
    levelOtor: levelOtor,
    bedaKantor: bedaKantor,
    minOtor: minOtor,
    maxOtor: maxOtor,
    createddate: createddate,
    isDeleted: isDeleted,
    backDate: backDate
  );


  UserModel copyWith({
    int? id,
    String? userid,
    String? empId,
    String? pass,
    String? namauser,
    String? batch,
    String? kodePt,
    String? kodeKantor,
    String? kodeInduk,
    String? tglexp,
    String? lvluser,
    String? terminalId,
    String? aktivasi,
    String? aksesKasir,
    String? sbbKasir,
    String? namaSbb,
    String? fhoto1,
    String? fhoto2,
    String? fhoto3,
    String? levelOtor,
    String? bedaKantor,
    String? minOtor,
    String? maxOtor,
    String? createddate,
    String? isDeleted,
    String? backDate
  }) => UserModel(
    id: id ?? this.id,
    userid: userid ?? this.userid,
    empId: empId ?? this.empId,
    pass: pass ?? this.pass,
    namauser: namauser ?? this.namauser,
    batch: batch ?? this.batch,
    kodePt: kodePt ?? this.kodePt,
    kodeKantor: kodeKantor ?? this.kodeKantor,
    kodeInduk: kodeInduk ?? this.kodeInduk,
    tglexp: tglexp ?? this.tglexp,
    lvluser: lvluser ?? this.lvluser,
    terminalId: terminalId ?? this.terminalId,
    aktivasi: aktivasi ?? this.aktivasi,
    aksesKasir: aksesKasir ?? this.aksesKasir,
    sbbKasir: sbbKasir ?? this.sbbKasir,
    namaSbb: namaSbb ?? this.namaSbb,
    fhoto1: fhoto1 ?? this.fhoto1,
    fhoto2: fhoto2 ?? this.fhoto2,
    fhoto3: fhoto3 ?? this.fhoto3,
    levelOtor: levelOtor ?? this.levelOtor,
    bedaKantor: bedaKantor ?? this.bedaKantor,
    minOtor: minOtor ?? this.minOtor,
    maxOtor: maxOtor ?? this.maxOtor,
    createddate: createddate ?? this.createddate,
    isDeleted: isDeleted ?? this.isDeleted,
    backDate: backDate ?? this.backDate,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is UserModel && id == other.id && userid == other.userid && empId == other.empId && pass == other.pass && namauser == other.namauser && batch == other.batch && kodePt == other.kodePt && kodeKantor == other.kodeKantor && kodeInduk == other.kodeInduk && tglexp == other.tglexp && lvluser == other.lvluser && terminalId == other.terminalId && aktivasi == other.aktivasi && aksesKasir == other.aksesKasir && sbbKasir == other.sbbKasir && namaSbb == other.namaSbb && fhoto1 == other.fhoto1 && fhoto2 == other.fhoto2 && fhoto3 == other.fhoto3 && levelOtor == other.levelOtor && bedaKantor == other.bedaKantor && minOtor == other.minOtor && maxOtor == other.maxOtor && createddate == other.createddate && isDeleted == other.isDeleted && backDate == other.backDate;

  @override
  int get hashCode => id.hashCode ^ userid.hashCode ^ empId.hashCode ^ pass.hashCode ^ namauser.hashCode ^ batch.hashCode ^ kodePt.hashCode ^ kodeKantor.hashCode ^ kodeInduk.hashCode ^ tglexp.hashCode ^ lvluser.hashCode ^ terminalId.hashCode ^ aktivasi.hashCode ^ aksesKasir.hashCode ^ sbbKasir.hashCode ^ namaSbb.hashCode ^ fhoto1.hashCode ^ fhoto2.hashCode ^ fhoto3.hashCode ^ levelOtor.hashCode ^ bedaKantor.hashCode ^ minOtor.hashCode ^ maxOtor.hashCode ^ createddate.hashCode ^ isDeleted.hashCode ^ backDate.hashCode;
}
