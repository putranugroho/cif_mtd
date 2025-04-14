import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class RekonPerantaraItemModel {
  const RekonPerantaraItemModel({
    required this.nosbb,
    required this.namaSbb,
    required this.typePosting,
    required this.saldo,
    required this.itemTransaksi,
  });

  final String nosbb;
  final String namaSbb;
  final String typePosting;
  final double saldo;
  final List<RekonPerantaraTransaksiModel> itemTransaksi;

  factory RekonPerantaraItemModel.fromJson(Map<String, dynamic> json) {
    double sisaSaldo = (json['saldo'] ?? 0).toDouble();
    List<dynamic> transaksiList = json['item_transaksi'] ?? [];

    List<RekonPerantaraTransaksiModel> transaksiParsed = [];

    for (var trxJson in transaksiList) {
      RekonPerantaraTransaksiModel trx =
          RekonPerantaraTransaksiModel.fromJson(trxJson);
      sisaSaldo -= trx.nominal;
      trx.sisaSaldo = sisaSaldo;
      transaksiParsed.add(trx);
    }

    return RekonPerantaraItemModel(
      nosbb: json['nosbb'],
      namaSbb: json['nama_sbb'],
      typePosting: json['type_posting'],
      saldo: (json['saldo'] ?? 0).toDouble(),
      itemTransaksi: transaksiParsed,
    );
  }

  Map<String, dynamic> toJson() => {
        'nosbb': nosbb,
        'nama_sbb': namaSbb,
        'type_posting': typePosting,
        'saldo': saldo,
        'item_transaksi': itemTransaksi.map((e) => e.toJson()).toList()
      };

  RekonPerantaraItemModel clone() => RekonPerantaraItemModel(
      nosbb: nosbb,
      namaSbb: namaSbb,
      typePosting: typePosting,
      saldo: saldo,
      itemTransaksi: itemTransaksi.map((e) => e.clone()).toList());

  RekonPerantaraItemModel copyWith(
          {String? nosbb,
          String? namaSbb,
          String? typePosting,
          double? saldo,
          List<RekonPerantaraTransaksiModel>? itemTransaksi}) =>
      RekonPerantaraItemModel(
        nosbb: nosbb ?? this.nosbb,
        namaSbb: namaSbb ?? this.namaSbb,
        typePosting: typePosting ?? this.typePosting,
        saldo: saldo ?? this.saldo,
        itemTransaksi: itemTransaksi ?? this.itemTransaksi,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RekonPerantaraItemModel &&
          nosbb == other.nosbb &&
          namaSbb == other.namaSbb &&
          typePosting == other.typePosting &&
          saldo == other.saldo &&
          itemTransaksi == other.itemTransaksi;

  @override
  int get hashCode =>
      nosbb.hashCode ^
      namaSbb.hashCode ^
      typePosting.hashCode ^
      saldo.hashCode ^
      itemTransaksi.hashCode;
}
