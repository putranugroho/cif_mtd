import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';

class AksesPointNotifier extends ChangeNotifier {
  final BuildContext context;

  AksesPointNotifier({required this.context}) {
    getAksesPoint();
    getKantor();
  }

  TextEditingController noKantor = TextEditingController();
  pilihKantor(KantorModel value) {
    kantor = value;
    noKantor.text = value.kodeKantor;
    notifyListeners();
  }

  cek() {
    if (keyForm.currentState!.validate()) {}
  }

  confirm() {}

  final keyForm = GlobalKey<FormState>();

  getAksesPoint() async {}
  List<KantorModel> list = [];
  var isLoading = true;
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

  TextEditingController noAkses = TextEditingController();
  TextEditingController aksesId = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController keterangan = TextEditingController();

  List<String> tipeLokasi = [
    "Kantor",
    "Luar Kantor",
    "Karyawan",
  ];

  List<String> tipeAkses = [
    "LAN",
    "WIFI",
  ];
  String? akses;
  pilihAkses(String value) {
    akses = value;
    notifyListeners();
  }

  String? lokasi;
  pilihlokasi(String value) {
    lokasi = value;
    notifyListeners();
  }

  var dialog = false;
  var editData = false;
  tambah() {
    dialog = true;
    noAkses.clear();
    aksesId.clear();
    alamat.clear();
    keterangan.clear();
    lokasi = null;
    akses = null;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }
}
