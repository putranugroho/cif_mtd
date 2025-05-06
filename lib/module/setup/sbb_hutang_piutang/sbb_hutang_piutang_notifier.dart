import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SbbHutangPiutangNotifier extends ChangeNotifier {
  final BuildContext context;

  SbbHutangPiutangNotifier({required this.context}) {
    // getSetupTrans();

    getInqueryAll();
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
}
