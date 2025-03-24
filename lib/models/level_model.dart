import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class LevelModel {

  const LevelModel({
    required this.lvlJabatan,
    required this.kelJabatan,
  });

  final String lvlJabatan;
  final String kelJabatan;

  factory LevelModel.fromJson(Map<String,dynamic> json) => LevelModel(
    lvlJabatan: json['lvl_jabatan'].toString(),
    kelJabatan: json['kel_jabatan'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'lvl_jabatan': lvlJabatan,
    'kel_jabatan': kelJabatan
  };

  LevelModel clone() => LevelModel(
    lvlJabatan: lvlJabatan,
    kelJabatan: kelJabatan
  );


  LevelModel copyWith({
    String? lvlJabatan,
    String? kelJabatan
  }) => LevelModel(
    lvlJabatan: lvlJabatan ?? this.lvlJabatan,
    kelJabatan: kelJabatan ?? this.kelJabatan,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is LevelModel && lvlJabatan == other.lvlJabatan && kelJabatan == other.kelJabatan;

  @override
  int get hashCode => lvlJabatan.hashCode ^ kelJabatan.hashCode;
}
