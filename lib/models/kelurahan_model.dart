import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class KelurahanModel {

  const KelurahanModel({
    required this.id,
    required this.districtId,
    required this.name,
  });

  final String id;
  final String districtId;
  final String name;

  factory KelurahanModel.fromJson(Map<String,dynamic> json) => KelurahanModel(
    id: json['id'].toString(),
    districtId: json['district_id'].toString(),
    name: json['name'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'district_id': districtId,
    'name': name
  };

  KelurahanModel clone() => KelurahanModel(
    id: id,
    districtId: districtId,
    name: name
  );


  KelurahanModel copyWith({
    String? id,
    String? districtId,
    String? name
  }) => KelurahanModel(
    id: id ?? this.id,
    districtId: districtId ?? this.districtId,
    name: name ?? this.name,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is KelurahanModel && id == other.id && districtId == other.districtId && name == other.name;

  @override
  int get hashCode => id.hashCode ^ districtId.hashCode ^ name.hashCode;
}
