import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class OtorisasiModel {

  const OtorisasiModel({
    required this.modul,
    required this.user,
    required this.tanggal,
    required this.data,
    required this.status,
  });

  final String modul;
  final String user;
  final String tanggal;
  final String data;
  final String status;

  factory OtorisasiModel.fromJson(Map<String,dynamic> json) => OtorisasiModel(
    modul: json['modul'].toString(),
    user: json['user'].toString(),
    tanggal: json['tanggal'].toString(),
    data: json['data'].toString(),
    status: json['status'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'modul': modul,
    'user': user,
    'tanggal': tanggal,
    'data': data,
    'status': status
  };

  OtorisasiModel clone() => OtorisasiModel(
    modul: modul,
    user: user,
    tanggal: tanggal,
    data: data,
    status: status
  );


  OtorisasiModel copyWith({
    String? modul,
    String? user,
    String? tanggal,
    String? data,
    String? status
  }) => OtorisasiModel(
    modul: modul ?? this.modul,
    user: user ?? this.user,
    tanggal: tanggal ?? this.tanggal,
    data: data ?? this.data,
    status: status ?? this.status,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is OtorisasiModel && modul == other.modul && user == other.user && tanggal == other.tanggal && data == other.data && status == other.status;

  @override
  int get hashCode => modul.hashCode ^ user.hashCode ^ tanggal.hashCode ^ data.hashCode ^ status.hashCode;
}
