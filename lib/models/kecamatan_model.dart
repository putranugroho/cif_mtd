import 'package:flutter/foundation.dart';

@immutable
class KecamatanModel {
  const KecamatanModel({
    required this.id,
    required this.regencyId,
    required this.name,
  });

  final String id;
  final String regencyId;
  final String name;

  factory KecamatanModel.fromJson(Map<String, dynamic> json) => KecamatanModel(id: json['id'].toString(), regencyId: json['regency_id'].toString(), name: json['name'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'regency_id': regencyId,
        'name': name
      };

  KecamatanModel clone() => KecamatanModel(id: id, regencyId: regencyId, name: name);

  KecamatanModel copyWith({String? id, String? regencyId, String? name}) => KecamatanModel(
        id: id ?? this.id,
        regencyId: regencyId ?? this.regencyId,
        name: name ?? this.name,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is KecamatanModel && id == other.id && regencyId == other.regencyId && name == other.name;

  @override
  int get hashCode => id.hashCode ^ regencyId.hashCode ^ name.hashCode;
}
