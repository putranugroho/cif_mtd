import 'package:accounting/models/index.dart';
import 'package:flutter/material.dart';

class AoNotifier extends ChangeNotifier {
  final BuildContext context;

  AoNotifier({required this.context}) {
    for (Map<String, dynamic> i in json) {
      list.add(AoModel.fromJson(i));
    }
    notifyListeners();
  }

  TextEditingController kd = TextEditingController();
  TextEditingController nm = TextEditingController();

  bool dialog = false;
  tambah() {
    dialog = true;
    notifyListeners();
  }

  tutup() {
    dialog = false;
    notifyListeners();
  }

  List<AoModel> list = [];
  List<Map<String, dynamic>> json = [
    {
      "kd_ao": "1001",
      "nm_ao": "Account Officer 1",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": "",
    },
    {
      "kd_ao": "1002",
      "nm_ao": "Account Officer 2",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": "",
    },
    {
      "kd_ao": "1003",
      "nm_ao": "Marketing",
      "kode_pt": "001",
      "kode_kantor": "1001",
      "kode_induk": "",
    },
  ];
}
