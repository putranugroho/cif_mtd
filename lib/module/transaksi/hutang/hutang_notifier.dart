import 'package:flutter/material.dart';

import '../../../models/index.dart';

class HutangNotifier extends ChangeNotifier {
  final BuildContext context;

  HutangNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(PiutangHutangModel.fromJson(i));
    }
    for (Map<String, dynamic> i in json) {
      listCustomer.add(CustomerSupplierModel.fromJson(i));
    }
    for (Map<String, dynamic> i in ao) {
      listAo.add(AoModel.fromJson(i));
    }
    for (Map<String, dynamic> i in jsonKode) {
      listData.add(SetupTransModel.fromJson(i));
    }
    notifyListeners();
  }
  var dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<TextEditingController> listTglJatuhTempo = [];
  List<TextEditingController> listNominal = [];
  addJatuhTempo() {
    listTglJatuhTempo.add(TextEditingController());
    listNominal.add(TextEditingController());
    notifyListeners();
  }

  var jenis = false;
  gantijenis() {
    jenis = !jenis;
    notifyListeners();
  }

  remove(int index) {
    listTglJatuhTempo.removeAt(index);
    listNominal.removeAt(index);
    notifyListeners();
  }

  List<PiutangHutangModel> list = [];
  List<Map<String, dynamic>> data = [
    {
      "no_invoice": "INV10000001",
      "jns_invoice": "1",
      "no_sif": "100011",
      "nm_sif": "PT GLOBAL TEKNOLOGI INDONESIA",
      "tgl_invoice": "2025-04-07",
      "nilai_invoice": "120000000",
      "ppn": "0",
      "pph": "0",
      "tgl_jt_tempo": "2025-04-30",
      "bertahap": "N",
      "jumlah_tahap": "",
      "tgl_bayar": "",
      "nilai_bayar": "",
      "status_invoice": "A",
      "kode_pt": "001",
      "kode_kantor": "10011",
      "kode_induk": "",
      "kode_ao": ""
    },
    {
      "no_invoice": "INV10000002",
      "jns_invoice": "2",
      "no_sif": "100011",
      "nm_sif": "PT GLOBAL TEKNOLOGI INDONESIA",
      "tgl_invoice": "2025-04-07",
      "nilai_invoice": "60000000",
      "ppn": "0",
      "pph": "0",
      "tgl_jt_tempo": "2025-04-30",
      "bertahap": "N",
      "jumlah_tahap": "",
      "tgl_bayar": "",
      "nilai_bayar": "",
      "status_invoice": "A",
      "kode_pt": "001",
      "kode_kantor": "10011",
      "kode_induk": "",
      "kode_ao": ""
    }
  ];

  List<CustomerSupplierModel> listCustomer = [];
  CustomerSupplierModel? customerSupplierModel;
  pilihCustomer(CustomerSupplierModel value) {
    customerSupplierModel = value;
    notifyListeners();
  }

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

  List<AoModel> listAo = [];
  AoModel? aoModel;

  pilihAo(AoModel value) {
    aoModel = value;
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

  List<SetupTransModel> listData = [];
  SetupTransModel? setupTransModel;
  pilihSetupTransaksi(SetupTransModel value) {
    setupTransModel = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> jsonKode = [
    {
      "kd_trans": "1222",
      "nama_trans": "SETORAN KLIRING/PEMINDAHAN",
      "gl_deb": "10001002",
      "nama_deb": "Kas Kecil",
      "gl_kre": "10001001",
      "nama_kre": "Kas Besar",
      "modul": "backoffice",
    },
    {
      "kd_trans": "1288",
      "nama_trans": "DEBET SBB CREDIT TABUNGAN",
      "gl_deb": "10001002",
      "nama_deb": "Kas Kecil",
      "gl_kre": "10001001",
      "nama_kre": "Kas Besar",
      "modul": "backoffice",
    },
    {
      "kd_trans": "2100",
      "nama_trans": "BIAYA - BIAYA",
      "gl_deb": "10001002",
      "nama_deb": "Kas Kecil",
      "gl_kre": "10001001",
      "nama_kre": "Kas Besar",
      "modul": "backoffice",
    },
  ];
}
