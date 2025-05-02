import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../network/network.dart';
import '../../../utils/dialog_loading.dart';
import '../../../utils/informationdialog.dart';

class UsersNotifier extends ChangeNotifier {
  final BuildContext context;

  UsersNotifier({required this.context}) {
    getAktivasi();
    getInqueryAll();
    getKantor();
    getLevelUsers();
    notifyListeners();
  }

  UsersModel? users;
  var editData = false;
  edit(String id) {
    users = listData.where((e) => e.id == int.parse(id)).first;
    notifyListeners();
  }

  InqueryGlModel? inqueryGlModel;
  // var aksesKasir = false;
  final keyForm = GlobalKey<FormState>();
  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": users!.id,
          "userid": "${userid.text}",
          "pass": "${pass.text}",
          "namauser": "${namauser.text}",
          "kd_aktivasi": "${aktivasiModel!.kdAktivasi}",
          "kode_pt": "${kantor!.kodePt}",
          "kode_kantor": "${kantor!.kodeKantor}",
          "kode_induk": "${kantor!.kodeInduk}",
          "tglexp": "${tglexp.text}",
          "lvluser": "${levelUser!.idLevel}",
          "terminal_id": "",
          "akses_kasir": "${aksesKasir ? "N" : "Y"}",
          "sbb_kasir": "${inqueryGlModel!.nosbb}",
          "nama_sbb": "${inqueryGlModel!.namaSbb}",
          "fhoto_1": "",
          "fhoto_2": "",
          "fhoto_3": "",
          "level_otor": "${levelOtor}",
          "beda_kantor": "${bedaKantor ? "Y" : "N"}",
          "min_otor": "${minotor.text.trim().replaceAll(",", "")}",
          "max_otor": "${maxotor.text.trim().replaceAll(",", "")}",
        };
        Setuprepository.setup(token, NetworkURL.editusers(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            getUsers();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "userid": "${userid.text}",
          "pass": "${pass.text}",
          "namauser": "${namauser.text}",
          "kd_aktivasi": "${aktivasiModel!.kdAktivasi}",
          "kode_pt": "${kantor!.kodePt}",
          "kode_kantor": "${kantor!.kodeKantor}",
          "kode_induk": "${kantor!.kodeInduk}",
          "tglexp": "${tglexp.text}",
          "lvluser": "${levelUser!.idLevel}",
          "terminal_id": "",
          "akses_kasir": "${aksesKasir ? "N" : "Y"}",
          "sbb_kasir": "${inqueryGlModel!.nosbb}",
          "nama_sbb": "${inqueryGlModel!.namaSbb}",
          "fhoto_1": "",
          "fhoto_2": "",
          "fhoto_3": "",
          "level_otor": "${levelOtor}",
          "beda_kantor": "${bedaKantor ? "Y" : "N"}",
          "min_otor": "${minotor.text.trim().replaceAll(",", "")}",
          "max_otor": "${maxotor.text.trim().replaceAll(",", "")}",
        };
        Setuprepository.setup(token, NetworkURL.addusers(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            informationDialog(context, "Information", value['message']);
            getUsers();
            clear();
            notifyListeners();
          } else {
            informationDialog(context, "Warning", value['message'][0]);
          }
        });
      }
    }
  }

  List<LevelUser> listUsers = [];
  Future getLevelUsers() async {
    isLoading = true;
    listUsers.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getLevelUsers(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listUsers.add(LevelUser.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<AktivasiModel> listHariKerja = [];
  AktivasiModel? aktivasiModel;
  pilihHariKerja(AktivasiModel value) {
    aktivasiModel = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> extractJnsAccB(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];

    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          if (item['jns_acc'] == 'C') {
            result.add(item);
          }

          if (item.containsKey('items') && item['items'] is List) {
            traverse(item['items']);
          }
        }
      }
    }

    traverse(rawData);
    return result;
  }

  List<InqueryGlModel> listGl = [];
  Future getInqueryAll() async {
    listGl.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccB(value['data']);
        listGl =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        notifyListeners();
      }
    });
  }

  var isLoading = true;
  Future getAktivasi() async {
    isLoading = true;
    listHariKerja.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getAktivasi(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listHariKerja.add(AktivasiModel.fromJson(i));
        }
        getUsers();
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  getUsers() async {
    isLoading = true;
    listData.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getusers(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listData.add(UsersModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
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

  clear() {
    dialog = false;
    editData = false;
    userid.clear();
    pass.clear();
    namauser.clear();
    tglexp.clear();
    levelotor.clear();
    minotor.clear();
    maxotor.clear();
    notifyListeners();
  }

  TextEditingController userid = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController namauser = TextEditingController();
  TextEditingController tglexp = TextEditingController();
  TextEditingController levelotor = TextEditingController();
  TextEditingController minotor = TextEditingController();
  TextEditingController maxotor = TextEditingController();

  LevelUser? levelUser;
  pilihLevel(LevelUser value) {
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

  var levelSelected = false;
  pilihLevelOtor(String value) {
    levelSelected = true;
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

  pilihKantor(KantorModel value) {
    kantor = value;
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

  List<KantorModel> list = [];
  Future getKantor() async {
    list.clear();
    isLoading = true;
    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.getKantor(token, NetworkURL.getKantor(), jsonEncode(data))
        .then((value) {
      if (value['status'] == "Success") {
        for (Map<String, dynamic> i in value['data']) {
          list.add(KantorModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  KantorModel? kantor;

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
}
