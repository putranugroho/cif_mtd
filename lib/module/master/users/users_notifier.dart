import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UsersNotifier extends ChangeNotifier {
  final BuildContext context;

  UsersNotifier({required this.context}) {
    // for (Map<String, dynamic> i in menu) {
    //   listMenu.add(MenuModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in data) {
    //   listData.add(UsersModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in coa) {
    //   listCoa.add(CoaModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in hariKerja) {
    //   listHariKerja.add(AktivasiModel.fromJson(i));
    // }
    notifyListeners();
  }

  List<AktivasiModel> listHariKerja = [];
  AktivasiModel? aktivasiModel;
  pilihHariKerja(AktivasiModel value) {
    aktivasiModel = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> hariKerja = [
    {
      "kd_aktivasi": "100001",
      "nm_aktivasi": "Regu 1",
      "hari": "['Senin','Selasa','Rabu']",
      "jam_mulai": "10:00:00",
      "jam_selesai": "17:00:00"
    },
    {
      "kd_aktivasi": "100002",
      "nm_aktivasi": "Regu 2",
      "hari": "['Kamis','Jumat','Sabtu']",
      "jam_mulai": "08:00:00",
      "jam_selesai": "17:00:00"
    },
  ];

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  TextEditingController userid = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController namauser = TextEditingController();
  TextEditingController tglexp = TextEditingController();

  TextEditingController levelotor = TextEditingController();
  TextEditingController minotor = TextEditingController();
  TextEditingController maxotor = TextEditingController();

  String? levelUser;
  List<String> listLevelUsers = [
    "Administrator",
    "Supervisor",
    "User",
  ];

  pilihLevel(String value) {
    levelUser = value;
    notifyListeners();
  }

  DateTime? tglBuka = DateTime.now();

  Future pilihTanggalBuka() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) + 1,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      firstDate: DateTime(1950),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) + 10,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
    ));
    if (pickedendDate != null) {
      tglBuka = pickedendDate;
      tglexp.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  String? levelOtor;
  List<String> listLevelOtor = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ];

  pilihLevelOtor(String value) {
    levelOtor = value;
    notifyListeners();
  }

  bool aksesKasir = false;
  pilihAksesKasir(bool value) {
    aksesKasir = value;
    notifyListeners();
  }

  bool bedaKantor = false;
  pilihBedaKantor(bool value) {
    bedaKantor = value;
    notifyListeners();
  }

  List<CoaModel> listCoa = [];

  TextEditingController namaSbbAset = TextEditingController();
  CoaModel? sbbAset;
  pilihSbbAset(CoaModel value) {
    sbbAset = value;
    namaSbbAset.text = value.nosbb;
    notifyListeners();
  }

  List<MenuModel> listMenu = [];
  List<MenuModel> listMenuAdd = [];
  bool semua = false;
  pilihSemua() {
    semua = !semua;
    if (semua) {
      listMenuAdd.addAll(listMenu);
    } else {
      listMenuAdd.clear();
    }
    notifyListeners();
  }

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

  List<Map<String, dynamic>> menu = [
    {
      "modul": "SETUP",
      "menu": "SETUP",
      "submenu": "SETUP TRANSAKSI",
    },
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

  List<UsersModel> listData = [];
  List<Map<String, dynamic>> data = [
    {
      "userid": "edicybereye",
      "pass": "123123",
      "namauser": "Edi Kurniawan",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": "",
      "tglexp": "2025-12-30",
      "lvluser": "A",
      "terminal_id": "",
      "akses_kasir": "N",
      "sbb_kasir": "",
      "nama_sbb": "",
      "fhoto_1": "",
      "fhoto_2": "",
      "fhoto_3": "",
      "level_otor": "1",
      "beda_kantor": "Y",
      "min_otor": "10000000",
      "max_otor": "20000000"
    },
  ];

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
