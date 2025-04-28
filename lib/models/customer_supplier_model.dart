import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'index.dart';

@immutable
class CustomerSupplierModel {

  const CustomerSupplierModel({
    required this.id,
    required this.kodePt,
    required this.noSif,
    required this.nmSif,
    required this.golCust,
    required this.bidangUsaha,
    required this.alamat,
    required this.kelurahan,
    required this.kecamatan,
    required this.kota,
    required this.provinsi,
    required this.kdpos,
    required this.npwp,
    required this.pkp,
    required this.noTelp,
    required this.email,
    required this.kontak1,
    required this.hp1,
    required this.email1,
    required this.keterangan1,
    required this.kontak2,
    required this.hp2,
    required this.email2,
    required this.keterangan2,
    required this.kontak3,
    required this.hp3,
    required this.email3,
    required this.keterangan3,
    required this.kodeAo,
  });

  final int id;
  final String kodePt;
  final String noSif;
  final String nmSif;
  final String golCust;
  final String bidangUsaha;
  final String alamat;
  final String kelurahan;
  final String kecamatan;
  final String kota;
  final String provinsi;
  final String kdpos;
  final String npwp;
  final String pkp;
  final String noTelp;
  final String email;
  final String kontak1;
  final String hp1;
  final String email1;
  final String keterangan1;
  final String kontak2;
  final String hp2;
  final String email2;
  final String keterangan2;
  final String kontak3;
  final String hp3;
  final String email3;
  final String keterangan3;
  final String kodeAo;

  factory CustomerSupplierModel.fromJson(Map<String,dynamic> json) => CustomerSupplierModel(
    id: json['id'] as int,
    kodePt: json['kode_pt'].toString(),
    noSif: json['no_sif'].toString(),
    nmSif: json['nm_sif'].toString(),
    golCust: json['gol_cust'].toString(),
    bidangUsaha: json['bidang_usaha'].toString(),
    alamat: json['alamat'].toString(),
    kelurahan: json['kelurahan'].toString(),
    kecamatan: json['kecamatan'].toString(),
    kota: json['kota'].toString(),
    provinsi: json['provinsi'].toString(),
    kdpos: json['kdpos'].toString(),
    npwp: json['npwp'].toString(),
    pkp: json['pkp'].toString(),
    noTelp: json['no_telp'].toString(),
    email: json['email'].toString(),
    kontak1: json['kontak1'].toString(),
    hp1: json['hp1'].toString(),
    email1: json['email1'].toString(),
    keterangan1: json['keterangan1'].toString(),
    kontak2: json['kontak2'].toString(),
    hp2: json['hp2'].toString(),
    email2: json['email2'].toString(),
    keterangan2: json['keterangan2'].toString(),
    kontak3: json['kontak3'].toString(),
    hp3: json['hp3'].toString(),
    email3: json['email3'].toString(),
    keterangan3: json['keterangan3'].toString(),
    kodeAo: json['kode_ao'].toString()
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'kode_pt': kodePt,
    'no_sif': noSif,
    'nm_sif': nmSif,
    'gol_cust': golCust,
    'bidang_usaha': bidangUsaha,
    'alamat': alamat,
    'kelurahan': kelurahan,
    'kecamatan': kecamatan,
    'kota': kota,
    'provinsi': provinsi,
    'kdpos': kdpos,
    'npwp': npwp,
    'pkp': pkp,
    'no_telp': noTelp,
    'email': email,
    'kontak1': kontak1,
    'hp1': hp1,
    'email1': email1,
    'keterangan1': keterangan1,
    'kontak2': kontak2,
    'hp2': hp2,
    'email2': email2,
    'keterangan2': keterangan2,
    'kontak3': kontak3,
    'hp3': hp3,
    'email3': email3,
    'keterangan3': keterangan3,
    'kode_ao': kodeAo
  };

  CustomerSupplierModel clone() => CustomerSupplierModel(
    id: id,
    kodePt: kodePt,
    noSif: noSif,
    nmSif: nmSif,
    golCust: golCust,
    bidangUsaha: bidangUsaha,
    alamat: alamat,
    kelurahan: kelurahan,
    kecamatan: kecamatan,
    kota: kota,
    provinsi: provinsi,
    kdpos: kdpos,
    npwp: npwp,
    pkp: pkp,
    noTelp: noTelp,
    email: email,
    kontak1: kontak1,
    hp1: hp1,
    email1: email1,
    keterangan1: keterangan1,
    kontak2: kontak2,
    hp2: hp2,
    email2: email2,
    keterangan2: keterangan2,
    kontak3: kontak3,
    hp3: hp3,
    email3: email3,
    keterangan3: keterangan3,
    kodeAo: kodeAo
  );


