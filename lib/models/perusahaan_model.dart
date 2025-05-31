import 'package:flutter/foundation.dart';

@immutable
class PerusahaanModel {
  const PerusahaanModel({
    required this.kodePt,
    required this.namaPt,
    required this.alamat,
    required this.kelurahan,
    required this.kecamatan,
    required this.kota,
    required this.provinsi,
    required this.kodePos,
    required this.npwp,
    required this.dirut,
    required this.dirKeuangan,
    required this.dirOperasi,
  });

  final String kodePt;
  final String namaPt;
  final String alamat;
  final String kelurahan;
  final String kecamatan;
  final String kota;
  final String provinsi;
  final String kodePos;
  final String npwp;
  final String dirut;
  final String dirKeuangan;
  final String dirOperasi;

  factory PerusahaanModel.fromJson(Map<String, dynamic> json) => PerusahaanModel(kodePt: json['kode_pt'].toString(), namaPt: json['nama_pt'].toString(), alamat: json['alamat'].toString(), kelurahan: json['kelurahan'].toString(), kecamatan: json['kecamatan'].toString(), kota: json['kota'].toString(), provinsi: json['provinsi'].toString(), kodePos: json['kode_pos'].toString(), npwp: json['npwp'].toString(), dirut: json['dirut'].toString(), dirKeuangan: json['dir_keuangan'].toString(), dirOperasi: json['dir_operasi'].toString());

  Map<String, dynamic> toJson() => {
        'kode_pt': kodePt,
        'nama_pt': namaPt,
        'alamat': alamat,
        'kelurahan': kelurahan,
        'kecamatan': kecamatan,
        'kota': kota,
        'provinsi': provinsi,
        'kode_pos': kodePos,
        'npwp': npwp,
        'dirut': dirut,
        'dir_keuangan': dirKeuangan,
        'dir_operasi': dirOperasi
      };

  PerusahaanModel clone() => PerusahaanModel(kodePt: kodePt, namaPt: namaPt, alamat: alamat, kelurahan: kelurahan, kecamatan: kecamatan, kota: kota, provinsi: provinsi, kodePos: kodePos, npwp: npwp, dirut: dirut, dirKeuangan: dirKeuangan, dirOperasi: dirOperasi);

  PerusahaanModel copyWith({String? kodePt, String? namaPt, String? alamat, String? kelurahan, String? kecamatan, String? kota, String? provinsi, String? kodePos, String? npwp, String? dirut, String? dirKeuangan, String? dirOperasi}) => PerusahaanModel(
        kodePt: kodePt ?? this.kodePt,
        namaPt: namaPt ?? this.namaPt,
        alamat: alamat ?? this.alamat,
        kelurahan: kelurahan ?? this.kelurahan,
        kecamatan: kecamatan ?? this.kecamatan,
        kota: kota ?? this.kota,
        provinsi: provinsi ?? this.provinsi,
        kodePos: kodePos ?? this.kodePos,
        npwp: npwp ?? this.npwp,
        dirut: dirut ?? this.dirut,
        dirKeuangan: dirKeuangan ?? this.dirKeuangan,
        dirOperasi: dirOperasi ?? this.dirOperasi,
      );

  @override
  bool operator ==(Object other) => identical(this, other) || other is PerusahaanModel && kodePt == other.kodePt && namaPt == other.namaPt && alamat == other.alamat && kelurahan == other.kelurahan && kecamatan == other.kecamatan && kota == other.kota && provinsi == other.provinsi && kodePos == other.kodePos && npwp == other.npwp && dirut == other.dirut && dirKeuangan == other.dirKeuangan && dirOperasi == other.dirOperasi;

  @override
  int get hashCode => kodePt.hashCode ^ namaPt.hashCode ^ alamat.hashCode ^ kelurahan.hashCode ^ kecamatan.hashCode ^ kota.hashCode ^ provinsi.hashCode ^ kodePos.hashCode ^ npwp.hashCode ^ dirut.hashCode ^ dirKeuangan.hashCode ^ dirOperasi.hashCode;
}
