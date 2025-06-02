import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class ModulModel {

  const ModulModel({
    required this.modul,
    required this.menu,
  });

  final String modul;
  final List<ItemCategoryModulModel> menu;

  factory ModulModel.fromJson(Map<String,dynamic> json) => ModulModel(
    modul: json['modul'].toString(),
    menu: (json['menu'] as List? ?? []).map((e) => ItemCategoryModulModel.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'modul': modul,
    'menu': menu.map((e) => e.toJson()).toList()
  };

  ModulModel clone() => ModulModel(
    modul: modul,
    menu: menu.map((e) => e.clone()).toList()
  );


  ModulModel copyWith({
    String? modul,
    List<ItemCategoryModulModel>? menu
  }) => ModulModel(
    modul: modul ?? this.modul,
    menu: menu ?? this.menu,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is ModulModel && modul == other.modul && menu == other.menu;

  @override
  int get hashCode => modul.hashCode ^ menu.hashCode;
}
