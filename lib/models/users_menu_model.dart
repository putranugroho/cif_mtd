import 'package:flutter/foundation.dart';

@immutable
class UsersMenuModel {
  const UsersMenuModel({
    required this.userid,
    required this.modul,
    required this.menu,
    required this.submenu,
    required this.flag,
  });

  final String userid;
  final String modul;
  final String menu;
  final String submenu;
  final String flag;

  factory UsersMenuModel.fromJson(Map<String, dynamic> json) => UsersMenuModel(userid: json['userid'].toString(), modul: json['modul'].toString(), menu: json['menu'].toString(), submenu: json['submenu'].toString(), flag: json['flag'].toString());

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'modul': modul,
        'menu': menu,
        'submenu': submenu,
        'flag': flag
      };

  UsersMenuModel clone() => UsersMenuModel(userid: userid, modul: modul, menu: menu, submenu: submenu, flag: flag);

  UsersMenuModel copyWith({String? userid, String? modul, String? menu, String? submenu, String? flag}) => UsersMenuModel(
        userid: userid ?? this.userid,
        modul: modul ?? this.modul,
        menu: menu ?? this.menu,
        submenu: submenu ?? this.submenu,
        flag: flag ?? this.flag,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is UsersMenuModel && userid == other.userid && modul == other.modul && menu == other.menu && submenu == other.submenu && flag == other.flag;

  @override
  int get hashCode => userid.hashCode ^ modul.hashCode ^ menu.hashCode ^ submenu.hashCode ^ flag.hashCode;
}
