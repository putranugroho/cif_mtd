import 'package:flutter/foundation.dart';

import 'index.dart';

@immutable
class ListUsersAksesPointModel {
  const ListUsersAksesPointModel({
    required this.id,
    required this.namauser,
    required this.empId,
    required this.aksesPoints,
  });

  final int id;
  final String namauser;
  final String empId;
  final List<UserAksesPointModel> aksesPoints;

  factory ListUsersAksesPointModel.fromJson(Map<String, dynamic> json) => ListUsersAksesPointModel(id: json['id'] as int, namauser: json['namauser'].toString(), empId: json['emp_id'].toString(), aksesPoints: (json['akses_points'] as List? ?? []).map((e) => UserAksesPointModel.fromJson(e as Map<String, dynamic>)).toList());

  Map<String, dynamic> toJson() => {
        'id': id,
        'namauser': namauser,
        'emp_id': empId,
        'akses_points': aksesPoints.map((e) => e.toJson()).toList()
      };

  ListUsersAksesPointModel clone() => ListUsersAksesPointModel(id: id, namauser: namauser, empId: empId, aksesPoints: aksesPoints.map((e) => e.clone()).toList());

  ListUsersAksesPointModel copyWith({int? id, String? namauser, String? empId, List<UserAksesPointModel>? aksesPoints}) => ListUsersAksesPointModel(
        id: id ?? this.id,
        namauser: namauser ?? this.namauser,
        empId: empId ?? this.empId,
        aksesPoints: aksesPoints ?? this.aksesPoints,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is ListUsersAksesPointModel && id == other.id && namauser == other.namauser && empId == other.empId && aksesPoints == other.aksesPoints;

  @override
  int get hashCode => id.hashCode ^ namauser.hashCode ^ empId.hashCode ^ aksesPoints.hashCode;
}
