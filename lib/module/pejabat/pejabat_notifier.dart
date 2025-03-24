import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class PejabatNotifier extends ChangeNotifier {
  final BuildContext context;

  PejabatNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      listKantor.add(KantorModel.fromJson(i));
    }
    for (Map<String, dynamic> i in json) {
      list.add(PejabatModel.fromJson(i));
    }
    for (Map<String, dynamic> i in jabatan) {
      listJabatan.add(JabatanModel.fromJson(i));
    }
    notifyListeners();
  }

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  TextEditingController nik = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController noHp = TextEditingController();

  List<Map<String, dynamic>> data = [
    {
      "kode_pt": "10001",
      "kode_kantor": "100011",
      "kode_induk": "",
      "nama_kantor": "PT TEGUH AMAN LESTARI ",
      "status_kantor": "P",
      "alamat": "Trasa Coworking Space",
      "kelurahan": "PROCOT",
      "kecamatan": "SLAWI",
      "kota": "KABUPATEN TEGAL",
      "provinsi": "JAWA TENGAH",
      "kode_pos": "52419",
      "telp": null,
      "fax": null
    }
  ];

  List<KantorModel> listKantor = [];
  List<PejabatModel> list = [];
  List<JabatanModel> listJabatan = [];
  JabatanModel? jabatanModel;
  KantorModel? kantorModel;
  pilihJabatan(JabatanModel value) {
    jabatanModel = value;
    notifyListeners();
  }

  pilihKantor(KantorModel value) {
    kantorModel = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> jabatan = [
    {
      "kode_jabatan": "0001",
      "nama_jabatan": "Direktur Utama",
      "lvl_jabatan": "2",
    },
    {
      "kode_jabatan": "0002",
      "nama_jabatan": "Komisaris",
      "lvl_jabatan": "1",
    },
    {
      "kode_jabatan": "0003",
      "nama_jabatan": "Direktur",
      "lvl_jabatan": "2",
    }
  ];
  List<Map<String, dynamic>> json = [
    {
      "kode_kantor": "10001",
      "kode_induk": "",
      "nik": "33281022078900004",
      "nama_pejabat": "Edi Kurniawan",
      "no_hp_pejabat": "085642990808",
      "kode_jabatan": "10001",
      "nama_jabatan": "Direktur Utama",
    },
    {
      "kode_kantor": "10001",
      "kode_induk": "",
      "nik": "33281022078900003",
      "nama_pejabat": "Iwan Setiawan",
      "no_hp_pejabat": "085642990807",
      "kode_jabatan": "10002",
      "nama_jabatan": "Komisaris",
    },
    {
      "kode_kantor": "10001",
      "kode_induk": "",
      "nik": "33281022078900002",
      "nama_pejabat": "Bambang Hari Nugroho",
      "no_hp_pejabat": "085642990806",
      "kode_jabatan": "10003",
      "nama_jabatan": "Direktur",
    },
  ];
}
