import 'package:flutter/material.dart';

import '../../../models/coa_model.dart';

class SbbKhususNotifier extends ChangeNotifier {
  final BuildContext context;

  SbbKhususNotifier({required this.context}) {
    for (Map<String, dynamic> i in data) {
      list.add(CoaModel.fromJson(i));
    }
    for (var i = 0; i < list.where((e) => e.jnsAcc == "C").length; i++) {
      final data = list.where((e) => e.jnsAcc == "C").toList()[i];
      listSbb.add(TextEditingController(text: data.nosbb));
      listNama.add(TextEditingController(text: data.namaSbb));
    }
    notifyListeners();
  }

  List<TextEditingController> listSbb = [];
  List<TextEditingController> listNama = [];
  List<CoaModel> list = [];
  List<CoaModel> listAdd = [];
  CoaModel? coaModel;
  pilihCoa(CoaModel value) {
    if (listAdd.isEmpty) {
      listAdd.add(value);
    } else {
      if (listAdd.where((e) => e == value).isNotEmpty) {
        listAdd.remove(value);
      } else {
        listAdd.add(value);
      }
      notifyListeners();
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

  delete(int index) {
    listSbb.removeAt(index);
    listNama.removeAt(index);
    notifyListeners();
  }

  TextEditingController noBb = TextEditingController();
  pilihBB(CoaModel value) {
    bukuBesar = value;
    noBb.text = value.nosbb;

    notifyListeners();
  }

  List<String> listSbbTambahanKhusus = [];

  List<String> listSBBKhusus = [
    "Arus Kas",
    "LR Berjalan",
    "LR Tahun Lalu",
  ];

  String? sbbKhusus;
  pilihSbbKhusus(String value) {
    sbbKhusus = value;
    notifyListeners();
  }

  CoaModel? bukuBesar;

  tambahParameter() {
    listSbb.add(TextEditingController(text: ""));
    notifyListeners();
  }

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
