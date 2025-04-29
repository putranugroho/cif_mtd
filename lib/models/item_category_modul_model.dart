import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class ItemCategoryModulModel {

  const ItemCategoryModulModel({
    required this.menu,
    required this.submenu,
  });

  final String menu;
  final List<ItemModulModel> submenu;

  factory ItemCategoryModulModel.fromJson(Map<String,dynamic> json) => ItemCategoryModulModel(
    menu: json['menu'].toString(),
    submenu: (json['submenu'] as List? ?? []).map((e) => ItemModulModel.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'menu': menu,
    'submenu': submenu.map((e) => e.toJson()).toList()
  };

  ItemCategoryModulModel clone() => ItemCategoryModulModel(
    menu: menu,
    submenu: submenu.map((e) => e.clone()).toList()
  );


  ItemCategoryModulModel copyWith({
    String? menu,
    List<ItemModulModel>? submenu
  }) => ItemCategoryModulModel(
    menu: menu ?? this.menu,
    submenu: submenu ?? this.submenu,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ItemCategoryModulModel && menu == other.menu && submenu == other.submenu;

  @override
  int get hashCode => menu.hashCode ^ submenu.hashCode;
}
