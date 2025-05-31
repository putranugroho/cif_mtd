import 'package:flutter/foundation.dart';

@immutable
class ItemModulModel {
  const ItemModulModel({
    required this.submenu,
    required this.keterangan,
  });

  final String submenu;
  final String keterangan;

  factory ItemModulModel.fromJson(Map<String, dynamic> json) => ItemModulModel(submenu: json['submenu'].toString(), keterangan: json['keterangan'].toString());

  Map<String, dynamic> toJson() => {
        'submenu': submenu,
        'keterangan': keterangan
      };

  ItemModulModel clone() => ItemModulModel(submenu: submenu, keterangan: keterangan);

  ItemModulModel copyWith({String? submenu, String? keterangan}) => ItemModulModel(
        submenu: submenu ?? this.submenu,
        keterangan: keterangan ?? this.keterangan,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is ItemModulModel && submenu == other.submenu && keterangan == other.keterangan;

  @override
  int get hashCode => submenu.hashCode ^ keterangan.hashCode;
}
