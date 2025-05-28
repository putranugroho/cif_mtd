import 'dart:convert';
import 'dart:math';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/foundation.dart';
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

  List<KaryawanModel> listKaryawan = [];
  TextEditingController namaKaryawan = TextEditingController();
  TextEditingController nikKaryawan = TextEditingController();
  KaryawanModel? karyawanModel;
  piliAkunKaryawan(KaryawanModel value) {
    karyawanModel = value;
    namaKaryawan.text = karyawanModel!.namaLengkap;
    nikKaryawan.text = karyawanModel!.nik;
    notifyListeners();
  }

  Future<List<KaryawanModel>> getInqKaryawan(String query) async {
    if (query.isNotEmpty && query.length > 2 && editData == false) {
      listKaryawan.clear();
      notifyListeners();
      var data = {"nama": query};
      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.cariKaryawan(),
          jsonEncode(data),
        );

        for (Map<String, dynamic> i in response) {
          listKaryawan.add(KaryawanModel.fromJson(i));
        }
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print("Error: $e");
        }
      } finally {
        notifyListeners();
      }
    } else {
      listKaryawan.clear(); // clear on short query
    }

    return listKaryawan;
  }

  var backdate = false;
  gantiBackdate() {
    backdate = !backdate;
    notifyListeners();
  }

  UsersModel? users;
  var editData = false;
  var limitAkses = false;
  gantilimitakses() {
    if (otorisasi) {
      informationDialog(context, "warning",
          "Otorisasi Aktif, tidak bisa memberikan akses limit transaksi");
    } else {
      limitAkses = !limitAkses;
    }
    notifyListeners();
  }

  TextEditingController maksimalTrans = TextEditingController();
  edit(String id) {
    listAddHariKerja.clear();
    notifyListeners();
    users = listData.where((e) => e.id == int.parse(id)).first;
    dialog = true;
    editData = true;
    kantorModel =
        listKantor.where((e) => e.kodeKantor == users!.kodeKantor).first;
    namaKaryawan.text = users!.namauser;
    nikKaryawan.text = users!.empId;
    userid.text = users!.userid;
    limitAkses = users!.limitAkses == "Y" ? true : false;
    maksimalTrans.text =
        "Rp ${FormatCurrency.oCcyDecimal.format(double.parse(users!.maksimalTransaksi))}";
    pass.text = users!.pass;
    namauser.text = users!.namauser;
    tglexp.text = users!.tglexp;
    minotor.text = users!.minOtor == ""
        ? ""
        : FormatCurrency.oCcy
            .format(int.parse(users!.minOtor))
            .replaceAll(".", ",");
    maxotor.text = users!.maxOtor == ""
        ? ""
        : FormatCurrency.oCcy
            .format(int.parse(users!.maxOtor))
            .replaceAll(".", ",");
    aksesKasir = users!.aksesKasir == "Y" ? true : false;
    bedaKantor = users!.bedaKantor == "Y" ? true : false;
    levelUser = listUsers.where((e) => e.idLevel == users!.lvluser).first;
    otorisasi =
        users!.levelOtor == "null" || users!.levelOtor == "" ? false : true;
    levelSelected =
        users!.levelOtor == "null" || users!.levelOtor == "" ? false : true;
    backdate = users!.backDate == "Y" ? true : false;
    levelOtor = users!.levelOtor == "null" || users!.levelOtor == ""
        ? ""
        : listLevelOtor.where((e) => e == users!.levelOtor).first;
    aktivasilogin = users!.aktivasi == "Y" ? true : false;
    inqueryGlModel = users!.sbbKasir == ""
        ? null
        : listGl.where((e) => e.nosbb == users!.sbbKasir).first;
    nossbb.text = users!.sbbKasir == "" ? "" : inqueryGlModel!.nosbb;
    namasbb.text = users!.sbbKasir == "" ? "" : inqueryGlModel!.namaSbb;
    for (var i = 0; i < users!.shifts.length; i++) {
      AktivasiModel? aktivasiModel = listHariKerja
          .where((e) => e.kdAktivasi == users!.shifts[i].kdKelompok)
          .first;
      listAddHariKerja.add(aktivasiModel);
    }

    notifyListeners();
  }

  InqueryGlModel? inqueryGlModel;
  // var aksesKasir = false;
  final keyForm = GlobalKey<FormState>();
  cek() {
    final random = Random();
    int randomNumber = 1000 + random.nextInt(8999);
    if (keyForm.currentState!.validate()) {
      if (listAddHariKerja.isNotEmpty) {
        if (editData) {
          List<Map<String, dynamic>> listTmp = [];
          for (var i = 0; i < listAddHariKerja.length; i++) {
            listTmp.add({
              "id_users": users!.id,
              "kd_kelompok": "${listAddHariKerja[i].kdAktivasi}",
              "nama_kelompok": "${listAddHariKerja[i].nmAktivasi}",
              "hari": "${listAddHariKerja[i].hari}",
              "ke": "${i + 1}",
              "jam_mulai": "${listAddHariKerja[i].jamMulai}",
              "jam_selesai": "${listAddHariKerja[i].jamSelesai}",
              "status": "AKTIF",
            });
          }
          print("JSON TMP ${jsonEncode(listTmp)}");
          notifyListeners();
          DialogCustom().showLoading(context);
          var data = {
            "id": users!.id,
            "userid": "${userid.text}",
            "batch": "$randomNumber",
            "emp_id":
                "${karyawanModel == null ? nikKaryawan.text : karyawanModel!.nik}",
            "pass": "${pass.text}",
            "namauser":
                "${karyawanModel == null ? namaKaryawan.text : karyawanModel!.namaLengkap}",
            "kode_pt": "${kantorModel == null ? "001" : kantorModel!.kodePt}",
            "kode_kantor":
                "${kantorModel == null ? "001" : kantorModel!.kodeKantor}",
            "kode_induk":
                "${kantorModel == null ? "001" : kantorModel!.kodeInduk}",
            "tglexp": "${tglexp.text}",
            "lvluser": "${levelUser!.idLevel}",
            "terminal_id": "",
            "akses_kasir": "${aksesKasir ? "Y" : "N"}",
            "sbb_kasir":
                "${inqueryGlModel == null ? "" : inqueryGlModel!.nosbb}",
            "nama_sbb":
                "${inqueryGlModel == null ? "" : inqueryGlModel!.namaSbb}",
            "fhoto_1": "",
            "fhoto_2": "",
            "fhoto_3": "",
            "limit_akses": "${limitAkses ? "Y" : "N"}",
            "maksimal_transaksi":
                "${maksimalTrans.text.replaceAll("Rp ", "").replaceAll(".", "").replaceAll(",", ".")}",
            "level_otor": "${levelOtor}",
            "aktivasi": "${aktivasilogin ? "Y" : "N"}",
            "beda_kantor": "${bedaKantor ? "Y" : "N"}",
            "back_date": "${backdate ? "Y" : "N"}",
            "min_otor": "${minotor.text.trim().replaceAll(",", "")}",
            "max_otor": "${maxotor.text.trim().replaceAll(",", "")}",
            "shifts": listTmp
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
          List<Map<String, dynamic>> listTmp = [];
          for (var i = 0; i < listAddHariKerja.length; i++) {
            listTmp.add({
              "kd_kelompok": "${listAddHariKerja[i].kdAktivasi}",
              "nama_kelompok": "${listAddHariKerja[i].nmAktivasi}",
              "hari": "${listAddHariKerja[i].hari}",
              "ke": "${i + 1}",
              "jam_mulai": "${listAddHariKerja[i].jamMulai}",
              "jam_selesai": "${listAddHariKerja[i].jamSelesai}",
              "status": "AKTIF",
            });
          }
          print("JSON TMP ${jsonEncode(listTmp)}");
          var data = {
            "userid": "${userid.text}",
            "pass": "${pass.text}",
            "batch": "$randomNumber",
            "emp_id": "${karyawanModel!.nik}",
            "namauser": "${karyawanModel!.namaLengkap}",
            "limit_akses": "${limitAkses ? "Y" : "N"}",
            "maksimal_transaksi":
                "${maksimalTrans.text.replaceAll("Rp ", "").replaceAll(".", "").replaceAll(",", ".")}",
            "kode_pt": "${kantorModel == null ? "001" : kantorModel!.kodePt}",
            "kode_kantor":
                "${kantorModel == null ? "001" : kantorModel!.kodeKantor}",
            "kode_induk":
                "${kantorModel == null ? "001" : kantorModel!.kodeInduk}",
            "tglexp": "${tglexp.text}",
            "lvluser": "${levelUser!.idLevel}",
            "terminal_id": "",
            "akses_kasir": "${aksesKasir ? "Y" : "N"}",
            "sbb_kasir":
                "${inqueryGlModel == null ? "" : inqueryGlModel!.nosbb}",
            "nama_sbb":
                "${inqueryGlModel == null ? "" : inqueryGlModel!.namaSbb}",
            "fhoto_1": "",
            "fhoto_2": "",
            "fhoto_3": "",
            "level_otor": "${levelOtor}",
            "aktivasi": "${aktivasilogin ? "Y" : "N"}",
            "back_date": "${backdate ? "Y" : "N"}",
            "beda_kantor": "${bedaKantor ? "Y" : "N"}",
            "min_otor": "${minotor.text.trim().replaceAll(",", "")}",
            "max_otor": "${maxotor.text.trim().replaceAll(",", "")}",
            "shifts": listTmp
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
    } else {
      informationDialog(context, "Warning", "Hari kerja tidak boleh kosong");
    }
  }

  confirm() async {}

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
  List<AktivasiModel> listAddHariKerja = [];
  addHariKerja(AktivasiModel value) {
    if (listAddHariKerja.isEmpty) {
      listAddHariKerja.add(value);
    } else {
      if (listAddHariKerja
          .where((e) => e.kdAktivasi == value.kdAktivasi)
          .isNotEmpty) {
        listAddHariKerja.remove(value);
      } else {
        listAddHariKerja.add(value);
      }
    }
    notifyListeners();
  }

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
    clear();
    editData = false;
    dialog = true;
    tglexp.text = DateFormat("y-MM-dd").format(DateTime(
        int.parse(DateFormat('y').format(DateTime.now())) + 1,
        int.parse(DateFormat('MM').format(
          DateTime.now(),
        )),
        int.parse(DateFormat('dd').format(
          DateTime.now(),
        ))));
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  clear() {
    dialog = false;
    editData = false;
    aktivasiModel = null;
    levelUser = null;
    otorisasi = false;
    kantorModel = null;
    namaKaryawan.clear();
    nikKaryawan.clear();
    userid.clear();
    pass.clear();
    namauser.clear();
    tglexp.clear();
    levelOtor = null;
    bedaKantor = false;
    aksesKasir = false;
    backdate = false;
    minotor.clear();
    maxotor.clear();
    listAddHariKerja.clear();
    notifyListeners();
  }

  TextEditingController userid = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController namauser = TextEditingController();
  TextEditingController tglexp = TextEditingController();
  TextEditingController minotor = TextEditingController();
  TextEditingController maxotor = TextEditingController();

  LevelUser? levelUser;
  pilihLevel(LevelUser value) {
    levelUser = value;
    notifyListeners();
  }

  DateTime? tglBuka = DateTime.now();
  Future<List<InqueryGlModel>> getInquery(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      listGl.clear();
      notifyListeners();

      var data = {"kode_pt": "001"};

      try {
        final response = await Setuprepository.setup(
          token,
          NetworkURL.getInqueryGL(),
          jsonEncode(data),
        );

        if (response['status'].toString().toLowerCase().contains("success")) {
          final List<Map<String, dynamic>> jnsAccBItems =
              extractJnsAccB(response['data']);
          listGl = jnsAccBItems
              .map((item) => InqueryGlModel.fromJson(item))
              .where((model) =>
                  model.nosbb.toLowerCase().contains(query.toLowerCase()) ||
                  model.namaSbb.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        notifyListeners();
      }
    } else {
      listGl.clear(); // clear on short query
    }

    return listGl;
  }

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
              )) +
              1),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
                DateTime.now(),
              )) +
              1),
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

  bool otorisasi = false;
  gantiotorisasi() {
    clearOtor();
    if (limitAkses) {
      informationDialog(context, "Warning",
          "Limit transaksi aktif, tidak bisa memberikan otorisasi");
    } else {
      otorisasi = !otorisasi;
    }
    notifyListeners();
  }

  bool aktivasilogin = true;
  gantiAktivasi() {
    clearOtor();
    aktivasilogin = !aktivasilogin;
    notifyListeners();
  }

  clearOtor() {
    levelOtor = null;
    levelSelected = false;
    minotor.clear();
    maxotor.clear();
    dropdownKey = UniqueKey();
    // print("clearOtor called. New key: $dropdownKey");
    notifyListeners();
  }

  Key dropdownKey = UniqueKey();

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

  List<CoaModel> listCoa = [];

  TextEditingController namasbb = TextEditingController();
  TextEditingController nossbb = TextEditingController();
  CoaModel? sbbAset;
  pilihSbbAset(InqueryGlModel value) {
    inqueryGlModel = value;
    nossbb.text = value.nosbb;

    namasbb.text = value.namaSbb;
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

  List<KantorModel> listKantor = [];
  Future getKantor() async {
    listKantor.clear();
    isLoading = true;
    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.getKantor(token, NetworkURL.getKantor(), jsonEncode(data))
        .then((value) {
      if (value['status'] == "Success") {
        for (Map<String, dynamic> i in value['data']) {
          listKantor.add(KantorModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  KantorModel? kantorModel;
  pilihKantor(KantorModel value) {
    kantorModel = value;
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
}
