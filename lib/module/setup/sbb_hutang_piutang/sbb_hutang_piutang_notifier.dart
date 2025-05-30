import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utils/dialog_loading.dart';
import '../../../utils/informationdialog.dart';

class SbbHutangPiutangNotifier extends ChangeNotifier {
  final BuildContext context;

  SbbHutangPiutangNotifier({required this.context}) {
    // getSetupTrans();

    getInqueryAll();
    notifyListeners();
  }

  TextEditingController namasbblawanhutang = TextEditingController();
  TextEditingController namasbblawanpiutang = TextEditingController();
  TextEditingController namasbbhpppiutang = TextEditingController();
  TextEditingController namasbbpersedianpiutang = TextEditingController();

  TextEditingController sbblawanhutang = TextEditingController();
  TextEditingController sbblawanpiutang = TextEditingController();
  TextEditingController sbbhpppiutang = TextEditingController();
  TextEditingController sbbpersedianpiutang = TextEditingController();

  List<SetupHutangPiutangModel> listData = [];
  SetupHutangPiutangModel? setupHutangPiutangModel;
  Future getSetupkaskecil() async {
    isLoading = true;
    listData.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(
            token, NetworkURL.getSetupHutangPiutang(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listData.add(SetupHutangPiutangModel.fromJson(i));
        }
        if (list.isNotEmpty) {
          setupHutangPiutangModel = listData[0];
          nmSbbTransHutang.text =
              setupHutangPiutangModel!.namasbbtransaksihutang;
          noSbbTransHutang.text = setupHutangPiutangModel!.sbbtransaksihutang;
          nmSbbPpnHutang.text = setupHutangPiutangModel!.namasbbppnhutang;
          noSbbPpnHutang.text = setupHutangPiutangModel!.sbbppnhutang;
          nmSbbPphHutang.text = setupHutangPiutangModel!.namasbbpphhutang;
          noSbbPphHutang.text = setupHutangPiutangModel!.sbbpphhutang;
          sbblawanhutang.text = setupHutangPiutangModel!.sbblawanhutang;
          sbblawanpiutang.text = setupHutangPiutangModel!.sbblawanpiutang;
          sbbhpppiutang.text = setupHutangPiutangModel!.sbbhpppiutang;
          sbbpersedianpiutang.text =
              setupHutangPiutangModel!.sbbpersedianpiutang;
          nmSbbTransPiutang.text =
              setupHutangPiutangModel!.namasbbtransaksipiutang;
          noSbbTransPiutang.text = setupHutangPiutangModel!.sbbtransaksipiutang;
          nmSbbPpnPiutang.text = setupHutangPiutangModel!.namasbbppnpiutang;
          noSbbPpnPiutang.text = setupHutangPiutangModel!.sbbppnpiutang;
          nmSbbPphPiutang.text = setupHutangPiutangModel!.namasbbpphpiutang;
          noSbbPphPiutang.text = setupHutangPiutangModel!.sbbpphpiutang;
          namasbblawanhutang.text = setupHutangPiutangModel!.namasbblawanhutang;
          namasbblawanpiutang.text =
              setupHutangPiutangModel!.namasbblawanpiutang;
          namasbbhpppiutang.text = setupHutangPiutangModel!.namasbbhpppiutang;
          namasbbpersedianpiutang.text =
              setupHutangPiutangModel!.namasbbpersedianpiutang;
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future getInqueryAll() async {
    isLoading = true;
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
        getSetupkaskecil();
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

  InqueryGlModel? inqueryGlModeldeb;
  InqueryGlModel? inqueryGlModelcre;
  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
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

  pilihTransHutang(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nmSbbTransHutang.text = value.namaSbb;
    noSbbTransHutang.text = value.nosbb;
    notifyListeners();
  }

  pilihPpnHutang(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nmSbbPpnHutang.text = value.namaSbb;
    noSbbPpnHutang.text = value.nosbb;
    notifyListeners();
  }

  pilihPphHutang(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nmSbbPphHutang.text = value.namaSbb;
    noSbbPphHutang.text = value.nosbb;
    notifyListeners();
  }

  pilihTransPiutang(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nmSbbTransPiutang.text = value.namaSbb;
    noSbbTransPiutang.text = value.nosbb;
    notifyListeners();
  }

  pilihPpnPiutang(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nmSbbPpnPiutang.text = value.namaSbb;
    noSbbPpnPiutang.text = value.nosbb;
    notifyListeners();
  }

  pilihPphPiutang(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    nmSbbPphPiutang.text = value.namaSbb;
    noSbbPphPiutang.text = value.nosbb;
    notifyListeners();
  }

  pilihlawanhutang(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    namasbblawanhutang.text = value.namaSbb;
    sbblawanhutang.text = value.nosbb;
    notifyListeners();
  }

  pilihlawanpiutang(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    namasbblawanpiutang.text = value.namaSbb;
    sbblawanpiutang.text = value.nosbb;
    notifyListeners();
  }

  pilihhpp(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    namasbbhpppiutang.text = value.namaSbb;
    sbbhpppiutang.text = value.nosbb;
    notifyListeners();
  }

  pilihpersediaan(InqueryGlModel value) {
    inqueryGlModeldeb = value;
    namasbbpersedianpiutang.text = value.namaSbb;
    sbbpersedianpiutang.text = value.nosbb;
    notifyListeners();
  }

  List<InqueryGlModel> list = [];

  var isLoading = false;
  TextEditingController nmSbbTransHutang = TextEditingController();
  TextEditingController noSbbTransHutang = TextEditingController();
  TextEditingController nmSbbPpnHutang = TextEditingController();
  TextEditingController noSbbPpnHutang = TextEditingController();
  TextEditingController nmSbbPphHutang = TextEditingController();
  TextEditingController noSbbPphHutang = TextEditingController();

  TextEditingController nmSbbTransPiutang = TextEditingController();
  TextEditingController noSbbTransPiutang = TextEditingController();
  TextEditingController nmSbbPpnPiutang = TextEditingController();
  TextEditingController noSbbPpnPiutang = TextEditingController();
  TextEditingController nmSbbPphPiutang = TextEditingController();
  TextEditingController noSbbPphPiutang = TextEditingController();

  cek() {
    DialogCustom().showLoading(context);
    var data = {
      "kode_pt": "001",
      "sbbtransaksihutang": "${noSbbTransHutang.text}",
      "sbbpphhutang": "${noSbbPphHutang.text}",
      "sbbppnhutang": "${noSbbPpnHutang.text}",
      "sbbtransaksipiutang": "${noSbbTransPiutang.text}",
      "sbbppnpiutang": "${noSbbPpnPiutang.text}",
      "sbbpphpiutang": "${noSbbPphPiutang.text}",
      "sbblawanhutang": "${sbblawanhutang.text}",
      "sbblawanpiutang": "${sbblawanpiutang.text}",
      "sbbhpppiutang": "${sbbhpppiutang.text}",
      "sbbpersedianpiutang": "${sbbpersedianpiutang.text}",
      "namasbbtransaksihutang": "${nmSbbTransHutang.text}",
      "namasbbpphhutang": "${nmSbbPphHutang.text}",
      "namasbbppnhutang": "${nmSbbPpnHutang.text}",
      "namasbbtransaksipiutang": "${nmSbbTransPiutang.text}",
      "namasbbpphpiutang": "${nmSbbPphPiutang.text}",
      "namasbbppnpiutang": "${nmSbbPpnPiutang.text}",
      "namasbblawanhutang": "${namasbblawanhutang.text}",
      "namasbblawanpiutang": "${namasbblawanpiutang.text}",
      "namasbbhpppiutang": "${namasbbhpppiutang.text}",
      "namasbbpersedianpiutang": "${namasbbpersedianpiutang.text}",
    };
    Setuprepository.setup(
            token, NetworkURL.addSetupHutangPiutang(), jsonEncode(data))
        .then((value) {
      Navigator.pop(context);
      if (value['status'].toString().toLowerCase().contains("success")) {
        informationDialog(context, "Information", value['message']);
        notifyListeners();
      } else {
        informationDialog(context, "Warning", value['message'][0]);
        notifyListeners();
      }
    });
  }
}
