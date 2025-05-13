import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class KaryawanModel {

  const KaryawanModel({
    required this.id,
    required this.nik,
    required this.namaLengkap,
    required this.email,
    required this.noHp,
    required this.jabatan,
    required this.tanggalLahir,
    required this.alamat,
    required this.tanggalMasuk,
    required this.isDeleted,
    required this.createdAt,
    required this.department,
    required this.updatedAt,
  });

  final int id;
  final String nik;
  final String namaLengkap;
  final String email;
  final String noHp;
  final String jabatan;
  final String tanggalLahir;
  final String alamat;
  final String tanggalMasuk;
  final String isDeleted;
  final String createdAt;
  final String department;
  final String updatedAt;

  factory KaryawanModel.fromJson(Map<String,dynamic> json) => KaryawanModel(
    id: json['id'] as int,
    nik: json['nik'].toString(),
    namaLengkap: json['nama_lengkap'].toString(),
    email: json['email'].toString(),
    noHp: json['no_hp'].toString(),
    jabatan: json['jabatan'].toString(),
    tanggalLahir: json['tanggal_lahir'].toString(),
    alamat: json['alamat'].toString(),
    tanggalMasuk: json['tanggal_masuk'].toString(),
    isDeleted: json['is_deleted'].toString(),
    createdAt: json['created_at'].toString(),
    department: json['department'].toString(),
    updatedAt: json['updated_at'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'nik': nik,
    'nama_lengkap': namaLengkap,
    'email': email,
    'no_hp': noHp,
    'jabatan': jabatan,
    'tanggal_lahir': tanggalLahir,
    'alamat': alamat,
    'tanggal_masuk': tanggalMasuk,
    'is_deleted': isDeleted,
    'created_at': createdAt,
    'department': department,
    'updated_at': updatedAt
  };

  KaryawanModel clone() => KaryawanModel(
    id: id,
    nik: nik,
    namaLengkap: namaLengkap,
    email: email,
    noHp: noHp,
    jabatan: jabatan,
    tanggalLahir: tanggalLahir,
    alamat: alamat,
    tanggalMasuk: tanggalMasuk,
    isDeleted: isDeleted,
    createdAt: createdAt,
    department: department,
    updatedAt: updatedAt
  );


  KaryawanModel copyWith({
    int? id,
    String? nik,
    String? namaLengkap,
    String? email,
    String? noHp,
    String? jabatan,
    String? tanggalLahir,
    String? alamat,
    String? tanggalMasuk,
    String? isDeleted,
    String? createdAt,
    String? department,
    String? updatedAt
  }) => KaryawanModel(
    id: id ?? this.id,
    nik: nik ?? this.nik,
    namaLengkap: namaLengkap ?? this.namaLengkap,
    email: email ?? this.email,
    noHp: noHp ?? this.noHp,
    jabatan: jabatan ?? this.jabatan,
    tanggalLahir: tanggalLahir ?? this.tanggalLahir,
    alamat: alamat ?? this.alamat,
    tanggalMasuk: tanggalMasuk ?? this.tanggalMasuk,
    isDeleted: isDeleted ?? this.isDeleted,
    createdAt: createdAt ?? this.createdAt,
    department: department ?? this.department,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is KaryawanModel && id == other.id && nik == other.nik && namaLengkap == other.namaLengkap && email == other.email && noHp == other.noHp && jabatan == other.jabatan && tanggalLahir == other.tanggalLahir && alamat == other.alamat && tanggalMasuk == other.tanggalMasuk && isDeleted == other.isDeleted && createdAt == other.createdAt && department == other.department && updatedAt == other.updatedAt;

  @override
  int get hashCode => id.hashCode ^ nik.hashCode ^ namaLengkap.hashCode ^ email.hashCode ^ noHp.hashCode ^ jabatan.hashCode ^ tanggalLahir.hashCode ^ alamat.hashCode ^ tanggalMasuk.hashCode ^ isDeleted.hashCode ^ createdAt.hashCode ^ department.hashCode ^ updatedAt.hashCode;
}
