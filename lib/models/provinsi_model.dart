import 'package:flutter/foundation.dart';

@immutable
class ProvinsiModel {
  const ProvinsiModel({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory ProvinsiModel.fromJson(Map<String, dynamic> json) => ProvinsiModel(id: json['id'].toString(), name: json['name'].toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name
      };

  ProvinsiModel clone() => ProvinsiModel(id: id, name: name);

  ProvinsiModel copyWith({String? id, String? name}) => ProvinsiModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProvinsiModel && id == other.id && name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
