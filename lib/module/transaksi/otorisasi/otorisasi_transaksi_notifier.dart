import 'dart:convert';

import 'package:cif/models/index.dart';
import 'package:cif/pref/pref.dart';
import 'package:cif/utils/dialog_loading.dart';
import 'package:cif/utils/informationdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../network/network.dart';
import '../../../repository/SetupRepository.dart';

class OtorisasiTransaksiNotifier extends ChangeNotifier {
  final BuildContext context;

  OtorisasiTransaksiNotifier({required this.context}) {
    getProfile();
    notifyListeners();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getTransaksi();
      notifyListeners();
    });
  }

  var isLoadingData = true;
  List<TransaksiPendModel> listTransaksi = [];
  List<TransaksiPendModel> listTransasiAdd = [];
  Future getTransaksi() async {
    isLoadingData = true;
    listTransaksi.clear();
    notifyListeners();
    var data = {
      "kode_pt": users!.kodePt,
    };
    Setuprepository.setup(token, NetworkURL.view(), jsonEncode(data)).then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listTransaksi.add(TransaksiPendModel.fromJson(i));
        }
        if (listTransaksi.isNotEmpty) {
          listTransasiAdd = users!.levelOtor == "null"
              ? []
              : users!.bedaKantor == "Y"
                  ? listTransaksi
                      .where((e) =>
                          e.status == "PENDING" &&
                          ((double.parse(e.nominal) > double.parse(users!.minOtor)) && (double.parse(e.nominal) <= double.parse(users!.maxOtor))))
                      .toList()
                  : listTransaksi
                      .where((e) =>
                          (e.status == "PENDING") &&
                          ((double.parse(e.nominal) > double.parse(users!.minOtor)) && (double.parse(e.nominal) <= double.parse(users!.maxOtor))) &&
                          e.kodeKantor == users!.kodeKantor)
                      .toList();
        }
        isLoadingData = false;
        notifyListeners();
      } else {
        isLoadingData = false;
        notifyListeners();
      }
    });
  }

  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  OtorisasiModel? otorisasiModel;
  var dialog = false;
  TransaksiPendModel? transaksiPendModel;
  edit(String data) {
    transaksiPendModel = listTransaksi.where((e) => e.rrn == data).first;
    dialog = true;
    notifyListeners();
  }

  confirm() {
    DialogCustom().showLoading(context);
    var data = {
      "kode_pt": transaksiPendModel!.kodePt,
      "rrn": transaksiPendModel!.rrn,
      "otoruser": users!.namauser,
      "otorinput": DateFormat('y-MM-dd HH:mm:ss').format(DateTime.now()),
    };
    Setuprepository.setup(token, NetworkURL.otorisasiTransaksi(), jsonEncode(data)).then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        getTransaksi();
        dialog = false;
        transaksiPendModel = null;
        notifyListeners();
        informationDialog(context, "Information", value['message']);
      } else {
        informationDialog(context, "Information", value['message']);
      }
    });
  }

  close() {
    dialog = false;
    notifyListeners();
  }
}
