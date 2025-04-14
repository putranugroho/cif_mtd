import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class RekonsiliasiAsetNotifier extends ChangeNotifier {
  final BuildContext context;

  RekonsiliasiAsetNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(RekonAsetModel.fromJson(i));
    }
    for (var item in data) {
      String typePosting = item['kode_kelompok'];
      List<Map<String, dynamic>> sbbItems =
          List<Map<String, dynamic>>.from(item['item']);

      double subtotal = sbbItems.fold(
          0, (sum, sbb) => sum + double.parse((sbb['haper'] ?? 0)));

      // if (typePosting == 'AKTIVA') {
      //   totalAktiva += subtotal;
      // } else if (typePosting == 'PASIVA') {
      //   totalPasiva += subtotal;
      // }
    }

    notifyListeners();
  }

  int totalActive = 0;
  int totalMacet = 0;
  List<RekonAsetModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "kode_kelompok": "TR",
      "nama_kelompok": "TRANSPORTASI",
      "item": [
        {
          "kdaset": "100001",
          "ket": "NMAX 100 CC150",
          "kode_kelompok": "TR",
          "nama_kelompok": "TRANSPORTASI",
          "kode_golongan": "001",
          "nama_golongan": "Kendaraan",
          "nodok_beli": "10000101",
          "tgl_beli": "2025-03-01",
          "tgl_terima": "2025-03-07",
          "habeli": "24000000",
          "disc": "500000",
          "biaya": "150000",
          "haper": "23650000",
          "nilai_residu": "1",
          "ppn_beli": "0",
          "tgl_jual": "",
          "nodok_jual": "",
          "hajual": "",
          "ppn_jual": "",
          "margin": "",
          "kode_pt": "",
          "kode_kantor": "",
          "kode_induk": "",
          "lokasi": "",
          "kota": "",
          "masasusut": "10",
          "bln_mulai_susut": "2025-12-01",
          "kdkondisi": "",
          "kondisi": "",
          "satuan_aset": "",
          "nilai_declining": "",
          "perbaikan": "",
          "stsasr": "",
          "nopolis": "",
          "nilai_revaluasi": "",
          "nik": "",
          "nama_pejabat": "",
          "sbb_aset": "",
          "sbb_penyusutan": "",
          "sbb_biaya_penyusutan": "",
          "sbb_rugi_revaluasi": "",
          "sbb_laba_revaluasi": "",
          "sbb_rugi_jual": "",
          "sbb_laba_jual": "",
          "sbb_biaya_perbaikan": ""
        },
        {
          "kdaset": "100002",
          "ket": "AVANZA SILVER TH. 2021",
          "kode_kelompok": "TR",
          "nama_kelompok": "TRANSPORTASI",
          "kode_golongan": "001",
          "nama_golongan": "Kendaraan",
          "nodok_beli": "10000102",
          "tgl_beli": "2025-03-01",
          "tgl_terima": "2025-03-07",
          "habeli": "170000000",
          "disc": "0",
          "biaya": "0",
          "haper": "170000000",
          "nilai_residu": "1",
          "ppn_beli": "0",
          "tgl_jual": "",
          "nodok_jual": "",
          "hajual": "",
          "ppn_jual": "",
          "margin": "",
          "kode_pt": "",
          "kode_kantor": "",
          "kode_induk": "",
          "lokasi": "",
          "kota": "",
          "masasusut": "10",
          "bln_mulai_susut": "2025-12-01",
          "kdkondisi": "",
          "kondisi": "",
          "satuan_aset": "",
          "nilai_declining": "",
          "perbaikan": "",
          "stsasr": "",
          "nopolis": "",
          "nilai_revaluasi": "",
          "nik": "",
          "nama_pejabat": "",
          "sbb_aset": "",
          "sbb_penyusutan": "",
          "sbb_biaya_penyusutan": "",
          "sbb_rugi_revaluasi": "",
          "sbb_laba_revaluasi": "",
          "sbb_rugi_jual": "",
          "sbb_laba_jual": "",
          "sbb_biaya_perbaikan": ""
        },
      ],
    },
    {
      "kode_kelompok": "BN",
      "nama_kelompok": "BANGUNAN",
      "item": [
        {
          "kdaset": "100003",
          "ket": "RUKAN PERMATA HIJAU BLOK A NO.53",
          "kode_kelompok": "BN",
          "nama_kelompok": "BANGUNAN",
          "kode_golongan": "002",
          "nama_golongan": "Bangunan",
          "nodok_beli": "10000103",
          "tgl_beli": "2025-03-01",
          "tgl_terima": "2025-03-07",
          "habeli": "1200000000",
          "disc": "0",
          "biaya": "0",
          "haper": "1200000000",
          "nilai_residu": "1",
          "ppn_beli": "0",
          "tgl_jual": "",
          "nodok_jual": "",
          "hajual": "",
          "ppn_jual": "",
          "margin": "",
          "kode_pt": "",
          "kode_kantor": "",
          "kode_induk": "",
          "lokasi": "",
          "kota": "",
          "masasusut": "10",
          "bln_mulai_susut": "2025-12-01",
          "kdkondisi": "",
          "kondisi": "",
          "satuan_aset": "",
          "nilai_declining": "",
          "perbaikan": "",
          "stsasr": "",
          "nopolis": "",
          "nilai_revaluasi": "",
          "nik": "",
          "nama_pejabat": "",
          "sbb_aset": "",
          "sbb_penyusutan": "",
          "sbb_biaya_penyusutan": "",
          "sbb_rugi_revaluasi": "",
          "sbb_laba_revaluasi": "",
          "sbb_rugi_jual": "",
          "sbb_laba_jual": "",
          "sbb_biaya_perbaikan": ""
        },
      ],
    },
    {
      "kode_kelompok": "EK",
      "nama_kelompok": "ELEKTRONIK",
      "item": [
        {
          "kdaset": "100004",
          "ket": "MACBOOK M3 2023 COREi5 16GB 512 SSD",
          "kode_kelompok": "EK",
          "nama_kelompok": "ELEKTRONIK",
          "kode_golongan": "003",
          "nama_golongan": "Elektronik",
          "nodok_beli": "10000105",
          "tgl_beli": "2025-03-01",
          "tgl_terima": "2025-03-07",
          "habeli": "34500000",
          "disc": "0",
          "biaya": "0",
          "haper": "34500000",
          "nilai_residu": "1",
          "ppn_beli": "0",
          "tgl_jual": "",
          "nodok_jual": "",
          "hajual": "",
          "ppn_jual": "",
          "margin": "",
          "kode_pt": "",
          "kode_kantor": "",
          "kode_induk": "",
          "lokasi": "",
          "kota": "",
          "masasusut": "10",
          "bln_mulai_susut": "2025-12-01",
          "kdkondisi": "",
          "kondisi": "",
          "satuan_aset": "",
          "nilai_declining": "",
          "perbaikan": "",
          "stsasr": "",
          "nopolis": "",
          "nilai_revaluasi": "",
          "nik": "",
          "nama_pejabat": "",
          "sbb_aset": "",
          "sbb_penyusutan": "",
          "sbb_biaya_penyusutan": "",
          "sbb_rugi_revaluasi": "",
          "sbb_laba_revaluasi": "",
          "sbb_rugi_jual": "",
          "sbb_laba_jual": "",
          "sbb_biaya_perbaikan": ""
        },
      ],
    },
  ];
}
