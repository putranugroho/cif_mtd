import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';

import '../../../network/network.dart';
import '../../../utils/dialog_loading.dart';
import '../../../utils/informationdialog.dart';

class CustomerNotifier extends ChangeNotifier {
  final BuildContext context;

  CustomerNotifier({required this.context}) {
    getCustomers();
    notifyListeners();
  }

  List<CustomerSupplierModel> list = [];
  var isLoading = true;
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

  clear() {
    dialog = false;
    editData = false;
    customerSupplierModel = null;
    noSif.clear();
    namaSif.clear();
    golCust = "Customer";
    bidangUsaha.clear();
    alamat.clear();
    kelurahan.clear();
    kecamatan.clear();
    kota.clear();
    provinsi.clear();
    kodepos.clear();
    npwp.clear();
    notelp.clear();
    email.clear();
    kontak1.clear();
    hp1.clear();
    email1.clear();
    keterangan1.clear();
    kontak2.clear();
    hp2.clear();
    email2.clear();
    keterangan2.clear();
    kontak3.clear();
    hp3.clear();
    email3.clear();
    keterangan3.clear();
    notifyListeners();
  }

  CustomerSupplierModel? customerSupplierModel;
  final keyForm = GlobalKey<FormState>();
  var editData = false;
  cek() {
    if (keyForm.currentState!.validate()) {
      if (editData) {
        DialogCustom().showLoading(context);
        var data = {
          "id": customerSupplierModel!.id,
          "kode_pt": "${customerSupplierModel!.kodePt}",
          "no_sif": "${noSif.text.trim()}",
          "nm_sif": "${namaSif.text.trim()}",
          "gol_cust":
              "${golCust == "Customer" ? 1 : golCust == "Supplier" ? 2 : 3}",
          "bidang_usaha": "${bidangUsaha.text}",
          "alamat": "${alamat.text.trim()}",
          "kelurahan": "${kelurahan.text.trim()}",
          "kecamatan": "${kecamatan.text.trim()}",
          "kota": "${kota.text.trim()}",
          "provinsi": "${provinsi.text.trim()}",
          "kdpos": "${kodepos.text.trim()}",
          "npwp": "${npwp.text.trim()}",
          "pkp": "${pkp ? "Y" : "N"}",
          "no_telp": "${notelp.text.trim()}",
          "email": "${email.text.trim()}",
          "kontak1": "${kontak1.text.trim()}",
          "hp1": "${hp1.text.trim()}",
          "email1": "${email1.text.trim()}",
          "keterangan1": "${keterangan1.text.trim()}",
          "kontak2": "${kontak2.text.trim()}",
          "hp2": "${hp2.text.trim()}",
          "email2": "${email2.text.trim()}",
          "keterangan2": "${keterangan2.text.trim()}",
          "kontak3": "${kontak3.text.trim()}",
          "hp3": "${hp3.text.trim()}",
          "email3": "${email3.text.trim()}",
          "keterangan3": "${keterangan3.text.trim()}"
        };
        // print(jsonEncode(data));
        Setuprepository.setup(
                token, NetworkURL.editCustomer(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getCustomers();
            clear();
            informationDialog(context, "Information", value['message']);
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      } else {
        DialogCustom().showLoading(context);
        var data = {
          "kode_pt": "${customerSupplierModel!.kodePt}",
          "no_sif": "${noSif.text.trim()}",
          "nm_sif": "${namaSif.text.trim()}",
          "gol_cust":
              "${golCust == "Customer" ? 1 : golCust == "Supplier" ? 2 : 3}",
          "bidang_usaha": "${bidangUsaha.text}",
          "alamat": "${alamat.text.trim()}",
          "kelurahan": "${kelurahan.text.trim()}",
          "kecamatan": "${kecamatan.text.trim()}",
          "kota": "${kota.text.trim()}",
          "provinsi": "${provinsi.text.trim()}",
          "kdpos": "${kodepos.text.trim()}",
          "npwp": "${npwp.text.trim()}",
          "pkp": "${pkp ? "Y" : "N"}",
          "no_telp": "${notelp.text.trim()}",
          "email": "${email.text.trim()}",
          "kontak1": "${kontak1.text.trim()}",
          "hp1": "${hp1.text.trim()}",
          "email1": "${email1.text.trim()}",
          "keterangan1": "${keterangan1.text.trim()}",
          "kontak2": "${kontak2.text.trim()}",
          "hp2": "${hp2.text.trim()}",
          "email2": "${email2.text.trim()}",
          "keterangan2": "${keterangan2.text.trim()}",
          "kontak3": "${kontak3.text.trim()}",
          "hp3": "${hp3.text.trim()}",
          "email3": "${email3.text.trim()}",
          "keterangan3": "${keterangan3.text.trim()}"
        };
        Setuprepository.setup(token, NetworkURL.addBank(), jsonEncode(data))
            .then((value) {
          Navigator.pop(context);
          if (value['status'].toString().toLowerCase().contains("success")) {
            getCustomers();
            clear();
            informationDialog(context, "Information", value['message']);
          } else {
            informationDialog(context, "Warning", value['message']);
          }
        });
      }
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

  TextEditingController noSif = TextEditingController();
  TextEditingController namaSif = TextEditingController();
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
  List<String> listGolCust = [
    "Customer",
    "Supplier",
    "Customer dan Supplier",
  ];
  String? golCust;
  pilihGolCust(String value) {
    golCust = value;
    notifyListeners();
  }

  bool pkp = false;
  pilihPkp(bool value) {
    pkp = value;
    notifyListeners();
  }

  List<AoModel> listAo = [];
  AoModel? aoModel;
  AoModel? aoModelKRedit;
  pilihAoModelDebet(AoModel value) {
    aoModel = value;
    notifyListeners();
  }

  pilihAoModelKredit(AoModel value) {
    aoModelKRedit = value;
    notifyListeners();
  }
}
