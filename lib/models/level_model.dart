import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class LevelModel {

  const LevelModel({
    required this.id,
    required this.lvlJabatan,
    required this.kelJabatan,
  });

  final int id;
  final String lvlJabatan;
  final String kelJabatan;

  factory LevelModel.fromJson(Map<String,dynamic> json) => LevelModel(
    id: json['id'] as int,
    lvlJabatan: json['lvl_jabatan'].toString(),
    kelJabatan: json['kel_jabatan'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'lvl_jabatan': lvlJabatan,
    'kel_jabatan': kelJabatan
  };

  LevelModel clone() => LevelModel(
    id: id,
    lvlJabatan: lvlJabatan,
    kelJabatan: kelJabatan
  );


  LevelModel copyWith({
    int? id,
    String? lvlJabatan,
    String? kelJabatan
  }) => LevelModel(
    id: id ?? this.id,
    lvlJabatan: lvlJabatan ?? this.lvlJabatan,
    kelJabatan: kelJabatan ?? this.kelJabatan,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is LevelModel && id == other.id && lvlJabatan == other.lvlJabatan && kelJabatan == other.kelJabatan;

  @override
  int get hashCode => id.hashCode ^ lvlJabatan.hashCode ^ kelJabatan.hashCode;
}
