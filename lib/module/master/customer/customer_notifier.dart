import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class CustomerNotifier extends ChangeNotifier {
  final BuildContext context;

  CustomerNotifier({required this.context}) {
    for (Map<String, dynamic> i in json) {
      list.add(CustomerSupplierModel.fromJson(i));
    }
    for (Map<String, dynamic> i in ao) {
      listAo.add(AoModel.fromJson(i));
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

  TextEditingController noSif = TextEditingController();
  TextEditingController namaSif = TextEditingController();
  TextEditingController bidangUsaha = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController provinsi = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController kecamatan = TextEditingController();
  TextEditingController kodepos = TextEditingController();
  TextEditingController npwp = TextEditingController();
  TextEditingController kelurahan = TextEditingController();
  TextEditingController notelp = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController kontak1 = TextEditingController();
  TextEditingController hp1 = TextEditingController();
  TextEditingController email1 = TextEditingController();
  TextEditingController keterangan1 = TextEditingController();
  TextEditingController kontak2 = TextEditingController();
  TextEditingController hp2 = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController keterangan2 = TextEditingController();
  TextEditingController kontak3 = TextEditingController();
  TextEditingController hp3 = TextEditingController();
  TextEditingController email3 = TextEditingController();
  TextEditingController keterangan3 = TextEditingController();
  List<String> listGolCust = [
    "Customer",
    "Supplier",
    "Customer dan Supplier",
  ];
  String? golCust;
  pilihGolCust(String value) {
    golCust = value;
    notifyListeners();
  }

  bool pkp = false;
  pilihPkp(bool value) {
    pkp = value;
    notifyListeners();
  }

  List<AoModel> listAo = [];
  AoModel? aoModel;
  AoModel? aoModelKRedit;
  pilihAoModelDebet(AoModel value) {
    aoModel = value;
    notifyListeners();
  }

  pilihAoModelKredit(AoModel value) {
    aoModelKRedit = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> ao = [
    {
      "kd_ao": "100001",
      "nm_ao": "Account Officer 1",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": ""
    },
    {
      "kd_ao": "100002",
      "nm_ao": "Account Officer 2",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": ""
    },
    {
      "kd_ao": "100003",
      "nm_ao": "Marketing 1",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": ""
    },
  ];

  List<CustomerSupplierModel> list = [];
  List<Map<String, dynamic>> json = [
    {
      "no_sif": "100000011",
      "nm_sif": "PT Global Teknologi Indonesia",
      "gol_cust": "3",
      "bidang_usaha": "Teknologi",
      "alamat": "Jl. Randu No. 82",
      "kelurahan": "KAGOK",
      "kecamatan": "SLAWI",
      "kota": "KABUPATEN TEGAL",
      "provinsi": "JAWA TENGAH",
      "kdpos": "52419",
      "npwp": "2389013840980183",
      "pkp": "Y",
      "no_telp": "085642990808",
      "email": "gti@gmail.com",
      "kontak1": "Edi Kurniawan",
      "hp1": "085642990808",
      "email1": "edi.cybereye@gmail.com",
      "keterangan1": "Direktur Utama",
      "kontak2": "",
      "hp2": "",
      "email2": "",
      "keterangan2": "",
      "kontak3": "",
      "hp3": "",
      "email3": "",
      "keterangan3": ""
    }
  ];
}
