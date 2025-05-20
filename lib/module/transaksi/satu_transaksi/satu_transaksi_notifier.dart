import 'dart:convert';
import 'dart:io';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:accounting/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SatuTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  SatuTransaksiNotifier({required this.context}) {
    getSetupTrans();
    getAoMarketing();
    getInqueryAll();
    notifyListeners();
  }
  List<InqueryGlModel> list = [];
  List<AoModel> listAo = [];
  getAoMarketing() async {
    isLoading = true;
    listAo.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getAoMarketing(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listAo.add(AoModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
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

  TextEditingController namaSbbDeb = TextEditingController();
  TextEditingController namaSbbCre = TextEditingController();

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
    notifyListeners();
  }

  pilihAkunDeb(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nosbbdeb.text = value.namaSbb;
    namaSbbDeb.text = value.nosbb;
    notifyListeners();
  }

  pilihAkunCre(InqueryGlModel value) {
    inqueryGlModelcre = value;
    nossbcre.text = value.namaSbb;
    namaSbbCre.text = value.nosbb;
    notifyListeners();
  }

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

  TextEditingController nominal = TextEditingController();
  TextEditingController tglTransaksiText = TextEditingController();
  TextEditingController tglBackDatetext = TextEditingController();
  TextEditingController nomorDok = TextEditingController();
  TextEditingController nomorRef = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  bool dialog = false;
  tambah() {
    clear();
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

  clear() {
    setupTransModel = null;
    namaTransaksi.clear();
    nomorDok.clear();
    nomorRef.clear();
    sbbAset = null;
    namaSbbCre.clear();
    nossbcre.clear();
    nosbbdeb.clear();
    namaSbbDeb.clear();
    sbbpenyusutan = null;
    nominal.clear();
    keterangan.clear();
    aoModel = null;
    aoModelKRedit = null;
  }

  List<SetupTransModel> listData = [];

  TextEditingController namaSbbAset = TextEditingController();
  TextEditingController namaTransaksi = TextEditingController();
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

  // List<AoModel> listAo = [];
  AoModel? aoModel;
  AoModel? aoModelKRedit;
  pilihAoModelDebet(AoModel value) {
    aoModel = value;
    notifyListeners();
  }

  final keyForm = GlobalKey<FormState>();

  cek() {
    if (keyForm.currentState!.validate()) {}
  }

  cancelKode() async {
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

  pilihAoModelKredit(AoModel value) {
    aoModelKRedit = value;
    notifyListeners();
  }
}
