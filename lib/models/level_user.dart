import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class LevelUser {

  const LevelUser({
    required this.idLevel,
    required this.levelUser,
    required this.kodePt,
    required this.createddate,
    required this.moduls,
  });

  final String idLevel;
  final String levelUser;
  final String kodePt;
  final String createddate;
  final List<LevelUserModul> moduls;

  factory LevelUser.fromJson(Map<String,dynamic> json) => LevelUser(
    idLevel: json['id_level'].toString(),
    levelUser: json['level_user'].toString(),
    kodePt: json['kode_pt'].toString(),
    createddate: json['createddate'].toString(),
    moduls: (json['moduls'] as List? ?? []).map((e) => LevelUserModul.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'id_level': idLevel,
    'level_user': levelUser,
    'kode_pt': kodePt,
    'createddate': createddate,
    'moduls': moduls.map((e) => e.toJson()).toList()
  };

  LevelUser clone() => LevelUser(
    idLevel: idLevel,
    levelUser: levelUser,
    kodePt: kodePt,
    createddate: createddate,
    moduls: moduls.map((e) => e.clone()).toList()
  );


  LevelUser copyWith({
    String? idLevel,
    String? levelUser,
    String? kodePt,
    String? createddate,
    List<LevelUserModul>? moduls
  }) => LevelUser(
    idLevel: idLevel ?? this.idLevel,
    levelUser: levelUser ?? this.levelUser,
    kodePt: kodePt ?? this.kodePt,
    createddate: createddate ?? this.createddate,
    moduls: moduls ?? this.moduls,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is LevelUser && idLevel == other.idLevel && levelUser == other.levelUser && kodePt == other.kodePt && createddate == other.createddate && moduls == other.moduls;

  @override
  int get hashCode => idLevel.hashCode ^ levelUser.hashCode ^ kodePt.hashCode ^ createddate.hashCode ^ moduls.hashCode;
}
