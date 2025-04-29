import 'dart:convert';

import 'package:accounting/models/index.dart';
import 'package:accounting/network/network.dart';
import 'package:accounting/repository/SetupRepository.dart';
import 'package:accounting/utils/dialog_loading.dart';
import 'package:flutter/material.dart';

class LevelUserNotifier extends ChangeNotifier {
  final BuildContext context;

  LevelUserNotifier({required this.context}) {
    getModul();
  }

  var dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  var editData = false;

  final keyForm = GlobalKey<FormState>();
  cek() {
    if (keyForm.currentState!.validate()) {
      DialogCustom().showLoading(context);
      print(jsonEncode(listModulAdd));
    }
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  TextEditingController levelUsers = TextEditingController();
  var isLoading = true;
  List<ModulModel> listModul = [];
  List<ModulModel> listModulAdd = [];
  pilihModul(ModulModel value) async {
    if (listModulAdd.isEmpty) {
      listModulAdd.add(value);
    } else {
      if (listModulAdd.where((e) => e == value).isNotEmpty) {
        listModulAdd.remove(value);
      } else {
        listModulAdd.add(value);
      }
    }

    notifyListeners();
  }

  Future getModul() async {
    isLoading = true;
    listModul.clear();
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getModul(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        for (Map<String, dynamic> i in value['data']) {
          listModul.add(ModulModel.fromJson(i));
        }
        getLevelusers();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  Future getLevelusers() async {
    isLoading = true;
    notifyListeners();
    var data = {"kode_pt": "001"};
    Setuprepository.setup(token, NetworkURL.getLevelUsers(), jsonEncode(data))
        .then((value) {
      if (value['status'].toString().toLowerCase().contains("success")) {
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    });
  }
}
