import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class ItemCategoryModulModel {

  const ItemCategoryModulModel({
    required this.menu,
    required this.submenu,
    required this.keterangan,
  });

  final String menu;
  final String submenu;
  final String keterangan;

  factory ItemCategoryModulModel.fromJson(Map<String,dynamic> json) => ItemCategoryModulModel(
    menu: json['menu'].toString(),
    submenu: json['submenu'].toString(),
    keterangan: json['keterangan'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'menu': menu,
    'submenu': submenu,
    'keterangan': keterangan
  };

  ItemCategoryModulModel clone() => ItemCategoryModulModel(
    menu: menu,
    submenu: submenu,
    keterangan: keterangan
  );


  ItemCategoryModulModel copyWith({
    String? menu,
    String? submenu,
    String? keterangan
  }) => ItemCategoryModulModel(
    menu: menu ?? this.menu,
    submenu: submenu ?? this.submenu,
    keterangan: keterangan ?? this.keterangan,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ItemCategoryModulModel && menu == other.menu && submenu == other.submenu && keterangan == other.keterangan;

  @override
  int get hashCode => menu.hashCode ^ submenu.hashCode ^ keterangan.hashCode;
}
