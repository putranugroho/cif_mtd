import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:flutter/material.dart';

import '../../../utils/informationdialog.dart';

class PenyusutanNotifier extends ChangeNotifier {
  final BuildContext context;

  PenyusutanNotifier({required this.context}) {
    getMetodePenyusutan();
  }
  var isLoading = true;
  final keyForm = GlobalKey<FormState>();
  List<MetodePenyusutanModel> list = [];
  MetodePenyusutanModel? metodePenyusutanModel;
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
        isLoading = false;
        notifyListeners();
      } else {
        // informationDialog(context, "Warning", value['message'][0]);
        notifyListeners();
      }
    });
    notifyListeners();
  }

  int metode = 0;

  gantimetode(int value) {
    metode = value;
    notifyListeners();
  }

  TextEditingController nilai = TextEditingController(text: "0");
  TextEditingController declining = TextEditingController(text: "0");

  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      var data = {
        "id": metodePenyusutanModel!.id,
        "metode_penyusutan": "$metode",
        "nilai_akhir": "${nilai.text}",
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
