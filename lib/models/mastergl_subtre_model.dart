import 'package:flutter/foundation.dart';

@immutable
class MasterglSubtreModel {
  const MasterglSubtreModel({
    required this.nosbb,
    required this.nobb,
    required this.golAcc,
    required this.namaSbb,
    required this.jnsAcc,
    required this.typePosting,
    required this.nonaktif,
    required this.children,
  });

  final String nosbb;
  final String nobb;
  final String golAcc;
  final String namaSbb;
  final String jnsAcc;
  final String typePosting;
  final String nonaktif;
  final List<MasterglSubtreModel> children;

  factory MasterglSubtreModel.fromJson(Map<String, dynamic> json) => MasterglSubtreModel(nosbb: json['nosbb'].toString(), nobb: json['nobb'].toString(), golAcc: json['gol_acc'].toString(), namaSbb: json['nama_sbb'].toString(), jnsAcc: json['jns_acc'].toString(), typePosting: json['type_posting'].toString(), nonaktif: json['nonaktif'].toString(), children: (json['children'] as List? ?? []).map((e) => MasterglSubtreModel.fromJson(e as Map<String, dynamic>)).toList());

  Map<String, dynamic> toJson() => {
        'nosbb': nosbb,
        'nobb': nobb,
        'gol_acc': golAcc,
        'nama_sbb': namaSbb,
        'jns_acc': jnsAcc,
        'type_posting': typePosting,
        'nonaktif': nonaktif,
        'children': children.map((e) => e.toJson()).toList()
      };

  MasterglSubtreModel clone() => MasterglSubtreModel(nosbb: nosbb, nobb: nobb, golAcc: golAcc, namaSbb: namaSbb, jnsAcc: jnsAcc, typePosting: typePosting, nonaktif: nonaktif, children: children.map((e) => e.clone()).toList());

  MasterglSubtreModel copyWith({String? nosbb, String? nobb, String? golAcc, String? namaSbb, String? jnsAcc, String? typePosting, String? nonaktif, List<MasterglSubtreModel>? children}) => MasterglSubtreModel(
        nosbb: nosbb ?? this.nosbb,
        nobb: nobb ?? this.nobb,
        golAcc: golAcc ?? this.golAcc,
        namaSbb: namaSbb ?? this.namaSbb,
        jnsAcc: jnsAcc ?? this.jnsAcc,
        typePosting: typePosting ?? this.typePosting,
        nonaktif: nonaktif ?? this.nonaktif,
        children: children ?? this.children,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is MasterglSubtreModel && nosbb == other.nosbb && nobb == other.nobb && golAcc == other.golAcc && namaSbb == other.namaSbb && jnsAcc == other.jnsAcc && typePosting == other.typePosting && nonaktif == other.nonaktif && children == other.children;

  @override
  int get hashCode => nosbb.hashCode ^ nobb.hashCode ^ golAcc.hashCode ^ namaSbb.hashCode ^ jnsAcc.hashCode ^ typePosting.hashCode ^ nonaktif.hashCode ^ children.hashCode;
}
