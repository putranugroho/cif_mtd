import 'dart:convert';
import 'dart:io';

import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';

class KasKecilNotifier extends ChangeNotifier {
  final BuildContext context;

  KasKecilNotifier({required this.context}) {
    // for (Map<String, dynamic> i in coa) {
    //   listCoa.add(CoaModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in data) {
    //   listData.add(TransaksiModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in ao) {
    //   listAo.add(AoModel.fromJson(i));
    // }
    // for (Map<String, dynamic> i in json) {
    //   listKodeTransaksi.add(SetupTransModel.fromJson(i));
    // }
    getSetupTrans();
    getInqueryAll();
    notifyListeners();
  }

  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nosbbdeb.text = value.namaSbb;
    namaSbbDeb.text = value.nosbb;
    notifyListeners();
  }

  TextEditingController namaSbbCre = TextEditingController();
  TextEditingController namaSbbDeb = TextEditingController();
  pilihAkunCre(InqueryGlModel value) {
    inqueryGlModelcre = value;
    nossbcre.text = value.namaSbb;
    namaSbbCre.text = value.nosbb;
    notifyListeners();
  }

  Future getInqueryAll() async {
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccB(value['data']);
        list =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        notifyListeners();
      }
    });
  }

  TextEditingController namaTransaksi = TextEditingController();
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

  InqueryGlModel? inqueryGlModeldeb;
  InqueryGlModel? inqueryGlModelcre;
  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
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
                  model.namaSbb.toLowerCase().contains(query.toLowerCase()))
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

  var isLoading = true;
  Future getSetupTrans() async {
    isLoading = true;
    listData.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getSetupTrans(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listData.add(SetupTransModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<InqueryGlModel> list = [];

  List<String> listMetodeKas = [
    "Pengeluaran",
    "Pemasukan",
  ];
  String? metode = "Pengeluaran";
  pilihMetode(String value) {
    metode = value;
    notifyListeners();
  }

  confirmPrint() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog();
        });
  }

  DateTime? tglBackDate = DateTime.now();
  Future tanggalBackDate() async {
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
      tglBackDate = pickedendDate;
      tglBackDatetext.text = DateFormat("dd-MMM-yyyy")
          .format(DateTime.parse(pickedendDate.toString()));
      notifyListeners();
    }
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

  final keyForm = GlobalKey<FormState>();

  cek() {
    if (keyForm.currentState!.validate()) {}
  }

  bool cancel = true;
  cancelKode() async {
    cancel = true;
    inqueryGlModelcre = null;
    inqueryGlModelcre = null;
    setupTransModel = null;
    namaTransaksi.clear();
    namaSbbCre.clear();
    nossbcre.clear();
    nosbbdeb.clear();
    namaSbbDeb.clear();
    notifyListeners();
  }

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController tglBackDatetext = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController nomorRef = TextEditingController();

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  bool backDate = false;
  gantibackDate() {
    backDate = !backDate;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<SetupTransModel> listData = [];
  SetupTransModel? setupTransModel;
  pilihTransModel(SetupTransModel value) {
    setupTransModel = value;
    namaTransaksi.text = setupTransModel!.kdTrans;
    inqueryGlModeldeb =
        listGl.where((e) => e.nosbb == setupTransModel!.glDeb).isEmpty
            ? null
            : listGl.where((e) => e.nosbb == setupTransModel!.glDeb).first;
    inqueryGlModelcre =
        listGl.where((e) => e.nosbb == setupTransModel!.glKre).isEmpty
            ? null
            : listGl.where((e) => e.nosbb == setupTransModel!.glKre).first;
    nosbbdeb.text = setupTransModel!.namaDeb;
    namaSbbDeb.text = setupTransModel!.glDeb;
    nossbcre.text = setupTransModel!.namaKre;
    namaSbbCre.text = setupTransModel!.glKre;
    cancel = false;
    notifyListeners();
  }
}
