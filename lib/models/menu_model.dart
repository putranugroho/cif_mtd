import 'package:flutter/foundation.dart';

@immutable
class MenuModel {
  const MenuModel({
    required this.modul,
    required this.menu,
    required this.submenu,
  });

  final String modul;
  final String menu;
  final String submenu;

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(modul: json['modul'].toString(), menu: json['menu'].toString(), submenu: json['submenu'].toString());

  Map<String, dynamic> toJson() => {
        'modul': modul,
        'menu': menu,
        'submenu': submenu
      };

  MenuModel clone() => MenuModel(modul: modul, menu: menu, submenu: submenu);

  MenuModel copyWith({String? modul, String? menu, String? submenu}) => MenuModel(
        modul: modul ?? this.modul,
        menu: menu ?? this.menu,
        submenu: submenu ?? this.submenu,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is MenuModel && modul == other.modul && menu == other.menu && submenu == other.submenu;

  @override
  int get hashCode => modul.hashCode ^ menu.hashCode ^ submenu.hashCode;
}
