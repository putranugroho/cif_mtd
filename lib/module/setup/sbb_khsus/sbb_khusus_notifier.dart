import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';

import '../../../models/coa_model.dart';
import '../../../models/inquery_gl_model.dart';
import '../../../network/network.dart';

class SbbKhususNotifier extends ChangeNotifier {
  final BuildContext context;

  SbbKhususNotifier({required this.context}) {
    getInquery();
    getGolonganSbb();
    notifyListeners();
  }
  var isLoading = true;
  List<GolonganSbbKhususModel> listGolongan = [];
  GolonganSbbKhususModel? golonganSbbKhususModel;
  pilihGolongan(GolonganSbbKhususModel value) {
    golonganSbbKhususModel = value;
    notifyListeners();
  }

  Future getGolonganSbb() async {
    isLoading = true;
    listGolongan.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getGolonganSbb(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listGolongan.add(GolonganSbbKhususModel.fromJson(i));
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  List<Map<String, dynamic>> extractJnsAccB(List<dynamic> items) {
    List<Map<String, dynamic>> result = [];

    for (var item in items) {
      if (item['jns_acc'] == 'B') {
        result.add(item as Map<String, dynamic>);
      }

      if (item['items'] != null && item['items'] is List) {
        result.addAll(extractJnsAccB(item['items']));
      }
    }

    return result;
  }

  var isLoadingInquery = true;
  List<InqueryGlModel> listGl = [];
  List<InqueryGlModel> listGlAdd = [];
  Future getInquery() async {
    isLoadingInquery = true;
    listGl.clear();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getInqueryGL(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        final List<Map<String, dynamic>> jnsAccBItems =
            extractJnsAccB(value['data']);
        for (Map<String, dynamic> i in jnsAccBItems) {
          listGl.add(InqueryGlModel.fromJson(i));
        }
        print(listGl.length);
        isLoadingInquery = false;
        notifyListeners();
      } else {
        isLoadingInquery = false;
        notifyListeners();
      }
    });
  }

  pilihCoa(InqueryGlModel value) {
    if (listGlAdd.isEmpty) {
      listGlAdd.add(value);
    } else {
      if (listGlAdd.where((e) => e == value).isNotEmpty) {
        listGlAdd.remove(value);
      } else {
        listGlAdd.add(value);
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

  InqueryGlModel? inqueryGlModel;
  pilihSbbSatu(InqueryGlModel value) {
    inqueryGlModel = value;
    notifyListeners();
  }

  TextEditingController noBb = TextEditingController();
  pilihBB(CoaModel value) {
    bukuBesar = value;
    noBb.text = value.nosbb;

    notifyListeners();
  }

  CoaModel? bukuBesar;
}
