import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class SetupTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  SetupTransaksiNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(CoaModel.fromJson(i));
    }
    for (Map<String, dynamic> i in json) {
      listData.add(SetupTransModel.fromJson(i));
    }
    notifyListeners();
  }

  List<CoaModel> list = [];
  CoaModel? coaModelDeb;
  pilihDeb(CoaModel value) {
    coaModelDeb = value;
    namaSbbDeb.text = value.nosbb;
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

  TextEditingController kodeTransaksi = TextEditingController();
  TextEditingController namaTransaksi = TextEditingController();
  TextEditingController namaSbbDeb = TextEditingController();
  TextEditingController namaSbbCre = TextEditingController();

  CoaModel? coaModelCre;
  pilihCre(CoaModel value) {
    coaModelCre = value;
    namaSbbCre.text = value.nosbb;
    notifyListeners();
  }

  String? modul = "BACKOFFICE";
  gantimodul(String value) {
    modul = value;
    notifyListeners();
  }

  List<MenuModel> listMenu = [];
  List<MenuModel> listMenuAdd = [];

  pilihMenu(MenuModel value) {
    if (listMenuAdd.isEmpty) {
      listMenuAdd.add(value);
    } else {
      if (listMenuAdd.where((e) => e == value).isNotEmpty) {
        listMenuAdd.remove(value);
      } else {
        listMenuAdd.add(value);
      }
    }
    notifyListeners();
  }

  List<SetupTransModel> listData = [];
  List<Map<String, dynamic>> json = [
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
  List<Map<String, dynamic>> menu = [
    {
      "modul": "TRANSAKSI",
      "menu": "TRANSAKSI",
      "submenu": "SATU TRANSAKSI",
    },
    {
      "modul": "TRANSAKSI",
      "menu": "TRANSAKSI",
      "submenu": "BANYAK TRANSAKSI",
    },
    {
      "modul": "TRANSAKSI",
      "menu": "TRANSAKSI",
      "submenu": "PIUTANG",
    },
    {
      "modul": "TRANSAKSI",
      "menu": "TRANSAKSI",
      "submenu": "HUTANG",
    },
  ];

  List<Map<String, dynamic>> data = [
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
