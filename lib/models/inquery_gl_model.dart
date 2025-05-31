import 'package:flutter/foundation.dart';

@immutable
class InqueryGlModel {
  const InqueryGlModel({
    required this.id,
    required this.golAcc,
    required this.jnsAcc,
    required this.nobb,
    required this.nosbb,
    required this.namaSbb,
    required this.typePosting,
    required this.akunPerantara,
    required this.hutang,
    required this.nonaktif,
    required this.piutang,
    required this.sbbKhusus,
    required this.items,
  });

  final int id;
  final String golAcc;
  final String jnsAcc;
  final String nobb;
  final String nosbb;
  final String namaSbb;
  final String typePosting;
  final String akunPerantara;
  final String hutang;
  final String nonaktif;
  final String piutang;
  final String sbbKhusus;
  final List<InqueryGlModel> items;

  factory InqueryGlModel.fromJson(Map<String, dynamic> json) => InqueryGlModel(id: json['id'] as int, golAcc: json['gol_acc'].toString(), jnsAcc: json['jns_acc'].toString(), nobb: json['nobb'].toString(), nosbb: json['nosbb'].toString(), namaSbb: json['nama_sbb'].toString(), typePosting: json['type_posting'].toString(), akunPerantara: json['akun_perantara'].toString(), hutang: json['hutang'].toString(), nonaktif: json['nonaktif'].toString(), piutang: json['piutang'].toString(), sbbKhusus: json['sbb_khusus'].toString(), items: (json['items'] as List? ?? []).map((e) => InqueryGlModel.fromJson(e as Map<String, dynamic>)).toList());

  Map<String, dynamic> toJson() => {
        'id': id,
        'gol_acc': golAcc,
        'jns_acc': jnsAcc,
        'nobb': nobb,
        'nosbb': nosbb,
        'nama_sbb': namaSbb,
        'type_posting': typePosting,
        'akun_perantara': akunPerantara,
        'hutang': hutang,
        'nonaktif': nonaktif,
        'piutang': piutang,
        'sbb_khusus': sbbKhusus,
        'items': items.map((e) => e.toJson()).toList()
      };

  InqueryGlModel clone() => InqueryGlModel(id: id, golAcc: golAcc, jnsAcc: jnsAcc, nobb: nobb, nosbb: nosbb, namaSbb: namaSbb, typePosting: typePosting, akunPerantara: akunPerantara, hutang: hutang, nonaktif: nonaktif, piutang: piutang, sbbKhusus: sbbKhusus, items: items.map((e) => e.clone()).toList());

  InqueryGlModel copyWith({int? id, String? golAcc, String? jnsAcc, String? nobb, String? nosbb, String? namaSbb, String? typePosting, String? akunPerantara, String? hutang, String? nonaktif, String? piutang, String? sbbKhusus, List<InqueryGlModel>? items}) => InqueryGlModel(
        id: id ?? this.id,
        golAcc: golAcc ?? this.golAcc,
        jnsAcc: jnsAcc ?? this.jnsAcc,
        nobb: nobb ?? this.nobb,
        nosbb: nosbb ?? this.nosbb,
        namaSbb: namaSbb ?? this.namaSbb,
        typePosting: typePosting ?? this.typePosting,
        akunPerantara: akunPerantara ?? this.akunPerantara,
        hutang: hutang ?? this.hutang,
        nonaktif: nonaktif ?? this.nonaktif,
        piutang: piutang ?? this.piutang,
        sbbKhusus: sbbKhusus ?? this.sbbKhusus,
        items: items ?? this.items,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is InqueryGlModel && id == other.id && golAcc == other.golAcc && jnsAcc == other.jnsAcc && nobb == other.nobb && nosbb == other.nosbb && namaSbb == other.namaSbb && typePosting == other.typePosting && akunPerantara == other.akunPerantara && hutang == other.hutang && nonaktif == other.nonaktif && piutang == other.piutang && sbbKhusus == other.sbbKhusus && items == other.items;

  @override
  int get hashCode => id.hashCode ^ golAcc.hashCode ^ jnsAcc.hashCode ^ nobb.hashCode ^ nosbb.hashCode ^ namaSbb.hashCode ^ typePosting.hashCode ^ akunPerantara.hashCode ^ hutang.hashCode ^ nonaktif.hashCode ^ piutang.hashCode ^ sbbKhusus.hashCode ^ items.hashCode;
}
