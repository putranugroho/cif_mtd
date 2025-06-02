import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class UsersShiftModel {

  const UsersShiftModel({
    required this.id,
    required this.idUsers,
    required this.kdKelompok,
    required this.namaKelompok,
    required this.hari,
    required this.ke,
    required this.jamMulai,
    required this.jamSelesai,
    required this.status,
    required this.createddate,
    required this.isDeleted,
  });

  final int id;
  final int idUsers;
  final String kdKelompok;
  final String namaKelompok;
  final String hari;
  final int ke;
  final String jamMulai;
  final String jamSelesai;
  final String status;
  final String createddate;
  final String isDeleted;

  factory UsersShiftModel.fromJson(Map<String,dynamic> json) => UsersShiftModel(
    id: json['id'] as int,
    idUsers: json['id_users'] as int,
    kdKelompok: json['kd_kelompok'].toString(),
    namaKelompok: json['nama_kelompok'].toString(),
    hari: json['hari'].toString(),
    ke: json['ke'] as int,
    jamMulai: json['jam_mulai'].toString(),
    jamSelesai: json['jam_selesai'].toString(),
    status: json['status'].toString(),
    createddate: json['createddate'].toString(),
    isDeleted: json['is_deleted'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'id_users': idUsers,
    'kd_kelompok': kdKelompok,
    'nama_kelompok': namaKelompok,
    'hari': hari,
    'ke': ke,
    'jam_mulai': jamMulai,
    'jam_selesai': jamSelesai,
    'status': status,
    'createddate': createddate,
    'is_deleted': isDeleted
  };

  UsersShiftModel clone() => UsersShiftModel(
    id: id,
    idUsers: idUsers,
    kdKelompok: kdKelompok,
    namaKelompok: namaKelompok,
    hari: hari,
    ke: ke,
    jamMulai: jamMulai,
    jamSelesai: jamSelesai,
    status: status,
    createddate: createddate,
    isDeleted: isDeleted
  );


  UsersShiftModel copyWith({
    int? id,
    int? idUsers,
    String? kdKelompok,
    String? namaKelompok,
    String? hari,
    int? ke,
    String? jamMulai,
    String? jamSelesai,
    String? status,
    String? createddate,
    String? isDeleted
  }) => UsersShiftModel(
    id: id ?? this.id,
    idUsers: idUsers ?? this.idUsers,
    kdKelompok: kdKelompok ?? this.kdKelompok,
    namaKelompok: namaKelompok ?? this.namaKelompok,
    hari: hari ?? this.hari,
    ke: ke ?? this.ke,
    jamMulai: jamMulai ?? this.jamMulai,
    jamSelesai: jamSelesai ?? this.jamSelesai,
    status: status ?? this.status,
    createddate: createddate ?? this.createddate,
    isDeleted: isDeleted ?? this.isDeleted,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is UsersShiftModel && id == other.id && idUsers == other.idUsers && kdKelompok == other.kdKelompok && namaKelompok == other.namaKelompok && hari == other.hari && ke == other.ke && jamMulai == other.jamMulai && jamSelesai == other.jamSelesai && status == other.status && createddate == other.createddate && isDeleted == other.isDeleted;

  @override
  int get hashCode => id.hashCode ^ idUsers.hashCode ^ kdKelompok.hashCode ^ namaKelompok.hashCode ^ hari.hashCode ^ ke.hashCode ^ jamMulai.hashCode ^ jamSelesai.hashCode ^ status.hashCode ^ createddate.hashCode ^ isDeleted.hashCode;
}
