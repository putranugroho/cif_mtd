import 'package:flutter/foundation.dart';

@immutable
class LevelUserModul {
  const LevelUserModul({
    required this.modul,
    required this.menu,
    required this.submenu,
    required this.view,
    required this.input,
    required this.edit,
    required this.delete,
  });

  final String modul;
  final String menu;
  final String submenu;
  final String view;
  final String input;
  final String edit;
  final String delete;

  factory LevelUserModul.fromJson(Map<String, dynamic> json) => LevelUserModul(modul: json['modul'].toString(), menu: json['menu'].toString(), submenu: json['submenu'].toString(), view: json['view'].toString(), input: json['input'].toString(), edit: json['edit'].toString(), delete: json['delete'].toString());

  Map<String, dynamic> toJson() => {
        'modul': modul,
        'menu': menu,
        'submenu': submenu,
        'view': view,
        'input': input,
        'edit': edit,
        'delete': delete
      };

  LevelUserModul clone() => LevelUserModul(modul: modul, menu: menu, submenu: submenu, view: view, input: input, edit: edit, delete: delete);

  LevelUserModul copyWith({String? modul, String? menu, String? submenu, String? view, String? input, String? edit, String? delete}) => LevelUserModul(
        modul: modul ?? this.modul,
        menu: menu ?? this.menu,
        submenu: submenu ?? this.submenu,
        view: view ?? this.view,
        input: input ?? this.input,
        edit: edit ?? this.edit,
        delete: delete ?? this.delete,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is LevelUserModul && modul == other.modul && menu == other.menu && submenu == other.submenu && view == other.view && input == other.input && edit == other.edit && delete == other.delete;

  @override
  int get hashCode => modul.hashCode ^ menu.hashCode ^ submenu.hashCode ^ view.hashCode ^ input.hashCode ^ edit.hashCode ^ delete.hashCode;
}
