import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../network/network.dart';
import '../../../repository/wilayah_repository.dart';
import '../../../utils/button_custom.dart';
import '../../../utils/dialog_loading.dart';
import '../../../utils/informationdialog.dart';

class AksesPointNotifier extends ChangeNotifier {
  final BuildContext context;

  AksesPointNotifier({required this.context}) {
    getAoMarketing();
    notifyListeners();
  }

  List<AoModel> listAoModel = [];
  var isLoading = true;
  getAoMarketing() async {
    isLoading = true;
    listAoModel.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getAoMarketing(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listAoModel.add(AoModel.fromJson(i));
        }
        getCustomers();
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<CustomerSupplierModel> list = [];
  getCustomers() async {
    isLoading = true;
    list.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getCustomer(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(CustomerSupplierModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  CustomerSupplierModel? customerSupplierModel;
  final keyForm = GlobalKey<FormState>();
  var editData = false;
  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      informationDialog(context, "Information", "Test");
    }
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

  bool lokasi = true;
  pilihLokasi(bool value) {
    lokasi = value;
    notifyListeners();
  }

  bool typeAkses = true;
  pilihTypeAkses(bool value) {
    typeAkses = value;
    notifyListeners();
  }

  List<AoModel> listAo = [];
  AoModel? aoModel;
  AoModel? aoModelKRedit;
  pilihAoModelDebet(AoModel value) {
    aoModel = value;
    notifyListeners();
  }

  confirm() async {}

  edit(String id) async {}

  TextEditingController noAkses = TextEditingController();
  TextEditingController aksesId = TextEditingController();
  TextEditingController bidangUsaha = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController provinsi = TextEditingController();
  TextEditingController kota = TextEditingController();
  TextEditingController kecamatan = TextEditingController();
  TextEditingController kodepos = TextEditingController();
  TextEditingController npwp = TextEditingController();
  TextEditingController kelurahan = TextEditingController();
  TextEditingController notelp = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController kontak1 = TextEditingController();
  TextEditingController hp1 = TextEditingController();
  TextEditingController email1 = TextEditingController();
  TextEditingController keterangan1 = TextEditingController();
  TextEditingController kontak2 = TextEditingController();
  TextEditingController hp2 = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController keterangan2 = TextEditingController();
  TextEditingController kontak3 = TextEditingController();
  TextEditingController hp3 = TextEditingController();
  TextEditingController email3 = TextEditingController();
  TextEditingController keterangan3 = TextEditingController();
}
