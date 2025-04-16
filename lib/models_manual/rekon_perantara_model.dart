import 'package:accounting/models_manual/rekon_perantara_item_model.dart';
import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

@immutable
class RekonPerantaraModel {
  const RekonPerantaraModel({
    required this.nobb,
    required this.namaBb,
    required this.typePosting,
    required this.sbbItem,
  });

  final String nobb;
  final String namaBb;
  final String typePosting;
  final List<RekonPerantaraItemModel> sbbItem;

  factory RekonPerantaraModel.fromJson(Map<String, dynamic> json) =>
      RekonPerantaraModel(
          nobb: json['nobb'].toString(),
          namaBb: json['nama_bb'].toString(),
          typePosting: json['type_posting'].toString(),
          sbbItem: (json['sbb_item'] as List? ?? [])
              .map((e) =>
                  RekonPerantaraItemModel.fromJson(e as Map<String, dynamic>))
              .toList());

  Map<String, dynamic> toJson() => {
        'nobb': nobb,
        'nama_bb': namaBb,
        'type_posting': typePosting,
        'sbb_item': sbbItem.map((e) => e.toJson()).toList()
      };

  RekonPerantaraModel clone() => RekonPerantaraModel(
      nobb: nobb,
      namaBb: namaBb,
      typePosting: typePosting,
      sbbItem: sbbItem.map((e) => e.clone()).toList());

  RekonPerantaraModel copyWith(
          {String? nobb,
          String? namaBb,
          String? typePosting,
          List<RekonPerantaraItemModel>? sbbItem}) =>
      RekonPerantaraModel(
        nobb: nobb ?? this.nobb,
        namaBb: namaBb ?? this.namaBb,
        typePosting: typePosting ?? this.typePosting,
        sbbItem: sbbItem ?? this.sbbItem,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RekonPerantaraModel &&
          nobb == other.nobb &&
          namaBb == other.namaBb &&
          typePosting == other.typePosting &&
          sbbItem == other.sbbItem;

  @override
  int get hashCode =>
      nobb.hashCode ^ namaBb.hashCode ^ typePosting.hashCode ^ sbbItem.hashCode;
}
