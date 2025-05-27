import 'dart:convert';
import 'dart:io';

import 'package:accounting/models/index.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/utils/format_currency.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';

class BayarDimukaNotifier extends ChangeNotifier {
  final BuildContext context;

  BayarDimukaNotifier({required this.context}) {
    // for (Map<String, dynamic> i in json) {
    //   listTransaksi.add(TransaksiModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in data) {
    //   listData.add(TransaksiBayarPendapatanDimukaModel.fromJson(i));
    // }

    getProfile();
    notifyListeners();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getInqueryAll();

      notifyListeners();
    });
  }

  List<Map<String, dynamic>> extractJnsAccB(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];

    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          if (item['jns_acc'] == 'C' &&
              item['type_posting'] == "Y" &&
              item['gol_acc'] == "4") {
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

  List<Map<String, dynamic>> extractJnsAccBb(List<dynamic> rawData) {
    List<Map<String, dynamic>> result = [];

    void traverse(List<dynamic> items) {
      for (var item in items) {
        if (item is Map<String, dynamic>) {
          if (item['jns_acc'] == 'C' &&
              item['type_posting'] == "Y" &&
              item['akun_perantara'] == "Y") {
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

  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nosbbdeb.text = value.namaSbb;
    namaSbbDeb.text = value.nosbb;
    notifyListeners();
  }

  pilihAkun(InqueryGlModel value) {
    inqueryGlModelcre = value;
    semua = false;
    nosbb.text = value.namaSbb;
    getTransaksi();
    notifyListeners();
  }

  Future getInqueryAll() async {
    listGlAll.clear();
    notifyListeners();
    var data = {"kode_pt": "${users!.kodePt}"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccBb(value['data']);
        listGlAll =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        getTransaksi();
        notifyListeners();
      }
    });
  }

  InqueryGlModel? inqueryGlModeldeb;
  InqueryGlModel? inqueryGlModelcre;
  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
  List<InqueryGlModel> listGlAll = [];
  TextEditingController nosbbdeb = TextEditingController();
  TextEditingController nossbcre = TextEditingController();
  Future<List<InqueryGlModel>> getInquery(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
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
                  model.namaSbb.toLowerCase().contains(query.toLowerCase()) &&
                      model.typePosting == "Y")
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        isLoadingInquery = false;
        notifyListeners();
      }
    } else {
      listGl.clear(); // clear on short query
    }

    return listGl;
  }

  TextEditingController nosbb = TextEditingController();

  Future<List<InqueryGlModel>> getIn(String query) async {
    if (query.isNotEmpty && query.length > 2) {
      isLoadingInquery = true;
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
              extractJnsAccBb(response['data']);
          listGl = jnsAccBItems
              .map((item) => InqueryGlModel.fromJson(item))
              .where((model) =>
                  model.nosbb.toLowerCase().contains(query.toLowerCase()) ||
                  model.namaSbb.toLowerCase().contains(query.toLowerCase()) &&
                      model.typePosting == "Y")
              .toList();
        }
        notifyListeners();
      } catch (e) {
        print("Error: $e");
      } finally {
        isLoadingInquery = false;
        notifyListeners();
      }
    } else {
      listGl.clear(); // clear on short query
    }

    return listGl;
  }

  var semua = false;
  gantisemua() {
    semua = !semua;
    if (semua) {
      inqueryGlModelcre = null;
      nosbb.clear();
    }
    notifyListeners();
  }

  TextEditingController namaSbbDeb = TextEditingController();
  TextEditingController keteranganBaru = TextEditingController();
  TextEditingController namaSbbCre = TextEditingController();

  var isLoadingData = true;
  List<TransaksiPendModel> listTransaksi = [];
  List<TransaksiPendModel> listTransaksiAdd = [];
  Future getTransaksi() async {
    isLoadingData = true;
    listTransaksi.clear();
    listTransaksiAdd.clear();
    notifyListeners();
    var data = {
      "kode_pt": "${users!.kodePt}",
    };
    Setuprepository.setup(token, NetworkURL.view(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksi.add(TransaksiPendModel.fromJson(i));
        }
        if (listTransaksi.isNotEmpty) {
          if (jenis == "BAYAR DIMUKA") {
            for (var i = 0; i < listGlAll.length; i++) {
              listTransaksiAdd.addAll(listTransaksi
                  .where((e) =>
                      e.cracc == listGlAll[i].nosbb && e.status == "COMPLETED")
                  .toList());
            }
            notifyListeners();
          } else {
            for (var i = 0; i < listGlAll.length; i++) {
              listTransaksiAdd.addAll(listTransaksi
                  .where((e) =>
                      e.dracc == listGlAll[i].nosbb && e.status == "COMPLETED")
                  .toList());
            }
            notifyListeners();
          }
        }
        isLoadingData = false;
        notifyListeners();
      } else {
        isLoadingData = false;
        notifyListeners();
      }
    });
  }

  confirmPrint() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog();
        });
  }

  DateTime? tglTransaksi;
  Future pilihTanggalBuka() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
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
      tglTransaksi = pickedendDate;
      tglTransaksiText.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController nomorRef = TextEditingController();

  bool dialog = false;
  tambah() {
    dialog = true;
    referensi = false;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    referensi = false;
    notifyListeners();
  }

  kembali() {
    dialog = true;
    referensi = false;
    notifyListeners();
  }

  List<TransaksiBayarPendapatanDimukaModel> listData = [];
  List<Map<String, dynamic>> data = [
    {
      "no_transaksi": "TR0000001",
      "keterangan": "Sewa Gedung ",
      "berapa": "12",
      "tanggal_transaksi": "2024-04-16",
      "dimuka": "N",
      "no_referensi": "RFFF000001",
      "nominal": "120000000",
      "status": "A",
    }
  ];

  TextEditingController keterangan = TextEditingController();
  TextEditingController berapakali = TextEditingController();
  TextEditingController nomiinal = TextEditingController();
  TextEditingController noakun = TextEditingController();
  TextEditingController noakundebet = TextEditingController();
  TextEditingController namaakun = TextEditingController();
  TextEditingController namaakundebet = TextEditingController();

  TextEditingController tanggaltransaksi = TextEditingController();

  List<String> listJenis = [
    "BAYAR DIMUKA",
    "PENDAPATAN DIMUKA",
  ];
  String? jenis = "BAYAR DIMUKA";
  pilihjenis(String value) {
    jenis = value;
    nosbb.clear();
    inqueryGlModelcre = null;
    getTransaksi();
    notifyListeners();
  }

  bool dimuka = false;
  bool referensi = false;
  pilihReferensi() {
    referensi = true;
    dialog = false;
    notifyListeners();
  }

  gantidimuka() {
    dimuka = !dimuka;
    notifyListeners();
  }

  bool cariTrans = false;
  pilihCariTransaksi(bool value) {
    cariTrans = value;
    notifyListeners();
  }

  DateTime? tglVal = DateTime.now();
  Future tanggalValuta() async {
    var pickedendDate = (await showDatePicker(
      context: context,
      initialDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
                DateTime.now(),
              )) -
              1),
      firstDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())) - 10,
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
            DateTime.now(),
          ))),
      lastDate: DateTime(
          int.parse(DateFormat('y').format(DateTime.now())),
          int.parse(DateFormat('MM').format(
            DateTime.now(),
          )),
          int.parse(DateFormat('dd').format(
                DateTime.now(),
              )) -
              1),
    ));
    if (pickedendDate != null) {
      tglVal = pickedendDate;
      tglValuta.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
  }

  DateTime tglAwal = DateTime.now();
  DateTime tglAkhir = DateTime.now();
  changeDate() async {
    final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate:
            DateTime(int.parse(DateFormat('yyyy').format(DateTime.now())) + 2));

    var tglSplit = picked.toString().split(" - ");

    String? tglAwalString;
    String? tglAkhirString;
    tglAwalString = DateFormat('y-MM-dd').format(DateTime.parse(tglSplit[0]));
    tglAkhirString = DateFormat('y-MM-dd').format(DateTime.parse(tglSplit[1]));

    tglAwal = DateTime.parse(tglAwalString);
    tglAkhir = DateTime.parse(tglAkhirString);

    periode.text =
        "${DateFormat('dd MMM y').format(tglAwal)} - ${DateFormat('dd MMM y').format(tglAkhir)}";

    notifyListeners();
  }

  bool cariDok = false;
  gantiCariDok() {
    cariDok = !cariDok;
    notifyListeners();
  }

  TextEditingController tglValuta = TextEditingController();
  TextEditingController periode = TextEditingController();

  TransaksiPendModel? transaksiModel;
  pilihTransaksi(TransaksiPendModel value) {
    transaksiModel = value;
    dialog = true;
    referensi = false;
    noakun.text = value.cracc;
    nomorDok.text = value.noDokumen;
    nomorRef.text = value.noRef;
    noakundebet.text = value.dracc;
    keterangan.text = value.keterangan;
    namaakun.text = value.namaCr;
    namaakundebet.text = value.namaDr;
    nominal.text = FormatCurrency.oCcyDecimal
        .format(double.parse(value.nominal))
        .replaceAll(".", ",")
        .replaceAll(".", ",");
    notifyListeners();
  }

  clear() {
    transaksiModel = null;
    noakun.clear();
    namaakun.clear();
    nominal.clear();
    notifyListeners();
  }
}
