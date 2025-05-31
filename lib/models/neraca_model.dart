import 'package:flutter/foundation.dart';

import 'index.dart';

@immutable
class NeracaModel {
  const NeracaModel({
    required this.nobb,
    required this.namaBb,
    required this.typePosting,
    required this.sbbItem,
  });

  final String nobb;
  final String namaBb;
  final String typePosting;
  final List<NeracaItemModel> sbbItem;

  factory NeracaModel.fromJson(Map<String, dynamic> json) => NeracaModel(nobb: json['nobb'].toString(), namaBb: json['nama_bb'].toString(), typePosting: json['type_posting'].toString(), sbbItem: (json['sbb_item'] as List? ?? []).map((e) => NeracaItemModel.fromJson(e as Map<String, dynamic>)).toList());

  Map<String, dynamic> toJson() => {
        'nobb': nobb,
        'nama_bb': namaBb,
        'type_posting': typePosting,
        'sbb_item': sbbItem.map((e) => e.toJson()).toList()
      };

  NeracaModel clone() => NeracaModel(nobb: nobb, namaBb: namaBb, typePosting: typePosting, sbbItem: sbbItem.map((e) => e.clone()).toList());

  NeracaModel copyWith({String? nobb, String? namaBb, String? typePosting, List<NeracaItemModel>? sbbItem}) => NeracaModel(
        nobb: nobb ?? this.nobb,
        namaBb: namaBb ?? this.namaBb,
        typePosting: typePosting ?? this.typePosting,
        sbbItem: sbbItem ?? this.sbbItem,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is NeracaModel && nobb == other.nobb && namaBb == other.namaBb && typePosting == other.typePosting && sbbItem == other.sbbItem;

  @override
  int get hashCode => nobb.hashCode ^ namaBb.hashCode ^ typePosting.hashCode ^ sbbItem.hashCode;
}
