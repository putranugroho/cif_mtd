import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class UserAksesPointModel {

  const UserAksesPointModel({
    required this.id,
    required this.userId,
    required this.empId,
    required this.noAkses,
    required this.aksesId,
    required this.kodePt,
    required this.createddate,
    required this.isDeleted,
  });

  final int id;
  final String userId;
  final String empId;
  final String noAkses;
  final String aksesId;
  final String kodePt;
  final String createddate;
  final String isDeleted;

  factory UserAksesPointModel.fromJson(Map<String,dynamic> json) => UserAksesPointModel(
    id: json['id'] as int,
    userId: json['user_id'].toString(),
    empId: json['emp_id'].toString(),
    noAkses: json['no_akses'].toString(),
    aksesId: json['akses_id'].toString(),
    kodePt: json['kode_pt'].toString(),
    createddate: json['createddate'].toString(),
    isDeleted: json['is_deleted'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'emp_id': empId,
    'no_akses': noAkses,
    'akses_id': aksesId,
    'kode_pt': kodePt,
    'createddate': createddate,
    'is_deleted': isDeleted
  };

  UserAksesPointModel clone() => UserAksesPointModel(
    id: id,
    userId: userId,
    empId: empId,
    noAkses: noAkses,
    aksesId: aksesId,
    kodePt: kodePt,
    createddate: createddate,
    isDeleted: isDeleted
  );


  UserAksesPointModel copyWith({
    int? id,
    String? userId,
    String? empId,
    String? noAkses,
    String? aksesId,
    String? kodePt,
    String? createddate,
    String? isDeleted
  }) => UserAksesPointModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    empId: empId ?? this.empId,
    noAkses: noAkses ?? this.noAkses,
    aksesId: aksesId ?? this.aksesId,
    kodePt: kodePt ?? this.kodePt,
    createddate: createddate ?? this.createddate,
    isDeleted: isDeleted ?? this.isDeleted,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is UserAksesPointModel && id == other.id && userId == other.userId && empId == other.empId && noAkses == other.noAkses && aksesId == other.aksesId && kodePt == other.kodePt && createddate == other.createddate && isDeleted == other.isDeleted;

  @override
  int get hashCode => id.hashCode ^ userId.hashCode ^ empId.hashCode ^ noAkses.hashCode ^ aksesId.hashCode ^ kodePt.hashCode ^ createddate.hashCode ^ isDeleted.hashCode;
}
