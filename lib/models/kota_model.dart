import 'package:flutter/foundation.dart';

@immutable
class KotaModel {
  const KotaModel({
    required this.id,
    required this.provinceId,
    required this.name,
  });

  final String id;
  final String provinceId;
  final String name;

  factory KotaModel.fromJson(Map<String, dynamic> json) => KotaModel(id: json['id'].toString(), provinceId: json['province_id'].toString(), name: json['name'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'province_id': provinceId,
        'name': name
      };

  KotaModel clone() => KotaModel(id: id, provinceId: provinceId, name: name);

  KotaModel copyWith({String? id, String? provinceId, String? name}) => KotaModel(
        id: id ?? this.id,
        provinceId: provinceId ?? this.provinceId,
        name: name ?? this.name,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is KotaModel && id == other.id && provinceId == other.provinceId && name == other.name;

  @override
  int get hashCode => id.hashCode ^ provinceId.hashCode ^ name.hashCode;
}