  CustomerSupplierModel copyWith({
    int? id,
    String? kodePt,
    String? noSif,
    String? nmSif,
    String? golCust,
    String? bidangUsaha,
    String? alamat,
    String? kelurahan,
    String? kecamatan,
    String? kota,
    String? provinsi,
    String? kdpos,
    String? npwp,
    String? pkp,
    String? noTelp,
    String? email,
    String? kontak1,
    String? hp1,
    String? email1,
    String? keterangan1,
    String? kontak2,
    String? hp2,
    String? email2,
    String? keterangan2,
    String? kontak3,
    String? hp3,
    String? email3,
    String? keterangan3,
    String? kodeAo
  }) => CustomerSupplierModel(
    id: id ?? this.id,
    kodePt: kodePt ?? this.kodePt,
    noSif: noSif ?? this.noSif,
    nmSif: nmSif ?? this.nmSif,
    golCust: golCust ?? this.golCust,
    bidangUsaha: bidangUsaha ?? this.bidangUsaha,
    alamat: alamat ?? this.alamat,
    kelurahan: kelurahan ?? this.kelurahan,
    kecamatan: kecamatan ?? this.kecamatan,
    kota: kota ?? this.kota,
    provinsi: provinsi ?? this.provinsi,
    kdpos: kdpos ?? this.kdpos,
    npwp: npwp ?? this.npwp,
    pkp: pkp ?? this.pkp,
    noTelp: noTelp ?? this.noTelp,
    email: email ?? this.email,
    kontak1: kontak1 ?? this.kontak1,
    hp1: hp1 ?? this.hp1,
    email1: email1 ?? this.email1,
    keterangan1: keterangan1 ?? this.keterangan1,
    kontak2: kontak2 ?? this.kontak2,
    hp2: hp2 ?? this.hp2,
    email2: email2 ?? this.email2,
    keterangan2: keterangan2 ?? this.keterangan2,
    kontak3: kontak3 ?? this.kontak3,
    hp3: hp3 ?? this.hp3,
    email3: email3 ?? this.email3,
    keterangan3: keterangan3 ?? this.keterangan3,
    kodeAo: kodeAo ?? this.kodeAo,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is CustomerSupplierModel && id == other.id && kodePt == other.kodePt && noSif == other.noSif && nmSif == other.nmSif && golCust == other.golCust && bidangUsaha == other.bidangUsaha && alamat == other.alamat && kelurahan == other.kelurahan && kecamatan == other.kecamatan && kota == other.kota && provinsi == other.provinsi && kdpos == other.kdpos && npwp == other.npwp && pkp == other.pkp && noTelp == other.noTelp && email == other.email && kontak1 == other.kontak1 && hp1 == other.hp1 && email1 == other.email1 && keterangan1 == other.keterangan1 && kontak2 == other.kontak2 && hp2 == other.hp2 && email2 == other.email2 && keterangan2 == other.keterangan2 && kontak3 == other.kontak3 && hp3 == other.hp3 && email3 == other.email3 && keterangan3 == other.keterangan3 && kodeAo == other.kodeAo;

  @override
  int get hashCode => id.hashCode ^ kodePt.hashCode ^ noSif.hashCode ^ nmSif.hashCode ^ golCust.hashCode ^ bidangUsaha.hashCode ^ alamat.hashCode ^ kelurahan.hashCode ^ kecamatan.hashCode ^ kota.hashCode ^ provinsi.hashCode ^ kdpos.hashCode ^ npwp.hashCode ^ pkp.hashCode ^ noTelp.hashCode ^ email.hashCode ^ kontak1.hashCode ^ hp1.hashCode ^ email1.hashCode ^ keterangan1.hashCode ^ kontak2.hashCode ^ hp2.hashCode ^ email2.hashCode ^ keterangan2.hashCode ^ kontak3.hashCode ^ hp3.hashCode ^ email3.hashCode ^ keterangan3.hashCode ^ kodeAo.hashCode;
}
