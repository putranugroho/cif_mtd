import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/pref/pref.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:flutter/material.dart';

import '../../../utils/informationdialog.dart';

class PenyusutanNotifier extends ChangeNotifier {
  final BuildContext context;

  PenyusutanNotifier({required this.context}) {
    getProfile();
  }

  UserModel? users;
  getProfile() async {
    Pref().getUsers().then((value) {
      users = value;
      getInqueryAll();
      notifyListeners();
    });
  }

  List<InqueryGlModel> listGlAll = [];
  Future getInqueryAll() async {
    listGlAll.clear();
    notifyListeners();
    var data = {"kode_pt": users!.kodePt};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccB(value['data']);
        listGlAll =
            jnsAccBItems.map((item) => InqueryGlModel.fromJson(item)).toList();
        getMetodePenyusutan();
        notifyListeners();
      }
    });
  }

  var isLoading = true;
  final keyForm = GlobalKey<FormState>();
  List<MetodePenyusutanModel> list = [];
  MetodePenyusutanModel? metodePenyusutanModel;
  TextEditingController nilai = TextEditingController(text: "0");
  TextEditingController declining = TextEditingController(text: "0");
  Future getMetodePenyusutan() async {
    isLoading = true;
    list.clear();
    var data = {
      "kode_pt": "001",
    };
    notifyListeners();
    Setuprepository.setup(
            token, NetworkURL.getMetodePenyusutan(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          list.add(MetodePenyusutanModel.fromJson(i));
        }
        metodePenyusutanModel = list[0];
        metode = int.parse(metodePenyusutanModel!.metodePenyusutan);
        nilai.text = metodePenyusutanModel!.nilaiAkhir.toString();
        declining.text = metodePenyusutanModel!.declining.toString();
        sbbAset = listGlAll
                .where((e) => e.nosbb == metodePenyusutanModel!.sbbPendapatan)
                .isNotEmpty
            ? listGlAll
                .where((e) => e.nosbb == metodePenyusutanModel!.sbbPendapatan)
                .first
            : null;
        namasbbaset.text = sbbAset == null ? "" : sbbAset!.namaSbb;
        nosbbaset.text = sbbAset == null ? "" : sbbAset!.nosbb;
        isLoading = false;
        notifyListeners();
      } else {
        // informationDialog(context, "Warning", value['message'][0]);
        notifyListeners();
      }
    });
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

  InqueryGlModel? sbbAset;
  TextEditingController namasbbaset = TextEditingController();
  TextEditingController nosbbaset = TextEditingController();

  pilihSbbAset(InqueryGlModel value) {
    sbbAset = value;
    namasbbaset.text = value.namaSbb;
    nosbbaset.text = value.nosbb;
    notifyListeners();
  }

  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];

  Future<List<InqueryGlModel>> getInquerySbbAset(String query) async {
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
              .where((model) => (model.nosbb
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  model.namaSbb.toLowerCase().contains(query.toLowerCase())))
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

  int metode = 0;

  gantimetode(int value) {
    metode = value;
    notifyListeners();
  }

  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      var data = {
        "id": metodePenyusutanModel!.id,
        "metode_penyusutan": "$metode",
        "nilai_akhir": nilai.text,
        "sbb_pendapatan": sbbAset!.nosbb,
        "nama_sbb_pendapatan": sbbAset!.namaSbb,
        "declining": "${metode == 2 ? declining.text : 0}",
      };
      Setuprepository.setup(
              token, NetworkURL.editMetodePenyusutan(), jsonEncode(data))
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
}
