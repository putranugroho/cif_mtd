import 'dart:io';

import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class GolonganAsetNotifier extends ChangeNotifier {
  final BuildContext context;

  GolonganAsetNotifier({required this.context}) {
    // for (Map<String, dynamic> i in json) {
    //   list.add(KelompokAsetModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in data) {
    //   listData.add(GolonganAsetModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in coa) {
    //   listCoa.add(CoaModel.fromJson(i));
    // }
    notifyListeners();
  }

  TextEditingController kode = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController masa = TextEditingController();
  TextEditingController nilai = TextEditingController();

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<KelompokAsetModel> list = [];
  KelompokAsetModel? kelompokAsetModel;
  pilihKelompokAset(KelompokAsetModel value) {
    kelompokAsetModel = value;
    notifyListeners();
  }

  List<GolonganAsetModel> listData = [];
  List<Map<String, dynamic>> data = [
    {
      "kode_golongan": "001",
      "nama_golongan": "Kendaraan",
      "masa_susut": "10",
      "nilai_declining": "",
      "sbb_aset": "100100000002",
      "sbb_penyusutan": "100100000002",
      "sbb_biaya_penyusutan": "100100000002",
      "sbb_rugi_revaluasi": "100100000002",
      "sbb_laba_revaluasi": "100100000002",
      "sbb_rugi_jual": "100100000002",
      "sbb_laba_jual": "100100000002",
      "sbb_biaya_perbaikan": "100100000002",
    },
  ];
  List<Map<String, dynamic>> json = [
    {
      "kode_kelompok": "1",
      "nama_kelompok": "TRANSPORTASI",
    },
    {
      "kode_kelompok": "2",
      "nama_kelompok": "BERGERAK",
    },
  ];

  List<CoaModel> listCoa = [];

  TextEditingController namaSbbAset = TextEditingController();
  CoaModel? sbbAset;
  pilihSbbAset(CoaModel value) {
    sbbAset = value;
    namaSbbAset.text = value.nosbb;
    notifyListeners();
  }

  TextEditingController masasusut = TextEditingController();
  TextEditingController namaSbbpenyusutan = TextEditingController();
  CoaModel? sbbpenyusutan;
  pilihSbbpenyusutan(CoaModel value) {
    sbbpenyusutan = value;
    namaSbbpenyusutan.text = value.nosbb;
    notifyListeners();
  }

  TextEditingController namasbbbiaya = TextEditingController();
  CoaModel? sbbbiaya;
  pilihsbbbiaya(CoaModel value) {
    sbbbiaya = value;
    namasbbbiaya.text = value.nosbb;
    notifyListeners();
  }

  TextEditingController namasbbrugirevaluasi = TextEditingController();
  CoaModel? sbbrugirevaluasi;
  pilihsbbrugirevaluasi(CoaModel value) {
    sbbrugirevaluasi = value;
    namasbbrugirevaluasi.text = value.nosbb;
    notifyListeners();
  }

  TextEditingController namasbblagarevaluasi = TextEditingController();
  CoaModel? sbblabarevaluasi;
  pilihsbblabarevaluasi(CoaModel value) {
    sbblabarevaluasi = value;
    namasbblagarevaluasi.text = value.nosbb;
    notifyListeners();
  }

  List<Map<String, dynamic>> coa = [
    {
      "gol_acc": "1",
      "jns_acc": "A",
      "nobb": "10000000",
      "nosbb": "10000000",
      "nama_sbb": "Kas",
      "type_posting": "N",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "B",
      "nobb": "10000000",
      "nosbb": "10001000",
      "nama_sbb": "Kas",
      "type_posting": "N",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "10001001",
      "nama_sbb": "Kas Besar",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "10001002",
      "nama_sbb": "Kas Kecil",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
    {
      "gol_acc": "1",
      "jns_acc": "C",
      "nobb": "10001000",
      "nosbb": "10001003",
      "nama_sbb": "Kas Transaksi",
      "type_posting": "Y",
      "sbb_khusus": "kas"
    },
  ];
}
