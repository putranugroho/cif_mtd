import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class NeracaItemModel {

  const NeracaItemModel({
    required this.nosbb,
    required this.namaSbb,
    required this.typePosting,
    required this.saldo,
  });

  final String nosbb;
  final String namaSbb;
  final String typePosting;
  final double saldo;

  factory NeracaItemModel.fromJson(Map<String,dynamic> json) => NeracaItemModel(
    nosbb: json['nosbb'].toString(),
    namaSbb: json['nama_sbb'].toString(),
    typePosting: json['type_posting'].toString(),
    saldo: (json['saldo'] as num).toDouble()
  );
  
  Map<String, dynamic> toJson() => {
    'nosbb': nosbb,
    'nama_sbb': namaSbb,
    'type_posting': typePosting,
    'saldo': saldo
  };

  NeracaItemModel clone() => NeracaItemModel(
    nosbb: nosbb,
    namaSbb: namaSbb,
    typePosting: typePosting,
    saldo: saldo
  );


  NeracaItemModel copyWith({
    String? nosbb,
    String? namaSbb,
    String? typePosting,
    double? saldo
  }) => NeracaItemModel(
    nosbb: nosbb ?? this.nosbb,
    namaSbb: namaSbb ?? this.namaSbb,
    typePosting: typePosting ?? this.typePosting,
    saldo: saldo ?? this.saldo,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is NeracaItemModel && nosbb == other.nosbb && namaSbb == other.namaSbb && typePosting == other.typePosting && saldo == other.saldo;

  @override
  int get hashCode => nosbb.hashCode ^ namaSbb.hashCode ^ typePosting.hashCode ^ saldo.hashCode;
}
